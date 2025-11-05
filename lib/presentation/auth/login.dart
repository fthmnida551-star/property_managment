import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/core/theme/app_textstyl.dart';
import 'package:property_managment/core/theme/asset_resource.dart';
import 'package:property_managment/firebase/firebase_service.dart';
import 'package:property_managment/firebase/save_button.dart';
import 'package:property_managment/modelClass/user_model.dart';
import 'package:property_managment/widget/bottom_navigation_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseFirestore fdb = FirebaseFirestore.instance;
  bool _obscurePassword = true;
  final _saveButtonMode = SaveButtonMode.save;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailcntrlr = TextEditingController();
  final TextEditingController passwordcntrlr = TextEditingController();

  _clearControllers() {
    emailcntrlr.clear();
    passwordcntrlr.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 80.h),

                /// ✅ Logo
                Center(
                  child: Image.asset(
                    AssetResource.name,
                    width: 184.4.w,
                    height: 78.7.h,
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: 50.h),

                /// ✅ Email Field
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: AppColors.greyColor.withOpacity(0.4),
                    ),
                  ),
                  child: TextFormField(
                    controller: emailcntrlr,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.blackColor,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: AppColors.greenColor,
                      ),
                      hintText: "Email/phone",
                      hintStyle: TextStyle(
                        color: AppColors.greyColor,
                        fontSize: 16.sp,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      }
                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(height: 20.h),

                /// ✅ Password Field
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: AppColors.greyColor.withOpacity(0.4),
                    ),
                  ),
                  child: TextFormField(
                    controller: passwordcntrlr,

                    obscureText: _obscurePassword,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.blackColor,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: AppColors.greenColor,
                      ),
                      hintText: "Password",
                      hintStyle: TextStyle(
                        color: AppColors.greyColor,
                        fontSize: 16.sp,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.blackColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter password";
                      }
                      // if (value.length < 8) {
                      //   return "Password must be at least 8 characters long";
                      // }
                      // if (!RegExp(r'[!@#\$&*~_.,?-]').hasMatch(value)) {
                      //   return "Password must contain at least one special character";
                      // }
                      return null;
                    },
                  ),
                ),

                SizedBox(height: 10.h),

                /// ✅ Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(50.w, 20.h),
                    ),
                    child: Text(
                      "Forgot your password",
                      style: AppTextstyle.propertysmallTextstyle(
                        context,
                        fontSize: 12.sp,
                        fontColor: AppColors.blackColor,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                /// ✅ Login Button
                SizedBox(
                  height: 50.h,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.greenColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try{
                        await fdb
                            .collection('STAFF')
                            .where(
                              "USER_EMAIL",
                              isEqualTo: emailcntrlr.text.trim(),
                            )
                            .where(
                              "USER_PASSWORD",
                              isEqualTo: passwordcntrlr.text.trim(),
                            )
                            .get()
                            .then((value) {
                              if (value.docs.isNotEmpty) {
                                Map<String, dynamic> userMap = value.docs.first.data();
                                UserModel user = UserModel.fromMap(userMap, value.docs.first.id);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BottomNavigationWidget(currentIndex: 0, loginUser: user,),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "invalid email or password!",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                );
                              }
                          
                            });
                        // FirebaseService().addUsers(finaldetails);

                        _clearControllers();
                      }
                      catch(e){
                        log("error in login  $e");
                      }
                      }
                      

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         BottomNavigationWidget(currentIndex: 0),
                      //   ),
                      // );
                    },
                    child: Text(
                      "Login",
                      style: AppTextstyle.propertyMediumTextstyle(
                        context,
                        fontSize: 16.sp,
                        fontColor: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
