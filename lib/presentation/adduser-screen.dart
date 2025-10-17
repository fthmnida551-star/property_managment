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
  final List<String> _roles = [
    'Add Property',
    'View Property',
    'view Booking Details',
  ];
  String? _selectedRole;
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Icon(Icons.keyboard_arrow_left, size: 30.sp),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFieldContainer(text: 'Name', controllerName: nameCtrl,),
              const SizedBox(height: 20),
              TextFieldContainer(text: 'E-mail', controllerName: emailCtrl),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
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

              TextFieldContainer(text: 'Password', controllerName: passwordCtrl,),
              const SizedBox(height: 200),

              GreenButton(
                text: 'Submit',
                onTap: () {
                  print('Selected Role: $_selectedRole');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
