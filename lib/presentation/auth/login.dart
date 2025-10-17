import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/core/theme/app_textstyl.dart';
import 'package:property_managment/core/theme/asset_resource.dart';
import 'package:property_managment/widget/bottom_navigation_bar.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;
  @override
  @override
void initState() {
  super.initState();

  Future.delayed(const Duration(seconds: 3), () {
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BottomNavigationWidget(currentIndex: 0),
      ),
    );
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
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
                  border: Border.all(color: AppColors.greyColor.withOpacity(0.4)),
                ),
                child: TextField(
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
                ),
              ),

              SizedBox(height: 20.h),

              /// ✅ Password Field
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: AppColors.greyColor.withOpacity(0.4)),
                ),
                child: TextField(
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
                  onPressed: () {},
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
    );
  }
}