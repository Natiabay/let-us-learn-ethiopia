import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

interface AdminRequest {
  action: 'get_users' | 'get_payments' | 'get_analytics' | 'update_lesson' | 'add_knowledge';
  userId?: string;
  paymentId?: string;
  lessonId?: string;
  data?: any;
}

export async function adminHandler(req: functions.Request, res: functions.Response) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    const { action, userId, paymentId, lessonId, data }: AdminRequest = req.body;
    
    // Verify admin access (implement proper authentication)
    const isAdmin = await verifyAdminAccess(req);
    if (!isAdmin) {
      return res.status(403).json({ error: 'Admin access required' });
    }

    const db = admin.firestore();
    let result: any;

    switch (action) {
      case 'get_users':
        result = await getUsers(db);
        break;
      case 'get_payments':
        result = await getPayments(db);
        break;
      case 'get_analytics':
        result = await getAnalytics(db);
        break;
      case 'update_lesson':
        result = await updateLesson(db, lessonId!, data);
        break;
      case 'add_knowledge':
        result = await addKnowledge(db, data);
        break;
      default:
        return res.status(400).json({ error: 'Invalid action' });
    }

    return res.status(200).json({ success: true, data: result });

  } catch (error) {
    console.error('Admin error:', error);
    return res.status(500).json({ error: 'Internal server error' });
  }
}

async function verifyAdminAccess(req: functions.Request): Promise<boolean> {
  // Implement proper admin authentication
  // This could be JWT verification, Firebase Auth, or API key validation
  const adminKey = req.headers['x-admin-key'] as string;
  const validAdminKey = functions.config().admin?.key;
  
  return adminKey === validAdminKey;
}

async function getUsers(db: admin.firestore.Firestore) {
  const usersSnapshot = await db.collection('users')
    .orderBy('createdAt', 'desc')
    .limit(100)
    .get();

  const users = usersSnapshot.docs.map(doc => ({
    id: doc.id,
    ...doc.data(),
    createdAt: doc.data().createdAt?.toDate(),
    lastLoginAt: doc.data().lastLoginAt?.toDate()
  }));

  // Get user statistics
  const totalUsers = await db.collection('users').count().get();
  const activeUsers = await db.collection('users')
    .where('hasAccess', '==', true)
    .count()
    .get();

  return {
    users,
    statistics: {
      totalUsers: totalUsers.data().count,
      activeUsers: activeUsers.data().count,
      inactiveUsers: totalUsers.data().count - activeUsers.data().count
    }
  };
}

async function getPayments(db: admin.firestore.Firestore) {
  const paymentsSnapshot = await db.collection('payments')
    .orderBy('createdAt', 'desc')
    .limit(100)
    .get();

  const payments = paymentsSnapshot.docs.map(doc => ({
    id: doc.id,
    ...doc.data(),
    createdAt: doc.data().createdAt?.toDate(),
    verifiedAt: doc.data().verifiedAt?.toDate()
  }));

  // Get payment statistics
  const totalPayments = await db.collection('payments').count().get();
  const completedPayments = await db.collection('payments')
    .where('status', '==', 'completed')
    .count()
    .get();
  
  const pendingPayments = await db.collection('payments')
    .where('status', '==', 'pending')
    .count()
    .get();

  // Calculate revenue
  const revenueSnapshot = await db.collection('payments')
    .where('status', '==', 'completed')
    .get();

  let totalRevenue = 0;
  revenueSnapshot.docs.forEach(doc => {
    const payment = doc.data();
    if (payment.amount && payment.currency === 'ETB') {
      totalRevenue += payment.amount;
    }
  });

  return {
    payments,
    statistics: {
      totalPayments: totalPayments.data().count,
      completedPayments: completedPayments.data().count,
      pendingPayments: pendingPayments.data().count,
      totalRevenue: totalRevenue
    }
  };
}

async function getAnalytics(db: admin.firestore.Firestore) {
  // Get lesson completion statistics
  const lessonStats = await db.collection('user_progress')
    .get();

  const lessonCompletions: { [key: string]: number } = {};
  lessonStats.docs.forEach(doc => {
    const progress = doc.data();
    if (progress.completedLessons) {
      progress.completedLessons.forEach((lessonId: string) => {
        lessonCompletions[lessonId] = (lessonCompletions[lessonId] || 0) + 1;
      });
    }
  });

  // Get chatbot usage statistics
  const chatStats = await db.collection('conversations')
    .get();

  const dailyChats: { [key: string]: number } = {};
  chatStats.docs.forEach(doc => {
    const conversation = doc.data();
    const date = conversation.createdAt?.toDate().toISOString().split('T')[0];
    if (date) {
      dailyChats[date] = (dailyChats[date] || 0) + 1;
    }
  });

  // Get location popularity
  const locationStats = await db.collection('user_favorites')
    .get();

  const locationPopularity: { [key: string]: number } = {};
  locationStats.docs.forEach(doc => {
    const favorites = doc.data();
    if (favorites.locationIds) {
      favorites.locationIds.forEach((locationId: string) => {
        locationPopularity[locationId] = (locationPopularity[locationId] || 0) + 1;
      });
    }
  });

  return {
    lessonCompletions,
    dailyChats,
    locationPopularity,
    totalConversations: chatStats.size,
    totalFavorites: locationStats.size
  };
}

async function updateLesson(db: admin.firestore.Firestore, lessonId: string, lessonData: any) {
  const lessonRef = db.collection('lessons').doc(lessonId);
  
  await lessonRef.update({
    ...lessonData,
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  });

  return { success: true, message: 'Lesson updated successfully' };
}

async function addKnowledge(db: admin.firestore.Firestore, knowledgeData: any) {
  const knowledgeRef = await db.collection('knowledge_base').add({
    ...knowledgeData,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
    updatedAt: admin.firestore.FieldValue.serverTimestamp()
  });

  return { 
    success: true, 
    message: 'Knowledge added successfully',
    knowledgeId: knowledgeRef.id 
  };
}

// Function to generate embeddings for knowledge base
export async function generateKnowledgeEmbeddings(req: functions.Request, res: functions.Response) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    const { knowledgeId } = req.body;
    
    if (!knowledgeId) {
      return res.status(400).json({ error: 'Knowledge ID required' });
    }

    const db = admin.firestore();
    const knowledgeDoc = await db.collection('knowledge_base').doc(knowledgeId).get();
    
    if (!knowledgeDoc.exists) {
      return res.status(404).json({ error: 'Knowledge document not found' });
    }

    const knowledgeData = knowledgeDoc.data()!;
    const content = knowledgeData.content || knowledgeData.title || '';
    
    // Generate embedding (this would use OpenAI embeddings API)
    const embedding = await generateEmbedding(content);
    
    // Store embedding
    await knowledgeDoc.ref.update({
      embedding,
      embeddingGeneratedAt: admin.firestore.FieldValue.serverTimestamp()
    });

    return res.status(200).json({ 
      success: true, 
      message: 'Embedding generated successfully' 
    });

  } catch (error) {
    console.error('Embedding generation error:', error);
    return res.status(500).json({ error: 'Internal server error' });
  }
}

async function generateEmbedding(text: string): Promise<number[]> {
  // This would use OpenAI embeddings API
  // For now, return a placeholder
  return new Array(1536).fill(0).map(() => Math.random());
}

























