import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:property_managment/core/constant/app_colors.dart';
import 'package:property_managment/core/provider/sharepreference.dart';
import 'package:property_managment/core/utils/appbar_widget.dart';
import 'package:property_managment/core/utils/date_picker.dart';
import 'package:property_managment/core/utils/green_button.dart';
import 'package:property_managment/core/utils/text_field.dart';
import 'package:property_managment/core/enum/save_button.dart';
import 'package:property_managment/features/booking/controller/booking_controllers.dart';
import 'package:property_managment/features/property/controllers/property_cntlr.dart';
import 'package:property_managment/modelClass/bookingmodel.dart';
import 'package:property_managment/features/property/screens/propertydetails/animated_tick.dart';

class BookingDetails extends ConsumerStatefulWidget {
  final String propertyId;
  final BookingModel? bookedData;

  BookingDetails({
    super.key,
    required this.propertyId,
    required this.bookedData,
  });

  @override
  ConsumerState<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends ConsumerState<BookingDetails> {
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
    if (widget.bookedData != null) {
      namectlr.text = widget.bookedData!.name;
      contactCtlr.text = widget.bookedData!.contact;
      emailCtlr.text = widget.bookedData!.email;
      datectlr.text = widget.bookedData!.date;
      _saveButtonMode = SaveButtonMode.edit;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editBooking();
  }

  @override
  Widget build(BuildContext context) {
    final repo = ref.watch(bookingRepoProvider);
    final username=ref.watch(userNameProvider);
    
    log('contains: ${widget.bookedData}');
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
                  readOnly: false,
                ),
                divider,
                TextFieldContainer(
                  text: 'Contact',
                  keyboardType: TextInputType.phone,
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
                  readOnly: false,
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
                  readOnly: false,
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
              String id = DateTime.now().millisecondsSinceEpoch.toString();
              bookingDetails = {
                "NAME": namectlr.text.trim(),
                "CONTACT": int.tryParse(contactCtlr.text.trim()),
                "EMAIL": emailCtlr.text.trim(),
                "DATE": datectlr.text.trim(),
                "PROPERTY_ID": widget.propertyId,
                "ADDED_DATE": DateTime.now(),
                'BOOKING_ID':id
              };

              final prptyRepo= await ref.read(propertySingleProvider).getSingleProperty(widget.propertyId);

              if (_saveButtonMode == SaveButtonMode.save) {
                await repo.addbookingDetails(bookingDetails,username.value!,prptyRepo);
              } else {
                await repo.updateBooking(widget.bookedData!.id, bookingDetails);
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
