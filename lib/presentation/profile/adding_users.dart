import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/widget/appbar_widget.dart';
import 'package:property_managment/widget/green_button.dart';
import 'package:property_managment/widget/text_field.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final formkey=GlobalKey<FormState>();
  final List<String> _roles = ['Manager', 'Agent', 'Staff'];
  String? _selectedRole;
  TextEditingController namectrlr = TextEditingController();
  TextEditingController emailctrlr = TextEditingController();
  TextEditingController passWordctrlr = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        child: Padding(
          padding: const EdgeInsets.all(6.0),

          child: Row(
            children: [
              GestureDetector(
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
                'Add User',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                  fontSize: 21,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key:formkey ,
          child: Column(
            children: [
              SizedBox(height: 20),
              TextFieldContainer(
                text: 'Name',
                controllerName: namectrlr,
                validator: (String? p1) {
                  if (p1 == null || p1.isEmpty) {
                    return "Please enter your name";
                  }
          
                  if (!RegExp(r'[A-Z]').hasMatch(p1)) {
                    return "First letter must be capital";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFieldContainer(
                text: 'E-mail',
                controllerName: emailctrlr,
                validator: (String? p1) {
                  if (p1 == null || p1.isEmpty) {
                    return "Please enter your email";
                  }
                  if(!p1.contains('@')){
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Container(
                height: 50.h,
                width: 350.w,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  // color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: DropdownButtonFormField<String>(
                  validator: (value) {
                    if(value==null || value.isEmpty){
                      return "Please select your role";
                    }
                    return null;
                  },
                  value: _selectedRole,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Role',
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
              TextFieldContainer(
                text: 'Password',
                controllerName: passWordctrlr,
                validator: (String? p1) {
                  if (p1 == null || p1.isEmpty) {
                    return "Please enter password";
                  }
                  if (p1.length != 8){
                    return "Password must be at least 8 characters long";
                  }
                  if (!RegExp(r'[!@#\$&*~_.,?-]').hasMatch(p1)) {
                 return "Password must contain at least one special character";
                }

                
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GreenButton(
        text: 'Submit',
          onTap: () {
            if(formkey.currentState!.validate()){
               Navigator.pop(context);
            }
           
          },
        ),
      ),
    );
  }
}
