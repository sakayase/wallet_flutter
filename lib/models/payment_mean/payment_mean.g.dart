// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_mean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMean _$PaymentMeanFromJson(Map<String, dynamic> json) => PaymentMean(
      name: json['name'] as String,
      type: json['type'] as String,
      cardNumber: json['cardNumber'] as String,
      cardCvc: json['cardCvc'] as String,
      cardExpMonth: json['cardExpMonth'] as String,
      cardExpYear: json['cardExpYear'] as String,
    );

Map<String, dynamic> _$PaymentMeanToJson(PaymentMean instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'cardNumber': instance.cardNumber,
      'cardCvc': instance.cardCvc,
      'cardExpMonth': instance.cardExpMonth,
      'cardExpYear': instance.cardExpYear,
    };
