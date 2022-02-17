import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet_flutter/models/payment_mean/payment_mean.dart';
import 'package:wallet_flutter/ui/widgets/dropdown_date.dart';
import 'package:wallet_flutter/ui/widgets/input.dart';

class DialogNewCard extends ConsumerStatefulWidget {
  const DialogNewCard({Key? key}) : super(key: key);

  @override
  _DialogNewCardState createState() => _DialogNewCardState();
}

class _DialogNewCardState extends ConsumerState<DialogNewCard> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cardNumController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  String? month;
  String? year;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ajout de carte',
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 35,
                ),
                Input(
                  validatorFunction: checkEmptyValue,
                  label: 'Nom de la carte',
                  controller: _nameController,
                  icon: const Icon(Icons.person),
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                ),
                const SizedBox(height: 20),
                Input(
                  validatorFunction: numCardValidator,
                  label: 'Numéro de carte',
                  controller: _cardNumController,
                  keyboard: TextInputType.number,
                  onChanged: formatCardNumber,
                  formatter: createFormatters(19, r'[0-9]'),
                  icon: const Icon(Icons.payment),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                Input(
                  validatorFunction: cvvValidator,
                  label: 'Cvc',
                  controller: _cvvController,
                  keyboard: TextInputType.number,
                  formatter: createFormatters(3, r'[0-9]'),
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 20),
                Text(
                  'Date d\'expiration',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: 10),
                DropdownDate(
                  monthKey: const Key('month'),
                  monthController: month,
                  yearKey: const Key('year'),
                  yearController: year,
                  selectYear: selectYear,
                  selectMonth: selectMonth,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 60,
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.of(context).pop(
                  PaymentMean(
                    name: _nameController.text,
                    type: 'card',
                    cardNumber: _cardNumController.text,
                    cardCvc: _cvvController.text,
                    cardExpMonth: month!,
                    cardExpYear: year!,
                  ),
                );
              }
            },
            child: const Text('Ajouter'),
          ),
        ),
      ),
    );
  }

  String? checkEmptyValue(value) {
    if (value == null || value.isEmpty) {
      return 'Le champ ne peut être vide';
    }
    return null;
  }

  String? numCardValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Le champ ne peut être vide';
    } else if (value.length < 12) {
      return 'Trop court';
    }
    return null;
  }

  String? cvvValidator(value) {
    {
      if (value == null || value.isEmpty) {
        return 'Le champ ne peut être vide';
      }
      if (value.length < 3) {
        return 'Trop court';
      }
      return null;
    }
  }

  selectMonth(value) {
    FocusScope.of(context).unfocus();
    setState(() {
      month = value.toString();
    });
  }

  selectYear(value) {
    FocusScope.of(context).unfocus();
    setState(() {
      year = value.toString();
    });
  }

  void Function(String)? formatCardNumber(value) {
    String newText = _cardNumController.text.replaceAllMapped(
        RegExp(r".{4}(?=.)"), (match) => "${match.group(0)}-");
    _cardNumController.value = TextEditingValue(
      text: newText,
      selection:
          TextSelection.fromPosition(TextPosition(offset: newText.length)),
    );
    return null;
  }

  List<TextInputFormatter>? createFormatters(int lenghtLimit, String regex) {
    return [
      LengthLimitingTextInputFormatter(lenghtLimit),
      FilteringTextInputFormatter.allow(
        RegExp(regex),
      ),
    ];
  }
}
