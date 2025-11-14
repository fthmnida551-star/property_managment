import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/core/theme/asset_resource.dart';
import 'package:property_managment/modelClass/user_model.dart';
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
  
  
  
  getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    userRole = prefs.getString('role') ?? "";
    log("vvvvvvvvv $userRole");
    setState(() {});
  }


  // Variables to hold fetched user data
  String userId="";
  String userName ="";
  String userEmail="";
  //  String userRole="";
  String userPassword="";
 
  UserModel? loginUser;

  @override
  void initState() {
    super.initState();
    log("reached here");
    getUserData();
    getNotificationStatus();
     getUserRole(); 
  }

  // ✅ Get user data from SharedPreferences
  Future<void> getUserData() async {

    final prefs = await SharedPreferences.getInstance();
    
      userId =  prefs.getString('userId')??"";
      userName =  prefs.getString('name')??"";
      userEmail = prefs.getString('email')??"";
      userRole = prefs.getString('role')??"";
      userPassword = prefs.getString('password')??"";
      

      loginUser = UserModel(
          userId,
          userName,
          userEmail,
          userRole,
          userPassword,
          
         );
    
       setState(() {
        
      });

      }

  // ✅ Get notification switch status
  Future<void> getNotificationStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isSwitched = prefs.getBool('notificationStatus') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    log("username = $userName    ghghgh ${loginUser?.name}");
    if(loginUser == null){
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppbarWidget(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                'Profile',
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  logoutAlert(context);
                },
                child: const Icon(Icons.logout, color: AppColors.white),
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
                          userName,

                          style: TextStyle(
                            fontSize: 23.sp,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          userEmail,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditProfileScreen(loginUser: loginUser!),
                        ),
                      );
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
          if(userRole =="Manager")

            // ✅ Users List Tile
            Padding(
             
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: _buildListTile(
                title: 'Users',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  UsersScreen()),
                  );
                },
                image: '',
                isSwitched: isSwitched,
              ),
            ),

            // ✅ Notification List Tile
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
        if (!hasSwitch) {
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
              onChanged: (value) async {
                setState(() {
                  this.isSwitched = value;
                });
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool("notificationStatus", value);
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