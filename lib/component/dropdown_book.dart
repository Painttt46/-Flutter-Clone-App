import 'package:flutter/material.dart';

class MyDropdownButtonFormField extends StatelessWidget {
  final String value;
  final Function(String?) onChanged;

  MyDropdownButtonFormField({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      items: <String>[
        'Mathbook',
        'sciencebook',
        'electronicbook',
        'plantsbook',
        'astronomybook',
        'cartoonbook'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}