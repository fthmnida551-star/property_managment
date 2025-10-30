import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/widget/appbar_widget.dart';
import 'package:property_managment/widget/bottom_navigation_bar.dart';
import 'package:property_managment/widget/green_button.dart';
import 'package:property_managment/widget/text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditprofileScreenState();
}

class _EditprofileScreenState extends State<EditProfileScreen> {
  bool obscurePassword = false;
  TextEditingController emailCtrl = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.keyboard_arrow_left,
                  size: 30,
                  color: AppColors.white,
                ),
              ),
            ),
            SizedBox(width: 10),
            const Text(
              'Edit Profile',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 21,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 10.0, top: 15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: AppColors.OpacitygreyColor),
                       image: _selectedImage != null
                          ? DecorationImage(
                              image: FileImage(_selectedImage!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _selectedImage != null
                        ? null
                        : Icon(Icons.person, color: AppColors.OpacitygreyColor),
                    // Image.asset(AssetResource.profilepic),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 5,
                    child: InkWell(
                      onTap: () => _pickImage(),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: AppColors.greenColor,
                          shape: BoxShape.circle,
                        ),
                      
                        child: const Icon(
                          Icons.add,
                          color: AppColors.white,
                          size: 20.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 15),
                child: TextFieldContainer(
                  text: 'Email',
                  controllerName: emailCtrl, validator: (String? p1) {  },
                ),
              ),
              SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 15),
                child: Container(
                  height: 50.h,
                  width: 350.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: BoxBorder.all(
                      width: 1,
                      color: AppColors.opacitygreyColor,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      obscureText: obscurePassword,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Change Password',
                        hintStyle: TextStyle(
                          fontSize: 18.sp,
                          color: AppColors.opacitygrayColorText,
                        ),

                        suffixIcon: IconButton(
                          icon: obscurePassword
                              ? Icon(Icons.visibility_off_outlined)
                              : Icon(Icons.visibility_outlined),
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Spacer(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GreenButton(
          text: 'submit',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavigationWidget(currentIndex: 3),
              ),
            );
          },
        ),
      ),
    );
  }
   void updatePerson(PersonModel editProfile) async {
    final DocumentReference<Map<String, dynamic>> documentRef =
        FirebaseFirestore.instance.collection("EDIT PROFILE").doc(editProfile.id);
    await documentRef.update(editProfile.toJson()).then((value) {
      log("Updated successfully");
    }).onError((e, stack) {
      log("Error is $e", name: "oxdo");
    });
    // getAllPersonList();
  }
}