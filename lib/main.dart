import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet_flutter/models/payment_mean/payment_mean.dart';
import 'package:wallet_flutter/provider/card_provider.dart';
import 'package:wallet_flutter/ui/pages/wallet_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Wallet(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class Wallet extends ConsumerStatefulWidget {
  const Wallet({Key? key}) : super(key: key);
  @override
  ConsumerState<Wallet> createState() => _WalletState();
}

class _WalletState extends ConsumerState<Wallet> {
  String userId = 'pGKEHvaQ1SgArfrVnEztV9Sl5s52';
  List<PaymentMean> paymentMeans = [
    PaymentMean(
      name: 'Carte 1',
      type: 'card',
      cardNumber: '4242424242424242',
      cardExpMonth: '11',
      cardExpYear: '22',
      cardCvc: '354',
    ),
    PaymentMean(
      name: 'Carte 2',
      type: 'card',
      cardNumber: '4242424242424242',
      cardExpMonth: '05',
      cardExpYear: '24',
      cardCvc: '354',
    ),
  ];

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      setPaymentMean(paymentMeans);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: FirebaseFirestore.instance
            .collection('prestataires_livraison')
            .doc(userId)
            .snapshots(),
        builder: (context, snapshot) {
          print(snapshot.data);
          return WalletPage();
        });
  }

  setPaymentMean(List<PaymentMean> paymentMeans) {
    ref.read(cardStateProvider).setPaymentMeans(paymentMeans);
  }
}
