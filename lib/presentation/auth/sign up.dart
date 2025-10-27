import 'package:flutter/material.dart';
import 'package:property_managment/widget/text_field.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  // final _formkey = GlobalKey<FormState>();
  final TextEditingController nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Sing Up"),

            TextFieldContainer(text: 'Name', controllerName: nameCtrl),
            
          ],
        ),
      ),
    );
  }
}