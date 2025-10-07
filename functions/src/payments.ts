import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import axios from 'axios';

interface PaymentWebhookRequest {
  transactionId: string;
  amount: number;
  currency: string;
  status: 'pending' | 'completed' | 'failed';
  provider: 'telebirr' | 'cbe' | 'santimpay';
  providerTransactionId?: string;
  userId: string;
  subscriptionDays: number;
  phoneNumber?: string;
}

interface PaymentVerificationResult {
  verified: boolean;
  transactionId?: string;
  amount?: number;
  status?: string;
}

export async function paymentWebhookHandler(req: functions.Request, res: functions.Response) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    const paymentData: PaymentWebhookRequest = req.body;
    
    // Verify webhook signature (implement based on provider)
    const isValidSignature = await verifyWebhookSignature(req);
    if (!isValidSignature) {
      return res.status(401).json({ error: 'Invalid signature' });
    }

    const db = admin.firestore();
    
    // Store payment record
    const paymentRef = await db.collection('payments').add({
      ...paymentData,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp()
    });

    // Verify payment with provider
    const verificationResult = await verifyPaymentWithProvider(paymentData);
    
    if (verificationResult.verified) {
      // Update payment status
      await paymentRef.update({
        status: 'completed',
        verifiedAt: admin.firestore.FieldValue.serverTimestamp(),
        providerTransactionId: verificationResult.transactionId,
        verifiedAmount: verificationResult.amount
      });

      // Grant user access
      await grantUserAccess(paymentData.userId, paymentData.subscriptionDays);
      
      // Send confirmation notification
      await sendPaymentConfirmation(paymentData.userId, paymentData.amount, paymentData.currency);
      
      console.log(`Payment ${paymentRef.id} verified and access granted`);
      
      return res.status(200).json({ 
        success: true, 
        message: 'Payment verified and access granted',
        paymentId: paymentRef.id 
      });
    } else {
      // Mark payment as failed
      await paymentRef.update({
        status: 'failed',
        failedAt: admin.firestore.FieldValue.serverTimestamp(),
        failureReason: 'Payment verification failed'
      });
      
      return res.status(400).json({ 
        success: false, 
        message: 'Payment verification failed' 
      });
    }

  } catch (error) {
    console.error('Payment webhook error:', error);
    return res.status(500).json({ error: 'Internal server error' });
  }
}

async function verifyWebhookSignature(req: functions.Request): Promise<boolean> {
  // Implement webhook signature verification based on provider
  // This is a placeholder - implement actual signature verification
  const signature = req.headers['x-signature'] as string;
  const timestamp = req.headers['x-timestamp'] as string;
  
  if (!signature || !timestamp) {
    return false;
  }
  
  // Verify signature using provider's secret key
  // Implementation depends on specific provider requirements
  return true; // Placeholder
}

async function verifyPaymentWithProvider(paymentData: PaymentWebhookRequest): Promise<PaymentVerificationResult> {
  try {
    switch (paymentData.provider) {
      case 'telebirr':
        return await verifyTelebirrPayment(paymentData);
      case 'cbe':
        return await verifyCBEPayment(paymentData);
      case 'santimpay':
        return await verifySantimPayPayment(paymentData);
      default:
        return { verified: false };
    }
  } catch (error) {
    console.error('Payment verification error:', error);
    return { verified: false };
  }
}

async function verifyTelebirrPayment(paymentData: PaymentWebhookRequest): Promise<PaymentVerificationResult> {
  try {
    // Telebirr API verification
    const telebirrApiKey = functions.config().telebirr?.api_key;
    const telebirrMerchantId = functions.config().telebirr?.merchant_id;
    
    if (!telebirrApiKey || !telebirrMerchantId) {
      console.error('Telebirr API configuration missing');
      return { verified: false };
    }

    const response = await axios.post('https://api.telebirr.com/v1/payment/verify', {
      transactionId: paymentData.providerTransactionId,
      merchantId: telebirrMerchantId,
      amount: paymentData.amount,
      currency: paymentData.currency
    }, {
      headers: {
        'Authorization': `Bearer ${telebirrApiKey}`,
        'Content-Type': 'application/json'
      }
    });

    if (response.status === 200 && response.data.status === 'success') {
      return {
        verified: true,
        transactionId: response.data.transactionId,
        amount: response.data.amount,
        status: response.data.status
      };
    }

    return { verified: false };
  } catch (error) {
    console.error('Telebirr verification error:', error);
    return { verified: false };
  }
}

