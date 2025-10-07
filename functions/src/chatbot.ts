import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import OpenAI from 'openai';

const openai = new OpenAI({
  apiKey: functions.config().openai?.api_key || process.env.OPENAI_API_KEY,
});

interface ChatRequest {
  message: string;
  userId: string;
  userLocation?: string;
  userLanguage?: string;
  conversationId?: string;
}

interface ChatResponse {
  response: string;
  conversationId: string;
  suggestions?: string[];
  quickReplies?: string[];
}

export async function chatbotHandler(req: functions.Request, res: functions.Response) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    const { message, userId, userLocation, userLanguage, conversationId }: ChatRequest = req.body;

    if (!message || !userId) {
      return res.status(400).json({ error: 'Message and userId are required' });
    }

    const db = admin.firestore();
    
    // Get or create conversation
    let convId = conversationId;
    if (!convId) {
      const convRef = await db.collection('conversations').add({
        userId,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        messages: []
      });
      convId = convRef.id;
    }

    // Store user message
    await db.collection('conversations').doc(convId).collection('messages').add({
      text: message,
      isUser: true,
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
      userLocation,
      userLanguage
    });

    // Get conversation history for context
    const messagesSnapshot = await db.collection('conversations')
      .doc(convId)
      .collection('messages')
      .orderBy('timestamp', 'desc')
      .limit(10)
      .get();

    const conversationHistory = messagesSnapshot.docs
      .reverse()
      .map(doc => doc.data())
      .slice(-5); // Last 5 messages for context

    // Get relevant knowledge base documents using RAG
    const relevantDocs = await getRelevantDocuments(message, userLocation);
    
    // Generate response using OpenAI with RAG context
    const response = await generateResponse(message, conversationHistory, relevantDocs, userLocation, userLanguage);

    // Store AI response
    await db.collection('conversations').doc(convId).collection('messages').add({
      text: response,
      isUser: false,
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
      userLocation,
      userLanguage
    });

    // Generate suggestions and quick replies
    const suggestions = generateSuggestions(message, userLocation);
    const quickReplies = generateQuickReplies(userLocation);

    const chatResponse: ChatResponse = {
      response,
      conversationId: convId,
      suggestions,
      quickReplies
    };

    return res.status(200).json(chatResponse);

  } catch (error) {
    console.error('Chatbot error:', error);
    return res.status(500).json({ error: 'Failed to process message' });
  }
}

async function getRelevantDocuments(query: string, userLocation?: string): Promise<string[]> {
  try {
    // Generate embedding for the query
    const queryEmbedding = await generateEmbedding(query);
    
    // Search for similar documents in Firestore
    const db = admin.firestore();
    const knowledgeBase = db.collection('knowledge_base');
    
    // This is a simplified RAG implementation
    // In production, you'd use a vector database like Pinecone or Weaviate
    const docs = await knowledgeBase
      .where('category', 'in', getRelevantCategories(query))
      .limit(5)
      .get();

    return docs.docs.map(doc => doc.data().content);
  } catch (error) {
    console.error('Error getting relevant documents:', error);
    return [];
  }
}

async function generateEmbedding(text: string): Promise<number[]> {
  try {
    const response = await openai.embeddings.create({
      model: "text-embedding-ada-002",
      input: text,
    });
    return response.data[0].embedding;
  } catch (error) {
    console.error('Error generating embedding:', error);
    return [];
  }
}

function getRelevantCategories(query: string): string[] {
  const categories = [];
  const lowerQuery = query.toLowerCase();
  
  if (lowerQuery.includes('food') || lowerQuery.includes('eat') || lowerQuery.includes('restaurant')) {
    categories.push('food');
  }
  if (lowerQuery.includes('place') || lowerQuery.includes('visit') || lowerQuery.includes('attraction')) {
    categories.push('places');
  }
  if (lowerQuery.includes('culture') || lowerQuery.includes('tradition') || lowerQuery.includes('custom')) {
    categories.push('culture');
  }
  if (lowerQuery.includes('language') || lowerQuery.includes('amharic') || lowerQuery.includes('learn')) {
    categories.push('language');
  }
  if (lowerQuery.includes('transport') || lowerQuery.includes('travel') || lowerQuery.includes('bus')) {
    categories.push('transportation');
  }
  
  return categories.length > 0 ? categories : ['general'];
}

