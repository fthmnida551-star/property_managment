import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/constant/app_colors.dart';
import 'package:property_managment/core/constant/app_textstyl.dart';
import 'package:property_managment/core/utils/appbar_widget.dart';
import 'package:property_managment/core/utils/green_button.dart';
import 'package:property_managment/features/users/controllers.dart';
import 'package:property_managment/features/users/screens/adding_users.dart';
import 'package:property_managment/features/users/screens/widget/delete_alert.dart';
class UsersScreen extends ConsumerWidget {
  UsersScreen({super.key});

  final List<Map<String, String>> users = [
    {'name': 'Staff', 'e-mail': 'staff@gmail.com'},
    {'name': 'Manger', 'e-mail': 'manager@gmail.com'},
  ];

  FirebaseFirestore fdb = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userListProvider);
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
            child: userAsync.when(
              data: (users) {
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    var item = users[index];

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
                                  builder: (context) =>
                                      AddUserScreen(users: item),
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
                );
              },
              loading: () => Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text("error:$e")),
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
  
  }
}
