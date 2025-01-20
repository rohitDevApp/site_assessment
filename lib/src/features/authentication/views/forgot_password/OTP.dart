import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:site_assessment/src/common_widgets/common.dart';

class OTP extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OtpState();
}

//State
class OtpState extends State<OTP> {
  final TextEditingController otp = TextEditingController();
  final formKey = GlobalKey<FormState>();

  //handler Forgot Password
  passwordHandler() {
    if (formKey.currentState!.validate()) {
      otp.clear();
      CustomSnackBar.show(context, 'Verified OTP');
      Navigator.pushNamed(context, 'password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg.jpg'), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
              child: Stack(
            children: [
              AuthHeader("OTP"),
              Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.3,
                      left: 20,
                      right: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        OtpHeader(),
                        SizeBox(60),
                        OtpArea(),
                        SizeBox(30),
                        NextWithIcon(passwordHandler)
                      ],
                    ),
                  ))
            ],
          )),
        ));
  }
}

//OTP Header
class OtpHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          children: [
            Row(children: [
              Text(
                "Verification Code \nWe have sent the code verification to your email.",
                style: TextStyle(color: Colors.white, fontSize: 14),
              )
            ]),
          ],
        )
      ],
    );
  }
}

//OTP Screen
class OtpArea extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 68,
          width: 68,
          child: TextFormField(
            onChanged: (value){
              if(value.length==1){
                FocusScope.of(context).nextFocus();
              }
            },
            style: Theme.of(context).textTheme.headlineLarge,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
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
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ),SizedBox(
          height: 68,
          width: 68,
          child: TextFormField(
            onChanged: (value){
              if(value.length==1){
                FocusScope.of(context).nextFocus();
              }else if(value.isEmpty){
                FocusScope.of(context).previousFocus();
              }
            },
            style: Theme.of(context).textTheme.headlineLarge,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
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
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ),SizedBox(
          height: 68,
          width: 68,
          child: TextFormField(
            onChanged: (value){
              if(value.length==1){
                FocusScope.of(context).nextFocus();
              }else if(value.isEmpty){
                FocusScope.of(context).previousFocus();
              }
            },
            style: Theme.of(context).textTheme.headlineLarge,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
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
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ),SizedBox(
          height: 68,
          width: 68,
          child: TextFormField(
            onChanged: (value){
              if(value.length==1){
                FocusScope.of(context).nextFocus();
              }else if(value.isEmpty){
                FocusScope.of(context).previousFocus();
              }
            },
            style: Theme.of(context).textTheme.headlineLarge,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
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
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ),
      ],
    );
  }

}



