import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/constant/app_colors.dart';
import 'package:property_managment/core/provider/is_loading.dart';
import 'package:property_managment/core/utils/appbar_widget.dart';
import 'package:property_managment/core/utils/bottom_navigation_bar.dart';
import 'package:property_managment/core/utils/checkbox.dart';
import 'package:property_managment/core/utils/green_button.dart';
import 'package:property_managment/core/utils/text_field.dart';
import 'package:property_managment/core/enum/save_button.dart';
import 'package:property_managment/features/property/controllers/property_cntlr.dart';
import 'package:property_managment/modelClass/property_model.dart';

class AddLandlordDetails extends ConsumerStatefulWidget {
  final String from;
  final PropertyModel? property;
  final Map<String, dynamic> propertyMap;
  AddLandlordDetails({
    super.key,
    required this.propertyMap,
    required this.from,
    required this.property,
  });

  @override
  ConsumerState<AddLandlordDetails> createState() => _AddLandlordDetailsState();
}

class _AddLandlordDetailsState extends ConsumerState<AddLandlordDetails> {
  FirebaseFirestore fdb = FirebaseFirestore.instance;

  final frmKey = GlobalKey<FormState>();

  Widget divider = SizedBox(height: 10);

  // bool isOwnProperty = false;
  TextEditingController nameCtlr = TextEditingController();

  TextEditingController emailCtlr = TextEditingController();

  TextEditingController contactCtlr = TextEditingController();

  SaveButtonMode _saveButtonMode = SaveButtonMode.save;

  _clearControllers() {
    nameCtlr.clear();
    emailCtlr.clear();
    contactCtlr.clear();
  }

  setControllersForUpdate() {
    log(
      'reached here owner page : ${widget.from}    property: ${widget.property}',
    );
    if (widget.from == "Edit" && widget.property != null) {
      nameCtlr.text = widget.property!.ownername;
      emailCtlr.text = widget.property!.email;
      contactCtlr.text = widget.property!.contact;
      // isOwnProperty = property!.isOwner;
      _saveButtonMode = SaveButtonMode.edit;
    }
    // setState(() {

    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setControllersForUpdate();
  }

  @override
  Widget build(BuildContext context) {
    final repo = ref.read(propertyRepoProvider);
    final isOwnProperty = ref.watch(isOwnPropertyProvider);
    final isLoading = ref.watch(loadingProvider);
    final userName =ref.watch(userNameProvider);

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
                  onChanged: (value) {
                    // isOwnProperty = value ?? false;
                    ref.read(isOwnPropertyProvider.notifier).state =
                        value ?? false;
                    // ref.read(propertyFormProvider.notifier).updateIsOwner(isOwnProperty);
                    ref
                        .read(propertyFormProvider.notifier)
                        .updateIsOwner(value ?? false);
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
                      ref
                          .read(propertyFormProvider.notifier)
                          .updateOwnerName(value);
                      return null;
                    },
                    readOnly: false,
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
                      ref
                          .read(propertyFormProvider.notifier)
                          .updateContact(value);
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
                      ref
                          .read(propertyFormProvider.notifier)
                          .updateEmail(value);
                      return null;
                    },
                    readOnly: false,
                  ),
                  divider,
                ],
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child:isLoading? CircularProgressIndicator(
                color: AppColors.greenColor,
                padding: EdgeInsets.symmetric(horizontal: 140),
              )
        : GreenButton(
          text: 'Submit',
          onTap: () async {
            if (frmKey.currentState!.validate()) {
              Map<String, dynamic> ownerDetails = {
                "IS_OWN_PROPERTY": isOwnProperty ? "YES" : "NO",
                "OWNER_NAME": nameCtlr.text.trim(),
                "OWNER_CONTACT": contactCtlr.text.trim(),
                "OWNER_EMAIL": emailCtlr.text.trim(),
              };
              Map<String, dynamic> finaldetails = {
                ...widget.propertyMap,
                ...ownerDetails,
              };
              log("asdfghjkl $finaldetails");
              if (_saveButtonMode == SaveButtonMode.save) {
                await repo.addProperties(finaldetails,userName.value!);
              } else {
                await repo.updateproperty(widget.property!.id, finaldetails);
              }
              // _clearControllers();
              ref.read(propertyFormProvider.notifier).clear();
              ref.read(propertyImagesProvider.notifier).clear();
              ref.read(propertyFormProvider.notifier).updateIsOwner(false);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (contex) => BottomNavigationWidget(
                    currentIndex: 1,
                    propertytype: [],
                    price: null,
                    sqft: null,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
