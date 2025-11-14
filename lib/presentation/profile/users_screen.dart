import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/core/theme/app_textstyl.dart';
import 'package:property_managment/firebase/save_button.dart';
import 'package:property_managment/modelClass/user_model.dart';
import 'package:property_managment/presentation/profile/adding_users.dart';
import 'package:property_managment/presentation/profile/widget/delete_alert.dart';
import 'package:property_managment/widget/appbar_widget.dart';
import 'package:property_managment/widget/green_button.dart';

class UsersScreen extends StatefulWidget {
  UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final List<Map<String, String>> users = [
    {'name': 'Staff', 'e-mail': 'staff@gmail.com'},
    {'name': 'Manger', 'e-mail': 'manager@gmail.com'},
  ];
  List<UserModel> UsersList = [];
  FirebaseFirestore fdb = FirebaseFirestore.instance;

  void getAllUsersList() async {
    UsersList.clear();
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await fdb
          .collection('STAFF')
          .get();
      print("hhhhhhhh");

      querySnapshot.docs.forEach((element) {
        print("element ${element.id}");
        final String id = element.id;
        final Map<String, dynamic> data = element.data();
        UsersList.add(UserModel.fromMap(data, id));
      });

      setState(() {});
    } catch (e) {
      log("error happening while reading users : $e");
    }
    log("read userslist ${UsersList.length}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log("gggggggggggggggggggggggggg");
    getAllUsersList();
  }

  @override
  Widget build(BuildContext context) {
    print("uuuuuuuuuuuuuuuuuuu");
    return Scaffold(
      appBar: AppbarWidget(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 30),
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
                style: AppTextstyle.propertyLargeTextstyle(
                  context,
                  fontColor: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
         
          Expanded(
            child: ListView.builder(
              itemCount: UsersList.length,
              itemBuilder: (context, index) {
                var item = UsersList[index];

                return ListTile(
                  leading: Text(
                    "${index + 1}.",
                    style: AppTextstyle.propertyMediumTextstyle(
                      context,
                      fontColor: AppColors.black,
                    ),
                  ),
                  title: Text(
                    item.name,
                    style: AppTextstyle.propertyMediumTextstyle(
                      context,
                      fontColor: AppColors.black,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // ✅ add this too for alignment
                    children: [
                      Text(
                        item.email,
                        style: AppTextstyle.propertysmallTextstyle(
                          context,
                          fontColor: AppColors.black,
                        ),
                      ),
                      Text(
                        item.role,
                        style: AppTextstyle.propertysmallTextstyle(
                          context,
                          fontColor: AppColors.black,
                        ),
                      ),
                    ],
                  ),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddUserScreen(users: item),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),

                      IconButton(
                        onPressed: () {
                          deleteAlert(
                            context,
                            onConfirm: () {
                              deleteUser(item.id);
                            },
                          );
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          Center(
            child: GreenButton(
              text: 'Add User',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddUserScreen()),
                );
              },
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  void deleteUser(String id) async {
    await fdb.collection("STAFF").doc(id).delete();
    getAllUsersList();
  }
}
