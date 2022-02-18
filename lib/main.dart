import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  @override
  Widget build(BuildContext context) {
    return const Text('test');
  }
}
