import 'package:json_annotation/json_annotation.dart';

part 'payment_mean.g.dart';

@JsonSerializable()
class PaymentMean {
  PaymentMean({
    this.id,
    required this.nom,
    required this.type,
    required this.cardNumber,
    required this.cardCvc,
    required this.cardExpMonth,
    required this.cardExpYear,
  });
  String? id;
  String nom;
  String type;
  int cardNumber;
  int cardCvc;
  int cardExpMonth;
  int cardExpYear;

  setId(String id) {
    this.id = id;
  }

  factory PaymentMean.fromJson(Map<String, dynamic> json) =>
      _$PaymentMeanFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMeanToJson(this);
}
