import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { chatbotHandler } from './chatbot';
import { paymentWebhookHandler } from './payments';
import { adminHandler } from './admin';
import { embeddingsHandler } from './embeddings';

// Initialize Firebase Admin
admin.initializeApp();

// CORS configuration
const cors = require('cors')({ origin: true });

// Chatbot RAG Function
export const chatbot = functions.https.onRequest(async (req, res) => {
  return cors(req, res, async () => {
    try {
      const result = await chatbotHandler(req, res);
      return result;
    } catch (error) {
      console.error('Chatbot error:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  });
});

// Payment Webhook Function
export const paymentWebhook = functions.https.onRequest(async (req, res) => {
  return cors(req, res, async () => {
    try {
      const result = await paymentWebhookHandler(req, res);
      return result;
    } catch (error) {
      console.error('Payment webhook error:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  });
});

// Admin Dashboard Function
export const admin = functions.https.onRequest(async (req, res) => {
  return cors(req, res, async () => {
    try {
      const result = await adminHandler(req, res);
      return result;
    } catch (error) {
      console.error('Admin error:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  });
});

// Embeddings Function
export const embeddings = functions.https.onRequest(async (req, res) => {
  return cors(req, res, async () => {
    try {
      const result = await embeddingsHandler(req, res);
      return result;
    } catch (error) {
      console.error('Embeddings error:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  });
});

// Scheduled function to process payments
export const processPayments = functions.pubsub.schedule('every 5 minutes').onRun(async (context) => {
  console.log('Processing pending payments...');
  
  try {
    const db = admin.firestore();
    const pendingPayments = await db.collection('payments')
      .where('status', '==', 'pending')
      .where('createdAt', '>', new Date(Date.now() - 24 * 60 * 60 * 1000)) // Last 24 hours
      .get();

    for (const doc of pendingPayments.docs) {
      const payment = doc.data();
      console.log(`Processing payment: ${doc.id}`);
      
      // Verify payment with Telebirr/CBE API
      const verificationResult = await verifyPaymentWithProvider(payment);
      
      if (verificationResult.verified) {
        await doc.ref.update({
          status: 'completed',
          verifiedAt: admin.firestore.FieldValue.serverTimestamp(),
          providerTransactionId: verificationResult.transactionId
        });
        
        // Grant user access
        await grantUserAccess(payment.userId, payment.subscriptionDays);
        
        console.log(`Payment ${doc.id} verified and access granted`);
      }
    }
  } catch (error) {
    console.error('Error processing payments:', error);
  }
});

async function verifyPaymentWithProvider(payment: any) {
  // Implement actual Telebirr/CBE verification logic
  // This is a placeholder implementation
  return {
    verified: false,
    transactionId: null
  };
}

async function grantUserAccess(userId: string, subscriptionDays: number) {
  const db = admin.firestore();
  const userRef = db.collection('users').doc(userId);
  
  const accessData = {
    hasAccess: true,
    subscriptionDays: subscriptionDays,
    accessGrantedAt: admin.firestore.FieldValue.serverTimestamp(),
    expiresAt: subscriptionDays === -1 ? null : new Date(Date.now() + subscriptionDays * 24 * 60 * 60 * 1000)
  };
  
  await userRef.update(accessData);
}



























