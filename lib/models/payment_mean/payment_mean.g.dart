// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_mean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMean _$PaymentMeanFromJson(Map<String, dynamic> json) => PaymentMean(
      id: json['id'] as String?,
      nom: json['nom'] as String,
      type: json['type'] as String,
      cardNumber: json['cardNumber'] as int,
      cardCvc: json['cardCvc'] as int,
      cardExpMonth: json['cardExpMonth'] as int,
      cardExpYear: json['cardExpYear'] as int,
    );

Map<String, dynamic> _$PaymentMeanToJson(PaymentMean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'type': instance.type,
      'cardNumber': instance.cardNumber,
      'cardCvc': instance.cardCvc,
      'cardExpMonth': instance.cardExpMonth,
      'cardExpYear': instance.cardExpYear,
    };
