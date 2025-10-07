import 'package:flutter/material.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/widget/appbar_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen ({super.key});

  @override
  State<EditProfileScreen> createState() => _EditprofileScreenState();
}

class _EditprofileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: GestureDetector(
              onTap: () {
                print('Back Arrow');
              },
              child: Icon(Icons.keyboard_arrow_left),
            ),
            ),
            SizedBox(width: 10,),
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
    
    );
  }
}