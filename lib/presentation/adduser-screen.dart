import 'package:flutter/material.dart';
import 'package:propertymanagementapp/core/theme/app_colors.dart';
import 'package:propertymanagementapp/widget/appbar_widget.dart';
import 'package:propertymanagementapp/widget/textfield-widget.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
      child: Icon(Icons.keyboard_arrow_left_outlined,color: AppColors.whitecolor,),
  
      ),
      

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFieldContainer(text: 'ame'),
            SizedBox(height: 10,),
            TextFieldContainer(text: 'name'),
            SizedBox(height: 10,),
            TextFieldContainer(text: 'name'),
            SizedBox(height: 10,),
            TextFieldContainer(text: 'name'),

          ],
        ),
      ),
    );
  }
}