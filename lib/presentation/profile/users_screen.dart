import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/core/theme/app_textstyl.dart';
import 'package:property_managment/modelClass/user_model.dart';
import 'package:property_managment/presentation/profile/adding_users.dart';
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

//   void getAllUsersList() async {
//     UsersList.clear();
// try{
//     final QuerySnapshot<Map<String, dynamic>> querySnapshot = await fdb
//         .collection('STAFF')
//         .get();
//         print("hhhhhhhh");
//     querySnapshot.docs.map((element) {
//       print("elemnet ${element.id}");
//       final String id = element.id;
//       final Map<String, dynamic> data = element.data();
//       UsersList.add(UserModel.fromMap(data, id));

      
//     });
// }catch(e){
//   log("error happening while reading users : $e");
// }
//     log("read userslist ${UsersList.length}");
//   }
void getAllUsersList() async {
  UsersList.clear();
  try {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await fdb.collection('STAFF').get();
    print("hhhhhhhh");

    querySnapshot.docs.forEach((element) {
      print("element ${element.id}");
      final String id = element.id;
      final Map<String, dynamic> data = element.data();
      UsersList.add(UserModel.fromMap(data, id));
    });

    setState(() {
      
    });

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
          // Padding(
          //   padding: const EdgeInsets.only(left: 30, top: 20),
          //   child: Text(
          //     'Users',
          //     style: AppTextstyle.propertyLargeTextstyle(context),
          //   ),
          // ),
          Expanded(
            child: ListView.builder(
              itemCount: UsersList.length,
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
                    UsersList[index].name,
                    style: AppTextstyle.propertyMediumTextstyle(
                      context,
                      fontColor: AppColors.black,
                      
                    ),
                  ),
                  subtitle: Column(
                    children: [
                      Text(
                        UsersList[index].email,
                        style: AppTextstyle.propertysmallTextstyle(
                          context,
                          fontColor: AppColors.black,
                        ),
                      ),
                      Text(
                    UsersList[index].role,
                    style: AppTextstyle.propertysmallTextstyle(
                      context,
                      fontColor: AppColors.black,
                    ),
                  ),
                    ],
                  ),
                  
                  trailing: Row(
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                      IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
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


 
}
