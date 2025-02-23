import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';
import 'package:site_assessment/src/constants/constants.dart';

//iconLabel
enum IconLabel {
  manager('Manager', Icons.account_circle),
  officer('Officer', Icons.accessibility_new);

  const IconLabel(this.label, this.icon);
  final String label;
  final IconData icon;
}

//OfficerLabel
class OfficerLabel {
  final String fullName;
  final String officerId;
  final String docId;
  final String status;
  final String email;
  bool isSelected;
  OfficerLabel(
      this.fullName, this.officerId, this.status, this.email, this.docId,
      {this.isSelected = false});
  @override
  String toString() => fullName;
}

//Auth Header
class AuthHeader extends StatelessWidget {
  final String title;

  //Constructor
  const AuthHeader(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return CustomText(
        "$title ! \nAssessment App ", 25, FontWeight.bold, AppColors.mainColor);
  }
}

//Size Box With Height
class SizeBox extends StatelessWidget {
  final double? height;
  //constructor
  const SizeBox(this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

//Next With Icon
class NextWithIcon extends StatelessWidget {
  final VoidCallback onPress;

  //constructor
  const NextWithIcon(this.onPress, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        "Next",
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: AppColors.mainColor),
      ),
      CircleAvatar(
          radius: 30,
          backgroundColor: AppColors.mainColor,
          child: IconButton(
              color: Colors.white,
              onPressed: () => onPress(),
              icon: Icon(Icons.arrow_forward))),
    ]);
  }
}

//Input Field
class InputFormField extends StatelessWidget {
  final TextEditingController _controller;
  final String hintText;
  final IconData? icon;

  //Constructor
  const InputFormField(this._controller, this.hintText, this.icon,{super.key});

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6,
      children: [
        CustomText(hintText, 15, FontWeight.bold, Colors.black54),
        TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            prefixIcon: Icon(icon ,color: Colors.black54,),
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              // hintText: hintText,
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
              )),
          validator: (value) {
            String trimmedValue = value?.trim() ?? '';

            if (trimmedValue.isEmpty) {
              return '$hintText Required ';
            }

            //Email
            if (trimmedValue.isNotEmpty &&
                hintText == "Email" &&
                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(trimmedValue)) {
              return 'Enter a valid email!';
            }

            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
        )
      ],
    );
  }
}

//Text Button
class CustomTextButton extends StatelessWidget {
  final String routeName;
  final String text;

  //Constructor
  const CustomTextButton(this.text, this.routeName, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => Navigator.pushNamed(context, routeName),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
            decoration: TextDecoration.underline,
            decorationColor: Colors.black54,
          ),
        ));
  }
}

//Statefull
class DynamicMenu extends StatefulWidget {
  final TextEditingController iconController;
  final Function(IconLabel?) onSelected;
  final bool isFormSubmitted;

  const DynamicMenu(this.iconController, this.onSelected, this.isFormSubmitted, {super.key});

  @override
  State<StatefulWidget> createState() => DynamicMenuState();
}

//State
class DynamicMenuState extends State<DynamicMenu> {
  IconLabel? selectedIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DropdownMenu<IconLabel>(
        controller: widget.iconController,
        // enableFilter: true,
        // requestFocusOnTap: true,
        // leadingIcon: const Icon(
        //   Icons.search,
        //   color: Colors.white,
        // ),
        trailingIcon: const Icon(Icons.arrow_drop_down, color: Colors.black54),
        label: CustomText('Select Role', 14, FontWeight.normal, Colors.black54),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.isFormSubmitted && selectedIcon == null
                      ? Colors.red
                      : Colors.black54)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: widget.isFormSubmitted && selectedIcon == null
                    ? Colors.red
                    : Colors.black54),
          ),
        ),
        onSelected: (icon) {
          setState(() {
            selectedIcon = icon;
          });
          widget.onSelected(icon);
        },
        dropdownMenuEntries: IconLabel.values.map<DropdownMenuEntry<IconLabel>>(
          (IconLabel icon) {
            return DropdownMenuEntry<IconLabel>(
              value: icon,
              label: icon.label,
              leadingIcon: Icon(
                icon.icon,
                color: Colors.black54,
              ),
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
