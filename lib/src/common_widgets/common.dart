
import 'package:flutter/material.dart';

//iconLabel
enum IconLabel {
  manager('Manager', Icons.account_circle),
  officer('Officer', Icons.accessibility_new);

  const IconLabel(this.label, this.icon);
  final String label;
  final IconData icon;
}

//Auth Header
class AuthHeader extends StatelessWidget {
  final String title;

  //Constructor
  AuthHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.2, left: 20),
      child: Text(
        "$title ! \nAssessment App ",
        style: TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}

//Size Box With Height
class SizeBox extends StatelessWidget {
  final double? height;
  //constructor
  SizeBox(this.height);

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
  NextWithIcon(this.onPress);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        "Next",
        style: TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: IconButton(
              color: Colors.black,
              onPressed: () => onPress(),
              icon: Icon(Icons.arrow_forward))),
    ]);
  }
}

//Input Field
class InputFormField extends StatelessWidget {
  final TextEditingController _controller;
  final String hintText;

  //Constructor
  InputFormField(this._controller, this.hintText);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
          hintText: hintText,
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
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
    );
  }
}

//Text Button
class CustomTextButton extends StatelessWidget {
  final String routeName;
  final String text;

  //Constructor
  CustomTextButton(this.text, this.routeName);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => Navigator.pushNamed(context, routeName),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            decoration: TextDecoration.underline,
            decorationColor: Colors.white,
          ),
        ));
  }
}

//Statefull
class DynamicMenu extends StatefulWidget {
  final TextEditingController iconController;
  final Function(IconLabel?) onSelected;
  final bool isFormSubmitted;

  DynamicMenu(this.iconController, this.onSelected,this.isFormSubmitted);

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
        trailingIcon: const Icon(Icons.arrow_drop_down, color: Colors.white),
        label: Text(
          'Select Role',
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide:  BorderSide(color: widget.isFormSubmitted && selectedIcon == null ? Colors.red : Colors.white)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: widget.isFormSubmitted && selectedIcon == null ? Colors.red : Colors.white),
          ),
        ),
        onSelected: (icon){
          setState(() {
            selectedIcon=icon;
          });
          widget.onSelected(icon);
        },
        dropdownMenuEntries: IconLabel.values.map<DropdownMenuEntry<IconLabel>>(
          (IconLabel icon) {
            return DropdownMenuEntry<IconLabel>(
              value: icon,
              label: icon.label,
              leadingIcon: Icon(icon.icon),
              style: MenuItemButton.styleFrom(
                  // foregroundColor: Colors.white,

                  ),
            );
          },
        ).toList(),
      ),
    );
  }
}

//Custom Snack bar
class CustomSnackBar {
  static void show(BuildContext context, String message, {String bg = "white"}) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 40,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: bg == 'red' ? Colors.red : Colors.green,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              message,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );

    // Insert the overlay entry
    Overlay.of(context)!.insert(overlayEntry);

    // Remove it after a delay
    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}
