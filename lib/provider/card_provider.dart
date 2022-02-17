import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet_flutter/state/card_state.dart';

final cardStateProvider =
    ChangeNotifierProvider.autoDispose<CardStateProvider>((ref) {
  return CardStateProvider();
});
