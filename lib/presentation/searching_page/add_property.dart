import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/core/theme/asset_resource.dart';
import 'package:property_managment/firebase/firebase_service.dart';
import 'package:property_managment/firebase/save_button.dart';
import 'package:property_managment/presentation/searching_page/add_landlord_details.dart';
import 'package:property_managment/widget/appbar_widget.dart';
import 'package:property_managment/widget/green_button.dart';
import 'package:property_managment/widget/text_field.dart';
import 'package:image_picker/image_picker.dart';

class AddProperty extends StatefulWidget {
  const AddProperty({super.key});

  @override
  State<AddProperty> createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  final formKey = GlobalKey<FormState>();
  Widget divider = SizedBox(height: 10);
  TextEditingController propertyTypeCtlr = TextEditingController();
  TextEditingController detailsCtlr = TextEditingController();
  TextEditingController locationCtlr = TextEditingController();
  TextEditingController descriptionCtlr = TextEditingController();
  TextEditingController priceCtlr = TextEditingController();
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      // imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  final SaveButtonMode _saveButtonMode = SaveButtonMode.save;

  clearController() {
    propertyTypeCtlr.clear();
    detailsCtlr.clear();
    locationCtlr.clear();
    descriptionCtlr.clear();
    priceCtlr.clear();
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
                'Add Property',
                style: TextStyle(color: AppColors.white, fontSize: 19.sp),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 368,
                      height: 200,
                      decoration: BoxDecoration(
                        color: AppColors.searchbar,
                        borderRadius: BorderRadius.circular(8),
                        border: BoxBorder.all(
                          width: 1,
                          color: AppColors.opacitygreyColor,
                        ),
                        image: _selectedImage != null
                            ? DecorationImage(
                                image: FileImage(_selectedImage!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: _selectedImage == null
                          ? Center(
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: AppColors.greenColor,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(AssetResource.camera),
                                ),
                              ),
                            )
                          : Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedImage = null; // remove image
                                    });
                                  },
                                  child: const CircleAvatar(
                                    radius: 16,
                                    backgroundColor: Colors.black54,
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                TextFieldContainer(
                  text: 'Property Type',
                  controllerName: propertyTypeCtlr,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter  property type';
                    }

                    return null; // valid input
                  },
                ),
                divider,
                TextFieldContainer(
                  text: 'Price',
                  controllerName: priceCtlr,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter  property price';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Only numbers allowed';
                    }
                    return null;
                  },
                ),
                divider,
                TextFieldContainer(
                  text: 'Details',
                  controllerName: detailsCtlr,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter property details';
                    }
                    return null;
                  },
                ),
                divider,
                TextFieldContainer(
                  text: 'Description',
                  controllerName: descriptionCtlr,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter property description';
                    }
                    return null;
                  },
                ),
                divider,
                TextFieldContainer(
                  text: 'Location',
                  controllerName: locationCtlr,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the location';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GreenButton(
          text: 'Next',
          onTap: () {
            if (_saveButtonMode == SaveButtonMode.save) {
              Map<String, dynamic> propertyDetailsAll = {
                "PROPERTY TYPE" : propertyTypeCtlr,
                "PROPERTY PRICE" :priceCtlr,
                "PROPERTY DETAILS":detailsCtlr,
                "PROPERTY DESCRIPTION":descriptionCtlr,
                "PROPERTY LOCATION":locationCtlr,

              };
              FirebaseService().addProperties(propertyDetailsAll);
              clearController();
            }
            if (formKey.currentState!.validate()) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddLandlordDetails()),
              );
            }
          },
        ),
      ),
    );
  }
}