async function verifyCBEPayment(paymentData: PaymentWebhookRequest): Promise<PaymentVerificationResult> {
  try {
    // CBE Birr API verification
    const cbeApiKey = functions.config().cbe?.api_key;
    const cbeMerchantId = functions.config().cbe?.merchant_id;
    
    if (!cbeApiKey || !cbeMerchantId) {
      console.error('CBE API configuration missing');
      return { verified: false };
    }

    const response = await axios.post('https://api.cbe.com/v1/payment/verify', {
      transactionId: paymentData.providerTransactionId,
      merchantId: cbeMerchantId,
      amount: paymentData.amount,
      currency: paymentData.currency
    }, {
      headers: {
        'Authorization': `Bearer ${cbeApiKey}`,
        'Content-Type': 'application/json'
      }
    });

    if (response.status === 200 && response.data.status === 'success') {
      return {
        verified: true,
        transactionId: response.data.transactionId,
        amount: response.data.amount,
        status: response.data.status
      };
    }

    return { verified: false };
  } catch (error) {
    console.error('CBE verification error:', error);
    return { verified: false };
  }
}

async function verifySantimPayPayment(paymentData: PaymentWebhookRequest): Promise<PaymentVerificationResult> {
  try {
    // SantimPay API verification
    const santimpayApiKey = functions.config().santimpay?.api_key;
    const santimpayMerchantId = functions.config().santimpay?.merchant_id;
    
    if (!santimpayApiKey || !santimpayMerchantId) {
      console.error('SantimPay API configuration missing');
      return { verified: false };
    }

    const response = await axios.post('https://api.santimpay.com/v1/payment/verify', {
      transactionId: paymentData.providerTransactionId,
      merchantId: santimpayMerchantId,
      amount: paymentData.amount,
      currency: paymentData.currency
    }, {
      headers: {
        'Authorization': `Bearer ${santimpayApiKey}`,
        'Content-Type': 'application/json'
      }
    });

    if (response.status === 200 && response.data.status === 'success') {
      return {
        verified: true,
        transactionId: response.data.transactionId,
        amount: response.data.amount,
        status: response.data.status
      };
    }

    return { verified: false };
  } catch (error) {
    console.error('SantimPay verification error:', error);
    return { verified: false };
  }
}

async function grantUserAccess(userId: string, subscriptionDays: number): Promise<void> {
  const db = admin.firestore();
  const userRef = db.collection('users').doc(userId);
  
  const accessData = {
    hasAccess: true,
    subscriptionDays: subscriptionDays,
    accessGrantedAt: admin.firestore.FieldValue.serverTimestamp(),
    expiresAt: subscriptionDays === -1 ? null : new Date(Date.now() + subscriptionDays * 24 * 60 * 60 * 1000)
  };
  
  await userRef.update(accessData);
  
  // Also update subscription status
  await db.collection('subscriptions').doc(userId).set({
    userId,
    isActive: true,
    subscriptionDays,
    activatedAt: admin.firestore.FieldValue.serverTimestamp(),
    expiresAt: subscriptionDays === -1 ? null : new Date(Date.now() + subscriptionDays * 24 * 60 * 60 * 1000)
  }, { merge: true });
}

async function sendPaymentConfirmation(userId: string, amount: number, currency: string): Promise<void> {
  try {
    // Send push notification or email confirmation
    const db = admin.firestore();
    
    // Store notification
    await db.collection('notifications').add({
      userId,
      type: 'payment_confirmation',
      title: 'Payment Confirmed!',
      message: `Your payment of ${amount} ${currency} has been confirmed. You now have full access to all features!`,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      read: false
    });
    
    console.log(`Payment confirmation sent to user ${userId}`);
  } catch (error) {
    console.error('Error sending payment confirmation:', error);
  }
}

// Function to manually verify payments (for admin use)
export async function manualPaymentVerification(req: functions.Request, res: functions.Response) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    const { paymentId, provider, transactionId } = req.body;
    
    if (!paymentId || !provider || !transactionId) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    const db = admin.firestore();
    const paymentDoc = await db.collection('payments').doc(paymentId).get();
    
    if (!paymentDoc.exists) {
      return res.status(404).json({ error: 'Payment not found' });
    }

    const paymentData = paymentDoc.data()!;
    
    // Verify with provider
    const verificationResult = await verifyPaymentWithProvider({
      ...paymentData,
      provider,
      providerTransactionId: transactionId
    } as PaymentWebhookRequest);
    
    if (verificationResult.verified) {
      // Update payment status
      await paymentDoc.ref.update({
        status: 'completed',
        verifiedAt: admin.firestore.FieldValue.serverTimestamp(),
        providerTransactionId: verificationResult.transactionId,
        verifiedAmount: verificationResult.amount
      });

      // Grant user access
      await grantUserAccess(paymentData.userId, paymentData.subscriptionDays);
      
      return res.status(200).json({ 
        success: true, 
        message: 'Payment verified and access granted' 
      });
    } else {
      return res.status(400).json({ 
        success: false, 
        message: 'Payment verification failed' 
      });
    }

  } catch (error) {
    console.error('Manual payment verification error:', error);
    return res.status(500).json({ error: 'Internal server error' });
  }
}

























