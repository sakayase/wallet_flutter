import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet_flutter/provider/card_provider.dart';
import 'package:wallet_flutter/ui/widgets/dialog_new_card.dart';
import 'package:wallet_flutter/ui/widgets/list_tile_wallet.dart';

import '../../models/payment_mean/payment_mean.dart';

class WalletPage extends ConsumerStatefulWidget {
  const WalletPage({Key? key, required this.collectionPath}) : super(key: key);
  final String collectionPath;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WalletPageState();
}

class _WalletPageState extends ConsumerState<WalletPage> {
  bool loading = true;
  PaymentMean? groupValue;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getWallet();
    });
    super.initState();
  }

  getWallet() async {
    List<PaymentMean> paymentMeans = [];

    QuerySnapshot<Map<String, dynamic>> paymentMeansData =
        await FirebaseFirestore.instance
            .collection(widget.collectionPath)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('wallet')
            .get();

    DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
        .instance
        .collection(widget.collectionPath)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    String? selectedId;
    if ((userData.data()!.keys.contains('cartePaiement')) &&
        (userData.data()!['cartePaiement'] != null)) {
      selectedId = PaymentMean.fromJson(userData.data()!['cartePaiement']).id!;
    }

    if (mounted) {
      PaymentMean? detectedSelectedPayment;
      for (var card in paymentMeansData.docs) {
        PaymentMean paymentMean = PaymentMean.fromJson(card.data());
        paymentMean.setId(card.id);
        if (selectedId == card.id) {
          detectedSelectedPayment = paymentMean;
        }
        paymentMeans.add(paymentMean);
      }
      ref.read(cardStateProvider).setPaymentMeans(paymentMeans);

      setState(() {
        groupValue = detectedSelectedPayment;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cardState = ref.watch(cardStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 90,
          child: loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: cardState.paymentMeans.length,
                  itemBuilder: (context, index) {
                    PaymentMean paymentMean = cardState.paymentMeans[index];
                    return ListTileWallet(
                      paymentMean: paymentMean,
                      collectionPath: widget.collectionPath,
                      groupValue: groupValue,
                      setGroupValue: (PaymentMean value) {
                        setState(() {
                          groupValue = value;
                        });
                      },
                    );
                  },
                ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SizedBox(
          height: 60,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            child: const Text('Ajouter une carte'),
            onPressed: () async {
              PaymentMean? newPaymentMean = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DialogNewCard(),
                ),
              );
              // showDialog(
              //   context: context,
              //   builder: (context) {
              //     return const DialogNewCard();
              //   },
              // );
              if (newPaymentMean != null) {
                DocumentReference docRef = await FirebaseFirestore.instance
                    .collection(widget.collectionPath)
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('wallet')
                    .add(newPaymentMean.toJson());
                newPaymentMean.setId(docRef.id);
                ref.read(cardStateProvider).addPaymentMeans(newPaymentMean);
              }
            },
          ),
        ),
      ),
    );
  }
}
