import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/core/theme/app_textstyl.dart';
import 'package:property_managment/widget/appbar_widget.dart';
import 'package:property_managment/widget/green_button.dart';

class UsersScreen extends StatefulWidget {
  UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
  final List<Map<String, String>> users = [
    {'name': 'Staff', 'e-mail': 'staff@gmail.com'},
    {'name': 'Manger', 'e-mail': 'manager@gmail.com'},
  ];
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        child: Padding(
          padding: const EdgeInsets.only(left: 10,top: 30),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.keyboard_arrow_left,
                  size: 30.sp,
                  color: AppColors.white,
                ),
              ),
              Text(
                'Users',
                style: AppTextstyle.propertyLargeTextstyle(context,fontColor: AppColors.white),
              ),
            ],
          ),
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 20),
            child: Text(
              'Users',
              style: AppTextstyle.propertyLargeTextstyle(context),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(
                    "${index + 1}.",
                    style: AppTextstyle.propertyMediumTextstyle(
                      context,
                      fontColor: AppColors.black,
                    ),
                  ),
                  title: Text(
                    "${widget.users[index]['name']}",
                    style: AppTextstyle.propertyMediumTextstyle(
                      context,
                      fontColor: AppColors.black,
                    ),
                  ),
                  subtitle: Text(
                    "${widget.users[index]['e-mail']}",
                    style: AppTextstyle.propertysmallTextstyle(
                      context,
                      fontColor: AppColors.black,
                    ),
                  ),
                );
              },
            ),
          ),
          Center(child: GreenButton(text: 'Add User', onTap: (){})),
          SizedBox(height: 30,)
          
        ],
        
      ),
     
    );
  }
}
