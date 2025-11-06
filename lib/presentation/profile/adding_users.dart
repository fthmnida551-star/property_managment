import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/firebase/save_button.dart';
import 'package:property_managment/modelClass/user_model.dart';
import 'package:property_managment/presentation/profile/users_screen.dart';
import 'package:property_managment/widget/appbar_widget.dart';
import 'package:property_managment/widget/green_button.dart';
import 'package:property_managment/widget/text_field.dart';

class AddUserScreen extends StatefulWidget {
  final UserModel? users;
  const AddUserScreen({super.key, this.users});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  FirebaseFirestore fdb = FirebaseFirestore.instance;
  final formkey = GlobalKey<FormState>();
  final List<String> _roles = ['Manager', 'Agent', 'Staff'];
  String? _selectedRole;
  SaveButtonMode _saveButtonMode = SaveButtonMode.save;

  final TextEditingController namectrlr = TextEditingController();
  final TextEditingController emailctrlr = TextEditingController();
  final TextEditingController passWordctrlr = TextEditingController();

  bool obscurePassword = true; // <-- ✅ You forgot to declare this variable

  _clearControllers() {
    namectrlr.clear();
    emailctrlr.clear();
    passWordctrlr.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.users != null) {
      namectrlr.text = widget.users!.name;
      emailctrlr.text = widget.users!.email;
      passWordctrlr.text = widget.users!.password;
      _selectedRole = widget.users!.role;
      _saveButtonMode = SaveButtonMode.edit;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
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
              _saveButtonMode == SaveButtonMode.save
                  ? 'Add User'
                  : 'Edit User', // 🟩 CHANGED: dynamic title
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.white,
                fontSize: 21,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 6, right: 5),
                  child: TextFieldContainer(
                    text: 'Name',
                    controllerName: namectrlr,
                    validator: (String? p1) {
                      if (p1 == null || p1.isEmpty) {
                        return "Please enter your name";
                      }
                      if (!RegExp(r'^[A-Z]').hasMatch(p1)) {
                        return "First letter must be capital";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 6, right: 5),
                  child: TextFieldContainer(
                    text: 'E-mail',
                    controllerName: emailctrlr,
                    validator: (String? p1) {
                      if (p1 == null || p1.isEmpty) {
                        return "Please enter your email";
                      }
                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(p1)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    height: 60.h,
                    width: 360.w,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        width: 2,
                        color: AppColors.opacitygreyColor,
                      ),
                    ),
                    child: DropdownButtonFormField<String>(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please select your role";
                        }
                        return null;
                      },
                      value: _selectedRole,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Role',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: _roles
                          .map(
                            (role) => DropdownMenuItem(
                              value: role,
                              child: Text(role),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedRole = value;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.only(left: 0.1, right: 0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height: 60.h,
                      width: 360.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 1,
                          color: AppColors.opacitygreyColor,
                        ),
                      ),
                      child: TextFormField(
                        controller: passWordctrlr,
                        obscureText: obscurePassword,
                        validator: (String? p1) {
                          if (p1 == null || p1.isEmpty) {
                            return "Please enter password";
                          }
                          if (p1.length < 8) {
                            return "Password must be at least 8 characters long";
                          }
                          if (!RegExp(r'[!@#\$&*~_.,?-]').hasMatch(p1)) {
                            return "Password must contain at least one special character";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.opacitygreyColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),

                          hintText: 'Password',
                          hintStyle: TextStyle(
                            fontSize: 18.sp,
                            color: AppColors.opacitygrayColorText,
                          ),
                          suffixIcon: IconButton(
                            icon: obscurePassword
                                ? const Icon(Icons.visibility_off_outlined)
                                : const Icon(Icons.visibility_outlined),
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
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GreenButton(
          text: _saveButtonMode == SaveButtonMode.save ? 'Submit' : 'Update',
          onTap: () async {
            if (formkey.currentState!.validate()) {
              Map<String, dynamic> userDetails = {
                "USER_NAME": namectrlr.text.trim(),
                "USER_EMAIL": emailctrlr.text.trim(),
                "USER_ROLE": _selectedRole,
                "USER_PASSWORD": passWordctrlr.text.trim(),
              };
              if (_saveButtonMode == SaveButtonMode.save) {
                await addUsers(userDetails);
              } else {
                await updateUser(widget.users!.id, userDetails);
              }
              _clearControllers();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => UsersScreen()),
              );
            }
          },
        ),
      ),
    );
  }

  addUsers(Map<String, dynamic> userDetails) {
    fdb.collection("STAFF").add(userDetails).then((
      DocumentReference<Map<String, dynamic>> docRef,
    ) {
      final String id = docRef.id;
      log("adding users");
    });
  }

  updateUser(String id, Map<String, dynamic> updatedData) async {
    try {
      await fdb.collection("STAFF").doc(id).update(updatedData);
      log("User updated successfully");
    } catch (e) {
      log("Error updating user: $e");
    }
  }
}
