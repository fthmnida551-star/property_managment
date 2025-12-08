import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/constant/app_colors.dart';
import 'package:property_managment/core/utils/appbar_widget.dart';
import 'package:property_managment/core/utils/green_button.dart';
import 'package:property_managment/core/utils/text_field.dart';
import 'package:property_managment/features/users/controller/user_controllers.dart';
import 'package:property_managment/core/enum/save_button.dart';
import 'package:property_managment/modelClass/user_model.dart';
import 'package:property_managment/features/users/screens/users_screen.dart';

class AddUserScreen extends ConsumerStatefulWidget {
  final UserModel? users;
  const AddUserScreen({super.key, this.users});

  @override
  ConsumerState<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends ConsumerState<AddUserScreen> {
  FirebaseFirestore fdb = FirebaseFirestore.instance;
  final formkey = GlobalKey<FormState>();
  final List<String> _roles = ['Manager', 'Agent', 'Staff', ];
  String? _selectedRole;
  SaveButtonMode _saveButtonMode = SaveButtonMode.save;

  final TextEditingController namectrlr = TextEditingController();
  final TextEditingController emailctrlr = TextEditingController();
  final TextEditingController passWordctrlr = TextEditingController();
  final TextEditingController mobilenocntrlr = TextEditingController();

  bool obscurePassword = true; // <-- ✅ You forgot to declare this variable

  _clearControllers() {
    namectrlr.clear();
    emailctrlr.clear();
    passWordctrlr.clear();
    mobilenocntrlr.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.users != null) {
      namectrlr.text = widget.users!.name;
      emailctrlr.text = widget.users!.email;
      passWordctrlr.text = widget.users!.password;
      mobilenocntrlr.text=widget.users!.Mobilenumber;
      _selectedRole = widget.users!.role;
      _saveButtonMode = SaveButtonMode.edit;
    }
  }

  @override
  Widget build(BuildContext context) {
    final repo = ref.read(userRepositoryProvider);
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
              _saveButtonMode == SaveButtonMode.save ? 'Add User' : 'Edit User',
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
                    readOnly: false,
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
                    readOnly: false,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 6, right: 5),
                  child: TextFieldContainer(
                    keyboardType:TextInputType.phone,
                    text: "Mobile number",
                    controllerName: mobilenocntrlr,
                    validator:(String?value){
                      if(value==null || value.isEmpty){
                         return "Please enter your Mobile number";
                      }
                      if(value.length!=10){
                       return "Mobile number must be 10 digits";
                      }
                    },
                    readOnly: false,
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
                "USER_MOBILENUMBER":mobilenocntrlr.text.trim(),
              };

              if (_saveButtonMode == SaveButtonMode.save) {
                await repo.addUsers(userDetails);
              } else {
                await repo.updateUser(widget.users!.id, userDetails);
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
}
