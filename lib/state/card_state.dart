import 'package:flutter/foundation.dart';
import 'package:wallet_flutter/models/payment_mean/payment_mean.dart';

class CardStateProvider with ChangeNotifier {
  List<PaymentMean> paymentMeans = [];

  setPaymentMeans(List<PaymentMean> paymentMeans) {
    this.paymentMeans = paymentMeans;
    notifyListeners();
  }

  addPaymentMeans(PaymentMean paymentMean) {
    paymentMeans.add(paymentMean);
    notifyListeners();
  }

  deletePaymentMean(PaymentMean paymentMean) {
    paymentMeans.remove(paymentMean);
    notifyListeners();
  }
}
