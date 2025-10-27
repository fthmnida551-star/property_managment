import 'package:flutter/material.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/widget/bottom_navigation_bar.dart';
import 'package:property_managment/widget/green_button.dart';
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
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 200,
                child: Center(child: Text("Sing Up",style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),))),
          
              TextFieldContainer(text: 'Name', controllerName: nameCtrl, validator: (String? value) {
                if(value==null || value.isEmpty){
                  return "Please enter your name";
                }
                if(!RegExp(r'^[A-Z]').hasMatch(value)){
                  return 'First letter must be capital letter';
                }
                return null;
                },), 
              SizedBox(height: 20),
              
              TextFieldContainer(text: "Email", controllerName: emailCtrl, validator: (String? value) { 
                if(value==null || value.isEmpty){
                  return 'please enter your email';
                }
                if(!value.contains('@')){
                  return 'please enter a valid email address';
                }
                return null;
              },),
               SizedBox(height: 20),
              TextFieldContainer(text: 'Password', controllerName: passwordCtrl, validator: (String? value) { 
                if(value==null || value.isEmpty){
                  return 'please enter your password';
                }
                if ( value.length <  8 ){
                   return 'password must be at least 8 characters';
                }
                return null;
              },),
              
               SizedBox(height: 20),
              TextFieldContainer(text: 'Confirm Password', controllerName: confirmpasswordCtrl, validator: (String? value) { 
                if(value==null || value.isEmpty){
                  return 'please enter your confirm password';
                }
                if(value!= passwordCtrl.text){
                  return 'password do not match';
                }
                return null;
              }, ),
              SizedBox(height: 55,),
              GreenButton(
        text: 'Sign up',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNavigationWidget(currentIndex: 0),
            ),
          );
        },
      ),
            ],
          ),
        ),
      ),
      //  bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: GreenButton(
      //     text: 'Sign Up',
      //     onTap: () {  
      //         Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (contex) => BottomNavigationWidget(currentIndex: 1),
      //         ),
      //       );
      //     },
      //   ),
      // ),
      
    );
  }
}