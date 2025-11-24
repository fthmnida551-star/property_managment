import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:property_managment/core/constant/app_colors.dart';
import 'package:property_managment/core/utils/appbar_widget.dart';
import 'package:property_managment/core/utils/date_picker.dart';
import 'package:property_managment/core/utils/green_button.dart';
import 'package:property_managment/core/utils/text_field.dart';
import 'package:property_managment/core/enum/save_button.dart';
import 'package:property_managment/features/booking/controller/booking_controllers.dart';
import 'package:property_managment/modelClass/bookingmodel.dart';
import 'package:property_managment/features/property/screens/propertydetails/animated_tick.dart';

class BookingDetails extends ConsumerWidget {
  final String propertyId;
  final BookingModel? bookedData;
  
   BookingDetails({
    super.key,
    required this.propertyId,
    required this.bookedData,
  
  });

  FirebaseFirestore fdb = FirebaseFirestore.instance;

  final formKey = GlobalKey<FormState>();

  Widget divider = SizedBox(height: 10);

  TextEditingController namectlr = TextEditingController();

  TextEditingController contactCtlr = TextEditingController();

  TextEditingController emailCtlr = TextEditingController();

  TextEditingController datectlr = TextEditingController();

  SaveButtonMode _saveButtonMode = SaveButtonMode.save;

  _clearControllers() {
    namectlr.clear();
    contactCtlr.clear();
    emailCtlr.clear();
  }

  editBooking() {
    if (bookedData != null) {
      namectlr.text = bookedData!.name;
      contactCtlr.text = bookedData!.contact;
      emailCtlr.text = bookedData!.email;
      datectlr.text = bookedData!.date;
      _saveButtonMode = SaveButtonMode.edit;
    }
    
  }

  // @override
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final repo=ref.watch(bookingRepoProvider);
    log('contains: $bookedData');
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
                _saveButtonMode == SaveButtonMode.save
                    ? 'Add Booking Details'
                    : 'Edit Booking Details', // 🟩 CHANGED: dynamic title
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                  fontSize: 21,
                ),
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
          onTap: () async {
            if (formKey.currentState!.validate()) {
              Map<String, dynamic> bookingDetails = {};
              bookingDetails = {
                "NAME": namectlr.text.trim(),
                "CONTACT": int.tryParse(contactCtlr.text.trim()),
                "EMAIL": emailCtlr.text.trim(),
                "DATE": datectlr.text.trim(),
                "PROPERTY_ID": propertyId,
                "ADDED_DATE": DateTime.now(),
                
              };

              if (_saveButtonMode == SaveButtonMode.save) {
                await repo.addbookingDetails(bookingDetails);
              } else {
                await repo.updateBooking(bookedData!.id, bookingDetails);
              }
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
}
