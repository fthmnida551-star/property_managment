import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/core/theme/asset_resource.dart';
import 'package:property_managment/modelClass/user_model.dart';
import 'package:property_managment/presentation/profile/adding_users.dart';
import 'package:property_managment/presentation/profile/edit_profile.dart';
import 'package:property_managment/presentation/profile/users_screen.dart';
import 'package:property_managment/presentation/propertydetails/widget/logout_alert.dart';
import 'package:property_managment/widget/appbar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  bool isSwitched = false;
  String userRole = '';
   @override
  void initState() {
    super.initState();
    getUserRole(); 
  }
  
  getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    userRole = prefs.getString('role') ?? "";
    log("vvvvvvvvv $userRole");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ Custom AppBar
      appBar: AppbarWidget(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(width: 15),
                const Text(
                  'Profile',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            // Image.asset(
            //   AssetResource.moonpic,
            //   height: 24,
            //   width: 24,
            //   color: Colors.white,
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  logoutAlert(context);
                  // Navigator.pop(context);
                },
                child: Icon(Icons.logout, color: AppColors.white),
              ),
            ),
          ],
        ),
      ),

      // ✅ Body
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
        child: Column(
          children: [
            // ✅ Profile Card
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.opacityGrey.withOpacity(0.2),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      AssetResource.profilepic,
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 15),

                  // ✅ Name & Email
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "",
                          style: TextStyle(
                            fontSize: 23.sp,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "widget.loginUser.email",
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 17.sp,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  // ✅ Edit Icon
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => EditProfileScreen(loginUser: ),
                      //   ),
                      // );
                    },
                    child: SizedBox(
                      height: 20,
                      width: 40,
                      child: Image.asset(
                        AssetResource.editpic,
                        height: 16,
                        width: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ✅ Custom Text Widget
            
            if (userRole =="Manager")
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: _buildListTile(
                  title: 'Users',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UsersScreen()),
                    );
                  },
                  image: '',
                  isSwitched: isSwitched,
                ),
              ),

            // ✅ Example ListTile
            _buildListTile(
              image: AssetResource.notificationpic,
              title: "Notification",
              isSwitched: isSwitched,
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Reusable ListTile
  Widget _buildListTile({
    required String image,
    required String title,
    VoidCallback? onTap,
    required bool isSwitched,
  }) {
    final bool hasSwitch = title == 'Notification';

    return ListTile(
      onTap: () {
        if (hasSwitch) {
          setState(() {
            this.isSwitched = !this.isSwitched;
          });

          // ✅ Show SnackBar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                this.isSwitched
                    ? 'Notifications turned ON'
                    : 'Notifications turned OFF',
              ),
              duration: const Duration(seconds: 1),
            ),
          );
        } else {
          onTap?.call();
        }
      },
      leading: image.isNotEmpty ? Image.asset(image) : null,
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.blackColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: hasSwitch
          ? Switch(
              value: this.isSwitched,
              onChanged: (value) {
                setState(() {
                  this.isSwitched = value;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      value
                          ? 'Notifications turned ON'
                          : 'Notifications turned OFF',
                    ),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              activeColor: AppColors.blackColor,
            )
          : const Icon(Icons.arrow_forward_ios, size: 16),
      tileColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: AppColors.opacityGrey,
          width: 1,
          style: BorderStyle.solid,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      ),
    );
  }
}
