//Statefull
import 'package:flutter/material.dart';
import '../CustomText.dart';
import '../common.dart';

class DynamicSelectBox<T> extends StatefulWidget {
  final String selectText;
  final TextEditingController iconController;
  final Function(T?) onSelected;
  final bool isSelected;
  final List<T> data;
  final String Function(T) labelExtractor;

  const DynamicSelectBox(this.selectText, this.iconController, this.onSelected,
      this.isSelected, this.data, this.labelExtractor,
      {super.key});

  @override
  State<StatefulWidget> createState() => DynamicSelectState<T>();
}

//State
class DynamicSelectState<T> extends State<DynamicSelectBox<T>> {
  T? selected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DropdownMenu<T>(
        width: MediaQuery.of(context).size.width * 0.45,
        controller: widget.iconController,
        trailingIcon: const Icon(Icons.arrow_drop_down, color: Colors.black54),
        label: CustomText(
            widget.selectText, 14, FontWeight.normal, Colors.black54),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: !widget.isSelected && selected == null
                      ? Colors.red
                      : Colors.black54)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: !widget.isSelected && selected == null
                    ? Colors.red
                    : Colors.black54),
          ),
        ),
        onSelected: (item) {
          // setState(() {
          //   selectedIcon = item;
          // });
          widget.onSelected(item);
        },
        dropdownMenuEntries: widget.data.map<DropdownMenuEntry<T>>(
          (item) {
            return DropdownMenuEntry<T>(
              value: item,
              label: widget.labelExtractor(item),
              style: MenuItemButton.styleFrom(
                foregroundColor: Colors.black54,
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
