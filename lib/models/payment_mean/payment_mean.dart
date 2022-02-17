import 'package:json_annotation/json_annotation.dart';

part 'payment_mean.g.dart';

@JsonSerializable()
class PaymentMean {
  PaymentMean({
    this.id,
    required this.name,
    required this.type,
    required this.cardNumber,
    required this.cardCvc,
    required this.cardExpMonth,
    required this.cardExpYear,
  });
  String? id;
  String name;
  String type;
  String cardNumber;
  String cardCvc;
  String cardExpMonth;
  String cardExpYear;

  setId(String id) {
    this.id = id;
  }

  factory PaymentMean.fromJson(Map<String, dynamic> json) =>
      _$PaymentMeanFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMeanToJson(this);
}
