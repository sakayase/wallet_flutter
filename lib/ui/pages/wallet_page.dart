import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:wallet_flutter/api.dart';
import 'package:wallet_flutter/models/payment_mean/payment_mean.dart';
import 'package:wallet_flutter/provider/card_provider.dart';
import 'package:wallet_flutter/ui/widgets/dialog_new_card.dart';
import 'package:wallet_flutter/ui/widgets/list_tile_wallet.dart';

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
    getWallet();
    super.initState();
  }

  getWallet() async {
    List<PaymentMean> paymentMeans = [];
    QuerySnapshot<Map<String, dynamic>> paymentMeansData =
        await getWalletFirebase(widget.collectionPath);
    DocumentSnapshot<Map<String, dynamic>> userData =
        await getUserDataFirebase(widget.collectionPath);

    String? selectedId;
    if ((userData.data()!.keys.contains('cartePaiement')) &&
        (userData.data()!['cartePaiement'] != null)) {
      selectedId = PaymentMean.fromJson(userData.data()!['cartePaiement']).id!;
    }

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
      bottomSheet: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
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
                if (newPaymentMean != null) {
                  DocumentReference docRef = await addCardWalletFirebase(
                      widget.collectionPath, newPaymentMean);
                  newPaymentMean.setId(docRef.id);
                  ref.read(cardStateProvider).addPaymentMeans(newPaymentMean);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
