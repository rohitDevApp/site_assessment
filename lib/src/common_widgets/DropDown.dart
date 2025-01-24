import 'package:flutter/material.dart';

class DropDown<T> extends StatelessWidget {
  final TextEditingController controller;
  final Function(T?) onChanged;
  final bool isFormSubmitted;
  final List<T> items;

  const DropDown(
      this.controller,
      this.onChanged,
      this.isFormSubmitted,
      this.items, {
        super.key,
      });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        errorText: isFormSubmitted && controller.text.isEmpty
            ? 'Please select an option'
            : null,
      ),
      items: items
          .map((item) => DropdownMenuItem<T>(
        value: item,
        child: Text(item.toString()), // Customize based on your data type
      ))
          .toList(),
      onChanged: (value) {
        controller.text = value.toString(); // Update controller value
        onChanged(value); // Trigger onChanged callback
      },
    );
  }
}