async function generateResponse(
  message: string, 
  conversationHistory: any[], 
  relevantDocs: string[],
  userLocation?: string,
  userLanguage?: string
): Promise<string> {
  try {
    const systemPrompt = `You are Selam, an AI assistant specialized in helping tourists in Ethiopia. 
    You have extensive knowledge about Ethiopian culture, food, places, language, and travel.
    ${userLocation ? `The user is currently in ${userLocation}.` : ''}
    ${userLanguage ? `The user's native language is ${userLanguage}.` : ''}
    
    Provide helpful, accurate, and culturally sensitive information about Ethiopia.
    If asked about Amharic language, provide pronunciation guides and cultural context.
    Always be welcoming and encourage exploration of Ethiopian culture.`;

    const contextDocs = relevantDocs.length > 0 ? 
      `\n\nRelevant information:\n${relevantDocs.join('\n')}` : '';

    const conversationContext = conversationHistory.length > 0 ?
      `\n\nPrevious conversation:\n${conversationHistory.map(msg => 
        `${msg.isUser ? 'User' : 'Assistant'}: ${msg.text}`
      ).join('\n')}` : '';

    const fullPrompt = `${systemPrompt}${contextDocs}${conversationContext}\n\nUser: ${message}\n\nAssistant:`;

    const completion = await openai.chat.completions.create({
      model: "gpt-3.5-turbo",
      messages: [
        { role: "system", content: systemPrompt },
        { role: "user", content: message }
      ],
      max_tokens: 500,
      temperature: 0.7,
    });

    return completion.choices[0].message.content || "I'm sorry, I couldn't generate a response.";
  } catch (error) {
    console.error('Error generating response:', error);
    return getFallbackResponse(message);
  }
}

function getFallbackResponse(message: string): string {
  const lowerMessage = message.toLowerCase();
  
  if (lowerMessage.includes('hello') || lowerMessage.includes('hi')) {
    return "Selam! Welcome to Ethiopia! 🇪🇹 I'm here to help you explore this beautiful country. What would you like to know about Ethiopian culture, food, places, or language?";
  }
  
  if (lowerMessage.includes('food') || lowerMessage.includes('eat')) {
    return "Ethiopian cuisine is amazing! You should try injera (sourdough flatbread), doro wat (spicy chicken stew), and kitfo (minced raw beef). Don't forget the coffee ceremony - it's a cultural experience!";
  }
  
  if (lowerMessage.includes('place') || lowerMessage.includes('visit')) {
    return "Ethiopia has incredible places! Lalibela's rock-hewn churches, the Simien Mountains, and the ancient city of Axum are must-visits. What type of experience are you looking for?";
  }
  
  if (lowerMessage.includes('language') || lowerMessage.includes('amharic')) {
    return "Amharic is beautiful! Start with 'Selam' (hello), 'Ameseginalehu' (thank you), and 'Endemen neh?' (how are you?). Would you like to learn more phrases?";
  }
  
  return "That's an interesting question about Ethiopia! I can help you with information about food, places, culture, language, transportation, and more. What specific aspect interests you?";
}

function generateSuggestions(message: string, userLocation?: string): string[] {
  const suggestions = [];
  const lowerMessage = message.toLowerCase();
  
  if (!lowerMessage.includes('food')) {
    suggestions.push("Tell me about Ethiopian food");
  }
  if (!lowerMessage.includes('place')) {
    suggestions.push("What places should I visit?");
  }
  if (!lowerMessage.includes('language')) {
    suggestions.push("Teach me some Amharic");
  }
  if (!lowerMessage.includes('culture')) {
    suggestions.push("Tell me about Ethiopian culture");
  }
  
  return suggestions.slice(0, 3);
}

function generateQuickReplies(userLocation?: string): string[] {
  const baseReplies = [
    "Where can I find good food?",
    "What are the must-visit places?",
    "How do I say hello in Amharic?",
    "Tell me about local customs"
  ];
  
  if (userLocation) {
    baseReplies.unshift(`What's special about ${userLocation}?`);
  }
  
  return baseReplies.slice(0, 4);
}



























