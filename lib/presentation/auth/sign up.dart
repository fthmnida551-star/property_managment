import 'package:flutter/material.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/widget/text_field.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  // final _formkey = GlobalKey<FormState>();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmpasswordCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 200,
              child: Center(child: Text("Sing Up",style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),))),

            TextFieldContainer(text: 'Name', controllerName: nameCtrl, validator: (String? p1) {  },), 
            SizedBox(height: 20),
            TextFieldContainer(text: "Email", controllerName: emailCtrl, validator: (String? p1) { },),
             SizedBox(height: 20),
            TextFieldContainer(text: 'Password', controllerName: passwordCtrl, validator: (String? p1) { },),
             SizedBox(height: 20),
            TextFieldContainer(text: 'Confirm Password', controllerName: confirmpasswordCtrl, validator: (String? p1) { },),
          ],
        ),
      ),
    );
  }
}