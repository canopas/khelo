import 'package:flutter/services.dart';

class CustomTextFormatter extends TextInputFormatter {
  final String Function(String) formatFunction;

  CustomTextFormatter(this.formatFunction);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: formatFunction(newValue.text),
      selection: newValue.selection,
    );
  }
}
