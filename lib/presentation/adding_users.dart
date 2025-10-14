import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/widget/appbar_widget.dart';
import 'package:property_managment/widget/green_button.dart';
import 'package:property_managment/widget/text_field.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final List<String> _roles = ['Manager', 'Agent', 'Staff'];
  String? _selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Icon(Icons.keyboard_arrow_left, size: 30.sp),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          TextFieldContainer(text: 'Name'),
          const SizedBox(height: 20),
          TextFieldContainer(text: 'E-mail'),
          const SizedBox(height: 20),
          Container(
            height: 50.h,
            width: 350.w,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            margin: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: DropdownButtonFormField<String>(
              value: _selectedRole,
              decoration: const InputDecoration(
                border: InputBorder.none,
                labelText: 'Role',
              ),
              icon: const Icon(Icons.keyboard_arrow_down),
              items: _roles.map((role) {
                return DropdownMenuItem(value: role, child: Text(role));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedRole = value;
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          TextFieldContainer(text: 'Password'),
          Spacer(),
          Center(
            child: GreenButton(
              text: 'Submit',
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
