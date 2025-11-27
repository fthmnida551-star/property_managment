import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:property_managment/core/constant/app_colors.dart';
import 'package:property_managment/core/provider/is_loading.dart';
import 'package:property_managment/core/utils/appbar_widget.dart';
import 'package:property_managment/core/utils/bottom_navigation_bar.dart';
import 'package:property_managment/core/utils/cloudinary_img/dio.dart';
import 'package:property_managment/core/utils/green_button.dart';
import 'package:property_managment/core/utils/text_field.dart';
import 'package:property_managment/features/profile/controllers/profileControllers.dart';
import 'package:property_managment/modelClass/user_model.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  final UserModel loginUser;
  const EditProfileScreen({super.key, required this.loginUser});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditprofileScreenState();
}

class _EditprofileScreenState extends ConsumerState<EditProfileScreen> {
  final _formkey = GlobalKey<FormState>();
  bool obscurePassword = false;
  TextEditingController nameCtlr = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController roleCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  String? existingImageUrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameCtlr.text = widget.loginUser.name;
    emailCtrl.text = widget.loginUser.email;
    passwordCtrl.text = widget.loginUser.password;
    existingImageUrl =
        (widget.loginUser.profileImage != null &&
            widget.loginUser.profileImage!.isNotEmpty)
        ? widget.loginUser.profileImage
        : null;
  }

  pickImg(WidgetRef ref) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1600,
    );
    if (picked == null) return;

    ref.read(profileImageProvider.notifier).setImage(File(picked.path));
  }

  @override
  Widget build(BuildContext context) {
    final repo = ref.read(profileRepositoryProvider);
    final pickedImage = ref.watch(profileImageProvider);
    final isLoading = ref.watch(loadingProvider);
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
          child: Form(
            key: _formkey,
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
                        image: pickedImage != null
                            ? DecorationImage(
                                image: FileImage(pickedImage),
                                fit: BoxFit.cover,
                              )
                            : (existingImageUrl != null
                                  ? DecorationImage(
                                      image: NetworkImage(existingImageUrl!),
                                      fit: BoxFit.cover,
                                    )
                                  : null),
                      ),
                      child: pickedImage == null
                          ? null
                          : Icon(
                              Icons.person,
                              color: AppColors.OpacitygreyColor,
                            ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 5,
                      child: InkWell(
                        onTap: () => pickImg(ref),
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
                    readOnly: false,
                  ),
                ),
                SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 15),
                  child: TextFieldContainer(
                    text: 'Email',
                    controllerName: emailCtrl,
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
                      child: TextFormField(
                        controller: passwordCtrl,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 8) {
                            return 'password must be at laest 8 characters';
                          }
                          return null;
                        },
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

                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: isLoading ?CircularProgressIndicator(
                color: AppColors.greenColor,
                padding: EdgeInsets.symmetric(horizontal: 140),
              )
            :  GreenButton(
          text: 'submit',
          onTap: () async {
            if (_formkey.currentState!.validate()) {
              File? imageFile = ref.read(profileImageProvider);

              String finalImageUrl = "";

              if (imageFile != null) {
                final urls = await uploadUnsigned(
                  imageFile,
                  cloudName: 'dcijrvaw3',
                  uploadPreset: 'property_images',
                );
                finalImageUrl = urls;
              } else {
                finalImageUrl = existingImageUrl ?? '';
              }

              Map<String, dynamic> userDetails = {
                'ID': widget.loginUser.id,
                "USER_NAME": nameCtlr.text.trim(),
                "USER_EMAIL": emailCtrl.text.trim(),
                "USER_PASSWORD": passwordCtrl.text.trim(),
                "PROFILE_IMAGE": finalImageUrl,
              };
              //await updatePerson(userDetails);
              await ref
                  .read(updateProfileControllerProvider.notifier)
                  .updateUser(userDetails);

              // ⭐ Clear image provider after saving
              ref.read(profileImageProvider.notifier).clear();
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavigationWidget(
                  currentIndex: 3,
                  propertytype: [],
                  price: null,
                  sqft: null,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // updatePerson(Map<String, dynamic> userDetails) async {
  //   FirebaseFirestore.instance.collection("STAFF").doc(widget.loginUser.id)
  //    .update(userDetails).then((value) {
  //   log("Updated successfully");
  // }).onError((e, stackTrace) {
  //   log("Error is $e", name: "oxdo");
  // });
  // }
}
