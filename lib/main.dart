import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet_flutter/ui/pages/wallet_page.dart';

class Wallet extends StatelessWidget {
  const Wallet({
    Key? key,
    required this.collectionPath,
  }) : super(key: key);
  final String collectionPath;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: WalletPage(
        collectionPath: collectionPath,
      ),
    );
  }
}
