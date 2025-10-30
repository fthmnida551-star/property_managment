import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/firebase/firebase_service.dart';
import 'package:property_managment/firebase/save_button.dart';
import 'package:property_managment/presentation/propertydetails/animated_tick.dart';
import 'package:property_managment/widget/appbar_widget.dart';
import 'package:property_managment/widget/date_picker.dart';
import 'package:property_managment/widget/green_button.dart';
import 'package:property_managment/widget/text_field.dart';

class BookingDetails extends StatefulWidget {
 const BookingDetails({super.key});

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  FirebaseFirestore fdb = FirebaseFirestore.instance;
  final formKey = GlobalKey<FormState>();
  Widget divider = SizedBox(height: 10);
  TextEditingController namectlr = TextEditingController();
  TextEditingController contactCtlr = TextEditingController();
  TextEditingController emailCtlr = TextEditingController();
  TextEditingController datectlr = TextEditingController();
  final SaveButtonMode _saveButtonMode = SaveButtonMode.save;

  _clearControllers() {
    namectlr.clear();
    contactCtlr.clear();
    emailCtlr.clear();
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
                'Add Booking Dtails',
                style: TextStyle(color: AppColors.white, fontSize: 19.sp),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                TextFieldContainer(
                  text: 'Name',
                  controllerName: namectlr,
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
                CalendarPickerContainer(
                  hintText: 'Select date',

                  validator: (date) {
                    if (date == null) {
                      return 'Please select a date';
                    }
                    return null;
                  },
                  controller: datectlr,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GreenButton(
          text: 'Save',
          onTap: () {
            if (formKey.currentState!.validate()) {
              Map<String, dynamic> bookingDetails = {};
              if (_saveButtonMode == SaveButtonMode.save) {
                bookingDetails = {
                  "NAME": namectlr.text.trim(),
                  "CONTACT": int.tryParse(contactCtlr.text.trim()),
                  "EMAIL": emailCtlr.text.trim(),
                  "DATE": datectlr.text.trim(),
                };
              }
              addbookingDetails(bookingDetails);
              _clearControllers();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GrowContainer()),
              );
            }
          },
        ),
      ),
    );
  }

  void addbookingDetails(Map<String, dynamic> bookingData) async {
    await fdb.collection("BOOKING DETAILS").add(bookingData).then((
      DocumentReference<Map<String, dynamic>> docRef,
    ) {
      final String id = docRef.id;

      log("Insert Data with $id");
    });
  }
}
