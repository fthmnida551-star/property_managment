import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/core/theme/asset_resource.dart';
import 'package:property_managment/presentation/profile/profile.dart';

import 'package:property_managment/widget/appbar_widget.dart';
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
                child: Icon(Icons.keyboard_arrow_left),
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
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Image.asset(AssetResource.profilepic),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                        color: AppColors.greenColor,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: IconButton(
                          icon: const Icon(
                            Icons.add,
                            color: AppColors.white,
                            size: 17.0,
                          ),
                          onPressed: () {},
                        ),
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
                controllerName: emailCtrl,
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
                      labelText: 'Change Password',
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
            Spacer(),
            GreenButton(
              text: 'submit',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profilescreen()),
                );
              },
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
