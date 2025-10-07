import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import OpenAI from 'openai';

const openai = new OpenAI({
  apiKey: functions.config().openai?.api_key || process.env.OPENAI_API_KEY,
});

interface EmbeddingRequest {
  text: string;
  category?: string;
  metadata?: any;
}

interface EmbeddingResponse {
  embedding: number[];
  text: string;
  category?: string;
  metadata?: any;
}

export async function embeddingsHandler(req: functions.Request, res: functions.Response) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    const { text, category, metadata }: EmbeddingRequest = req.body;
    
    if (!text) {
      return res.status(400).json({ error: 'Text is required' });
    }

    // Generate embedding
    const embedding = await generateEmbedding(text);
    
    // Store in Firestore
    const db = admin.firestore();
    const embeddingRef = await db.collection('embeddings').add({
      text,
      embedding,
      category: category || 'general',
      metadata: metadata || {},
      createdAt: admin.firestore.FieldValue.serverTimestamp()
    });

    const response: EmbeddingResponse = {
      embedding,
      text,
      category,
      metadata
    };

    return res.status(200).json({ 
      success: true, 
      data: response,
      embeddingId: embeddingRef.id 
    });

  } catch (error) {
    console.error('Embeddings error:', error);
    return res.status(500).json({ error: 'Internal server error' });
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
    throw error;
  }
}

// Function to search similar content using embeddings
export async function searchSimilarContent(req: functions.Request, res: functions.Response) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    const { query, limit = 5, category } = req.body;
    
    if (!query) {
      return res.status(400).json({ error: 'Query is required' });
    }

    // Generate embedding for the query
    const queryEmbedding = await generateEmbedding(query);
    
    // Search for similar embeddings in Firestore
    const db = admin.firestore();
    let queryRef = db.collection('embeddings');
    
    if (category) {
      queryRef = queryRef.where('category', '==', category);
    }
    
    const embeddingsSnapshot = await queryRef.limit(50).get();
    
    // Calculate similarity scores
    const similarities = embeddingsSnapshot.docs.map(doc => {
      const data = doc.data();
      const similarity = calculateCosineSimilarity(queryEmbedding, data.embedding);
      return {
        id: doc.id,
        text: data.text,
        category: data.category,
        metadata: data.metadata,
        similarity
      };
    });
    
    // Sort by similarity and return top results
    const results = similarities
      .sort((a, b) => b.similarity - a.similarity)
      .slice(0, limit);

    return res.status(200).json({ 
      success: true, 
      results 
    });

  } catch (error) {
    console.error('Search error:', error);
    return res.status(500).json({ error: 'Internal server error' });
  }
}

function calculateCosineSimilarity(a: number[], b: number[]): number {
  if (a.length !== b.length) {
    return 0;
  }
  
  let dotProduct = 0;
  let normA = 0;
  let normB = 0;
  
  for (let i = 0; i < a.length; i++) {
    dotProduct += a[i] * b[i];
    normA += a[i] * a[i];
    normB += b[i] * b[i];
  }
  
  return dotProduct / (Math.sqrt(normA) * Math.sqrt(normB));
}

// Function to batch generate embeddings for knowledge base
export async function batchGenerateEmbeddings(req: functions.Request, res: functions.Response) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    const { category } = req.body;
    
    const db = admin.firestore();
    let knowledgeQuery = db.collection('knowledge_base');
    
    if (category) {
      knowledgeQuery = knowledgeQuery.where('category', '==', category);
    }
    
    const knowledgeSnapshot = await knowledgeQuery.get();
    
    const batch = db.batch();
    const results = [];
    
    for (const doc of knowledgeSnapshot.docs) {
      const data = doc.data();
      const content = data.content || data.title || '';
      
      if (content && !data.embedding) {
        try {
          const embedding = await generateEmbedding(content);
          
          batch.update(doc.ref, {
            embedding,
            embeddingGeneratedAt: admin.firestore.FieldValue.serverTimestamp()
          });
          
          results.push({
            id: doc.id,
            text: content.substring(0, 100) + '...',
            success: true
          });
        } catch (error) {
          console.error(`Error generating embedding for ${doc.id}:`, error);
          results.push({
            id: doc.id,
            text: content.substring(0, 100) + '...',
            success: false,
            error: error.message
          });
        }
      }
    }
    
    await batch.commit();
    
    return res.status(200).json({ 
      success: true, 
      message: 'Batch embedding generation completed',
      results 
    });

  } catch (error) {
    console.error('Batch embedding error:', error);
    return res.status(500).json({ error: 'Internal server error' });
  }
}



























