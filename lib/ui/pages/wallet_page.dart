import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet_flutter/provider/card_provider.dart';
import 'package:wallet_flutter/ui/widgets/dialog_new_card.dart';
import 'package:wallet_flutter/ui/widgets/list_tile_wallet.dart';

import '../../models/payment_mean/payment_mean.dart';

class WalletPage extends ConsumerWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardState = ref.watch(cardStateProvider);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - 90,
            child: ListView.builder(
              itemCount: cardState.paymentMeans.length,
              itemBuilder: (context, index) {
                PaymentMean paymentMean = cardState.paymentMeans[index];
                return ListTileWallet(paymentMean: paymentMean);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                child: const Text('Ajouter une carte'),
                onPressed: () async {
                  PaymentMean newPaymentMean = await showDialog(
                    context: context,
                    builder: (context) {
                      return const DialogNewCard();
                    },
                  );
                  ref.read(cardStateProvider).addPaymentMeans(newPaymentMean);
                },
              ),
            ),
          ),
        ],
      ),
      // bottomSheet:
    );
  }
}
