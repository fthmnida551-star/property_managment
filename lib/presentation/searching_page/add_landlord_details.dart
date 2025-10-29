import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/firebase/firebase_service.dart';
import 'package:property_managment/firebase/save_button.dart';
import 'package:property_managment/widget/appbar_widget.dart';
import 'package:property_managment/widget/bottom_navigation_bar.dart';
import 'package:property_managment/widget/checkbox.dart';
import 'package:property_managment/widget/green_button.dart';
import 'package:property_managment/widget/text_field.dart';

class AddLandlordDetails extends StatefulWidget {
  final Map<String, dynamic> propertyMap;
  const AddLandlordDetails({super.key, required this.propertyMap});

  @override
  State<AddLandlordDetails> createState() => _AddLandlordDetailsState();
}

class _AddLandlordDetailsState extends State<AddLandlordDetails> {
  final frmKey = GlobalKey<FormState>();
  Widget divider = SizedBox(height: 10);
  bool isOwnProperty = false;
  TextEditingController nameCtlr = TextEditingController();
  TextEditingController emailCtlr = TextEditingController();
  TextEditingController contactCtlr = TextEditingController();
  final SaveButtonMode _saveButtonMode = SaveButtonMode.save;
  _clearControllers() {
    nameCtlr.clear();
    emailCtlr.clear();
    contactCtlr.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.keyboard_arrow_left_outlined,
                  color: AppColors.white,
                  size: 30,
                ),
              ),
              Text(
                'Add Landlord',
                style: TextStyle(color: AppColors.white, fontSize: 19.sp),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: frmKey,
            child: Column(
              children: [
                CheckboxWithListenable(
                  text: 'Own Property',
                  value: isOwnProperty,
                  onChanged: (newValue) {
                    setState(() {
                      isOwnProperty = newValue ?? false;
                    });
                  },
                ),

                if (!isOwnProperty) ...[
                  SizedBox(height: 20),
                  TextFieldContainer(
                    text: 'Name',
                    controllerName: nameCtlr,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      if (!RegExp(r'^[A-Z]').hasMatch(value)) {
                        return 'First letter must be a capital letter';
                      }
                      return null;
                    },
                  ),
                  divider,
                  TextFieldContainer(
                    text: 'Contact',
                    controllerName: contactCtlr,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your contact number';
                      }
                      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Only numbers are allowed';
                      }
                      if (value.length != 10) {
                        return 'Contact number must be 10 digits';
                      }
                      return null;
                    },
                  ),
                  divider,
                  TextFieldContainer(
                    text: 'Email',
                    controllerName: emailCtlr,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }

                      if (!value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  divider,
                  // CalendarPickerContainer(hintText: 'date'),
                ],
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GreenButton(
          text: 'Submit',
          onTap: () {
            if (frmKey.currentState!.validate()) {
              if (_saveButtonMode == SaveButtonMode.save) {
                Map<String, dynamic> ownerDetails = {
                  "IS_OWN_PROPERTY": isOwnProperty ? "YES" : "NO",
                  "OWNER_NAME": nameCtlr.text.trim(),
                  "OWNER_CONTACT": int.tryParse(contactCtlr.text.trim()),
                  "OWNER_EMAIL": emailCtlr.text.trim(),
                };
                Map<String, dynamic> finaldetails = {
                  ...widget.propertyMap,
                  ...ownerDetails,
                };
                log("asdfghjkl $finaldetails");
                FirebaseService().addProperties(finaldetails);
                _clearControllers();
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (contex) => BottomNavigationWidget(currentIndex: 1),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
