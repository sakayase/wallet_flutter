import 'package:flutter/material.dart';
import 'package:wallet_flutter/models/payment_mean/payment_mean.dart';

class ListTileWallet extends StatelessWidget {
  const ListTileWallet({Key? key, required this.paymentMean}) : super(key: key);
  final PaymentMean paymentMean;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Nom : ${paymentMean.name}'),
      subtitle: Text(
          'Numero : ${paymentMean.cardNumber.replaceRange(0, 12, '**** **** **** ')}'),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Expiration : '),
          Text('${paymentMean.cardExpMonth}/${paymentMean.cardExpMonth}'),
        ],
      ),
    );
  }
}
