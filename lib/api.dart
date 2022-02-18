import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models/payment_mean/payment_mean.dart';

Future<QuerySnapshot<Map<String, dynamic>>> getWalletFirebase(
    String collectionPath) async {
  return await FirebaseFirestore.instance
      .collection(collectionPath)
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('wallet')
      .get();
}

Future<DocumentSnapshot<Map<String, dynamic>>> getUserDataFirebase(
    String collectionPath) async {
  return await FirebaseFirestore.instance
      .collection(collectionPath)
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();
}

Future<DocumentReference> addCardWalletFirebase(
    String collectionPath, PaymentMean newPaymentMean) async {
  return await FirebaseFirestore.instance
      .collection(collectionPath)
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('wallet')
      .add(newPaymentMean.toJson());
}

Future deleteSelectedCardFirebase(String collectionPath) async {
  return await FirebaseFirestore.instance
      .collection(collectionPath)
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({'cartePaiement': null});
}

Future deleteCardWalletFirebase(
    String collectionPath, String paymentMeanId) async {
  await FirebaseFirestore.instance
      .collection(collectionPath)
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('wallet')
      .doc(paymentMeanId)
      .delete();
}

Future setSelectedCardFirebase(
    String collectionPath, PaymentMean paymentMean) async {
  return await FirebaseFirestore.instance
      .collection(collectionPath)
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({'cartePaiement': paymentMean.toJson()});
}
