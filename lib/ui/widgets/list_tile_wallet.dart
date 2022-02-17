import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet_flutter/models/payment_mean/payment_mean.dart';
import 'package:wallet_flutter/provider/card_provider.dart';

class ListTileWallet extends ConsumerWidget {
  const ListTileWallet({
    Key? key,
    required this.paymentMean,
    required this.collectionPath,
    required this.groupValue,
    required this.setGroupValue,
  }) : super(key: key);
  final PaymentMean paymentMean;
  final String collectionPath;
  final PaymentMean? groupValue;
  final Function setGroupValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      background: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Icon(Icons.delete, color: Colors.red),
          SizedBox(
            width: 15,
          )
        ],
      ),
      key: Key(paymentMean.name + Random().nextInt(1000).toString()),
      confirmDismiss: (direction) async {
        bool delete = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Attention'),
            content: Text(
                'Vous êtes sur le point supprimer la carte ${paymentMean.name}, voulez vous continuer'),
            actions: [
              TextButton(
                onPressed: (() {
                  Navigator.of(context).pop(true);
                }),
                child: const Text('Oui'),
              ),
              TextButton(
                onPressed: (() {
                  Navigator.of(context).pop(false);
                }),
                child: const Text('Non'),
              ),
            ],
          ),
        );
        if (delete) {
          DocumentSnapshot<Map<String, dynamic>> userData =
              await FirebaseFirestore.instance
                  .collection(collectionPath)
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .get();

          String? selectedId;
          if ((userData.data()!.keys.contains('cartePaiement')) &&
              (userData.data()!['cartePaiement'] != null)) {
            selectedId =
                PaymentMean.fromJson(userData.data()!['cartePaiement']).id!;
          }

          if (selectedId == paymentMean.id) {
            FirebaseFirestore.instance
                .collection(collectionPath)
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .update({'cartePaiement': null});
          }

          await FirebaseFirestore.instance
              .collection(collectionPath)
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('wallet')
              .doc(paymentMean.id!)
              .delete();
          ref.read(cardStateProvider).deletePaymentMean(paymentMean);
        }
        return delete;
      },
      child: ListTile(
        leading: Radio<PaymentMean?>(
            value: paymentMean,
            groupValue: groupValue,
            onChanged: (PaymentMean? value) async {
              setGroupValue(value);
              FirebaseFirestore.instance
                  .collection(collectionPath)
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .update({'cartePaiement': value!.toJson()});
            }),
        title: Text(paymentMean.name),
        subtitle:
            Text(paymentMean.cardNumber.replaceRange(0, 14, '****-****-****')),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Expiration :'),
            Text('${paymentMean.cardExpMonth}/${paymentMean.cardExpYear}'),
          ],
        ),
      ),
    );
  }
}
