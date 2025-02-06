import 'package:flutter/material.dart';

import '../constants/constants.dart';

class DateSelectorWithInput extends StatefulWidget {
  final TextEditingController _controller;
  final String hintText;
  const DateSelectorWithInput(this._controller, this.hintText, {super.key});

  @override
  State<StatefulWidget> createState() => DateSelectorWithInputState();
}

//State
class DateSelectorWithInputState extends State<DateSelectorWithInput> {
  //check Range
  bool _decideWhichDayToEnable(DateTime day) {
    return day.isBefore(DateTime.now().add(Duration(days: 1)));
  }

  //Select modal for date
  _selectDate(BuildContext context) async {
    DateTime today = DateTime.now();
    DateTime minDate = DateTime(2000);
    DateTime maxDate = today;

    DateTime initialDate = today.isBefore(maxDate) ? today : maxDate;

    try {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: minDate,
          lastDate: maxDate,
          selectableDayPredicate: _decideWhichDayToEnable,
          builder: (BuildContext context, Widget? child) {
            return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light(
                    primary: AppColors.mainColor,
                    onPrimary: Colors.white,
                    surface:Colors.white,
                    onSurface: Colors.black54,
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                    ),
                  ),
                ),
                child: child ?? SizedBox());
          });

      if (picked != null) {
        setState(() {
          today = picked;
          widget._controller.text = "${picked.day}/${picked.month}/${picked.year}";
        });
      }
    } catch (err) {
      print("$err from the date Picker");
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget._controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          hintText: widget.hintText,
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.mainColor),
            borderRadius: BorderRadius.circular(8),
          ),
          suffixIcon: IconButton(
              onPressed: () {
                _selectDate(context);
              },
              icon: Icon(Icons.date_range))),
      validator: (value) {
        String trimmedValue = value?.trim() ?? '';

        if (trimmedValue.isEmpty) {
          return '${widget.hintText} Required ';
        }

        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
