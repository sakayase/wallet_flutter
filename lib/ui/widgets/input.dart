import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatelessWidget {
  final void Function()? submitFunction;
  final String? Function(String?)? validatorFunction;
  final String? hint;
  final String? label;
  final TextStyle? labelStyle;
  final List<TextInputFormatter>? formatter;
  final TextInputType? keyboard;
  final TextEditingController? controller;
  final String? suffixText;
  final void Function(String)? onChanged;
  final Widget? icon;
  final bool? autofocus;
  const Input({
    Key? key,
    this.submitFunction,
    required this.validatorFunction,
    this.hint,
    this.label,
    this.labelStyle,
    this.formatter,
    this.keyboard,
    this.controller,
    this.suffixText,
    this.onChanged,
    this.icon,
    this.autofocus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus != null ? autofocus! : false,
      inputFormatters: formatter,
      controller: controller,
      keyboardType: keyboard,
      initialValue: null,
      validator: (value) {
        return validatorFunction!(value);
      },
      onFieldSubmitted: (value) {
        submitFunction ?? submitFunction!();
      },
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
          labelText: label,
          labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
          errorMaxLines: 5,
          suffixText: suffixText,
          suffixIcon: icon,
          suffixIconConstraints: const BoxConstraints(maxHeight: 20)),
      onChanged: onChanged,
    );
  }
}
