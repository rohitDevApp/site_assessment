import 'package:flutter/material.dart';

class Password extends StatefulWidget {
  final TextEditingController _controller;
  final TextEditingController? confirmController;
  final String hintText;
  final bool obscureText;

  //Constructor
  const Password(
      this._controller,
      this.hintText, {super.key,
        this.confirmController,
        this.obscureText = true,
      });
  @override
  State<StatefulWidget> createState() => PasswordState();
}

//State
class PasswordState extends State<Password> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: widget._controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
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
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
        ),
      ),
      validator: (value) {
        String trimmedValue = value?.trim() ?? '';

        if (trimmedValue.isEmpty) {
          return '${widget.hintText} Required ';
        }

        //Password
        if (["New Password","Password"].contains(widget.hintText) &&
            !RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
                .hasMatch(trimmedValue)) {
          return 'Password must be strong';
        }

        //Confirm Password
        if (widget.confirmController?.text != value &&
            widget.hintText == 'Confirm Password') {
          return 'Password does not match';
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}