// // import 'dart:developer';

// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:property_managment/core/constant/app_colors.dart';
// // import 'package:property_managment/core/constant/asset_resource.dart';
// // import 'package:property_managment/core/utils/appbar_widget.dart';
// // import 'package:property_managment/features/profile/controllers/profileControllers.dart';
// // import 'package:property_managment/modelClass/user_model.dart';
// // import 'package:property_managment/features/profile/screens/edit_profile.dart';
// // import 'package:property_managment/features/users/screens/users_screen.dart';
// // import 'package:property_managment/features/property/screens/propertydetails/widget/logout_alert.dart';
// // import 'package:shared_preferences/shared_preferences.dart';

// // class Profilescreen extends ConsumerWidget {
// //    Profilescreen({super.key});

// //   bool isSwitched = false;

// //   // String userRole = '';

// //   // getUserRole() async {
// //   String userId="";

// //   String userName ="";

// //   String userEmail="";

// //   //  String userRole="";
// //   String userPassword="";

// //   // UserModel? loginUser;

// //   // @override
// //   // Future<void> getUserData() async {

// //   //   final prefs = await SharedPreferences.getInstance();
    
// //   //     userId =  prefs.getString('userId')??"";
// //   //     userName =  prefs.getString('name')??"";
// //   //     userEmail = prefs.getString('email')??"";
// //   //     userRole = prefs.getString('role')??"";
// //   //     userPassword = prefs.getString('password')??"";
      

// //   //     loginUser = UserModel(
// //   //         userId,
// //   //         userName,
// //   //         userEmail,
// //   //         userRole,
// //   //         userPassword,
          
// //   //        );
    

// //   //     }

// //   // ✅ Get notification switch status
// //   @override
// //   Widget build(BuildContext context,WidgetRef ref) {
// //     final userdata =ref.watch(profileListProvider);
    

// //     // log("username = $userName    ghghgh ${loginUser?.name}");
// //     // if(loginUser == null){
// //     //   return const Scaffold(
// //     //     body: Center(child: CircularProgressIndicator()),
// //     //   );
// //     // }
// //     return Scaffold(
// //       appBar: AppbarWidget(
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             const Padding(
// //               padding: EdgeInsets.only(left: 15),
// //               child: Text(
// //                 'Profile',
// //                 style: TextStyle(
// //                   color: AppColors.whiteColor,
// //                   fontSize: 21,
// //                   fontWeight: FontWeight.w600,
// //                 ),
// //               ),
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.all(8.0),
// //               child: GestureDetector(
// //                 onTap: () {
// //                   logoutAlert(context);
// //                 },
// //                 child: const Icon(Icons.logout, color: AppColors.white),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),

// //       // ✅ Body
// //       body: Padding(
// //         padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
// //         child: Column(
// //           children: [
// //             // ✅ Profile Card
// //             Container(
// //               padding: const EdgeInsets.all(15),
// //               decoration: BoxDecoration(
// //                 color: AppColors.white,
// //                 borderRadius: BorderRadius.circular(12),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: AppColors.opacityGrey.withOpacity(0.2),
// //                     blurRadius: 5,
// //                     offset: const Offset(0, 2),
// //                   ),
// //                 ],
// //               ),
// //               child: Row(
// //                 children: [
// //                   ClipRRect(
// //                     borderRadius: BorderRadius.circular(8),
// //                     child: Image.asset(
// //                       AssetResource.profilepic,
// //                       height: 60,
// //                       width: 60,
// //                       fit: BoxFit.cover,
// //                     ),
// //                   ),
// //                   const SizedBox(width: 15),

// //                   // ✅ Name & Email
// //                   Expanded(
// //                     child: userdata.when(
// //       data: (user) {
// //         if (user ==  null){
// //           return Center(child: Text("No user found"));
// //         }
// //         return Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Text(
// //                           user.name,

// //                           style: TextStyle(
// //                             fontSize: 23.sp,
// //                             color: AppColors.blackColor,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                           overflow: TextOverflow.ellipsis,
// //                         ),
// //                         Text(
// //                           user.email,
// //                           style: TextStyle(
// //                             color: AppColors.black,
// //                             fontSize: 17.sp,
// //                           ),
// //                           overflow: TextOverflow.ellipsis,
// //                         ),
// //                       ],
// //                     );
// //       },
// //       loading: () => Center(child: CircularProgressIndicator()), 
// //       error: (e, st) => Text("Error: $e"),
// //       ),
                    
                    
                    
                    
                    
// //                   ),

// //                   // ✅ Edit Icon
// //                   GestureDetector(
// //                     onTap: () {
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                           builder: (context) =>
// //                               EditProfileScreen(loginUser: userdata.value!),
// //                         ),
// //                       );
// //                       // Navigator.push(
// //                       //   context,
// //                       //   MaterialPageRoute(
// //                       //     builder: (context) => EditProfileScreen(loginUser: ),
// //                       //   ),
// //                       // );
// //                     },
// //                     child: SizedBox(
// //                       height: 20,
// //                       width: 40,
// //                       child: Image.asset(
// //                         AssetResource.editpic,
// //                         height: 16,
// //                         width: 16,
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
            
// //            userdata.when(
// //             data: (user){
// //               if (user == null) return SizedBox();
// //               return Column(
// //                 children: [
// //                   const SizedBox(height: 20),
// //                    if(user.role =="Manager")
// //                    Padding(
             
// //               padding: const EdgeInsets.symmetric(vertical: 10.0),
// //               child: _buildListTile(
// //                 title: 'Users',
// //                 onTap: () {
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(builder: (context) =>  UsersScreen()),
// //                   );
// //                 },
// //                 image: '',
// //                 isSwitched: isSwitched,
// //               ),
// //             ),
            
// //                 ],
// //               );
// //             } ,
// //             loading: () => CircularProgressIndicator(),
// //             error: (e, st) => Text("Error"),
// //            ),
           
// //             // const SizedBox(height: 20),
// //           // if(user.role =="Manager")

// //             // ✅ Users List Tile
// //             // Padding(
             
// //             //   padding: const EdgeInsets.symmetric(vertical: 10.0),
// //             //   child: _buildListTile(
// //             //     title: 'Users',
// //             //     onTap: () {
// //             //       Navigator.push(
// //             //         context,
// //             //         MaterialPageRoute(builder: (context) =>  UsersScreen()),
// //             //       );
// //             //     },
// //             //     image: '',
// //             //     isSwitched: isSwitched,
// //             //   ),
// //             // ),

// //             // ✅ Notification List Tile
// //             _buildListTile(
// //               image: AssetResource.notificationpic,
// //               title: "Notification",
// //               isSwitched: isSwitched,
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   // ✅ Reusable ListTile
// //   Widget _buildListTile({
// //     required String image,
// //     required String title,
// //     VoidCallback? onTap,
// //     required bool isSwitched,
// //   }) {
// //     final bool hasSwitch = title == 'Notification';

// //     return ListTile(
// //       onTap: () {
// //         if (!hasSwitch) {
// //           onTap?.call();
// //         }
// //       },
// //       leading: image.isNotEmpty ? Image.asset(image) : null,
// //       title: Text(
// //         title,
// //         style: const TextStyle(
// //           color: AppColors.blackColor,
// //           fontWeight: FontWeight.w500,
// //         ),
// //       ),
// //       trailing: hasSwitch
// //           ? Switch(
// //               value: this.isSwitched,
// //               onChanged: (value) async {
// //                 // setState(() {
// //                 //   this.isSwitched = value;
// //                 // });
// //                 final prefs = await SharedPreferences.getInstance();
// //                 await prefs.setBool("notificationStatus", value);
// //               },
// //               activeColor: AppColors.blackColor,
// //             )
// //           : const Icon(Icons.arrow_forward_ios, size: 16),
// //       tileColor: AppColors.white,
// //       shape: RoundedRectangleBorder(
// //         borderRadius: BorderRadius.circular(10),
// //         side: BorderSide(
// //           color: AppColors.opacityGrey,
// //           width: 1,
// //           style: BorderStyle.solid,
// //           strokeAlign: BorderSide.strokeAlignOutside,
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:property_managment/core/constant/app_colors.dart';
// import 'package:property_managment/core/constant/asset_resource.dart';
// import 'package:property_managment/core/utils/appbar_widget.dart';
// import 'package:property_managment/features/profile/controllers/profileControllers.dart';
// import 'package:property_managment/modelClass/user_model.dart';
// import 'package:property_managment/features/profile/screens/edit_profile.dart';
// import 'package:property_managment/features/users/screens/users_screen.dart';
// import 'package:property_managment/features/property/screens/propertydetails/widget/logout_alert.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Profilescreen extends ConsumerStatefulWidget {
//   Profilescreen({super.key});

//   @override
//   ConsumerState<Profilescreen> createState() => _ProfilescreenState();
// }

// class _ProfilescreenState extends ConsumerState<Profilescreen> {
//   bool isSwitched = false;

//   @override
//   void initState() {
//     super.initState();
//     loadNotification();
//   }

//   loadNotification() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       isSwitched = prefs.getBool("notificationStatus") ?? false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userdata = ref.watch(profileListProvider);

//     return Scaffold(
//       appBar: AppbarWidget(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Padding(
//               padding: EdgeInsets.only(left: 15),
//               child: Text(
//                 'Profile',
//                 style: TextStyle(
//                   color: AppColors.whiteColor,
//                   fontSize: 21,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () => logoutAlert(context),
//               child: const Icon(Icons.logout, color: AppColors.white),
//             ),
//           ],
//         ),
//       ),

//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
//         child: userdata.when(
//           loading: () => const Center(child: CircularProgressIndicator()),
//           error: (e, st) => Center(child: Text("Error: $e")),
//           data: (user) {
//             if (user == null) {
//               return const Center(child: Text("No user found"));
//             }

//             return Column(
//               children: [
//                 // ---------------- PROFILE CARD ----------------
//                 Container(
//                   padding: const EdgeInsets.all(15),
//                   decoration: BoxDecoration(
//                     color: AppColors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: AppColors.opacityGrey.withOpacity(0.2),
//                         blurRadius: 5,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.asset(
//                           AssetResource.profilepic,
//                           height: 60,
//                           width: 60,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       const SizedBox(width: 15),

//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               user.name,
//                               style: TextStyle(
//                                 fontSize: 23.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: AppColors.blackColor,
//                               ),
//                             ),
//                             Text(
//                               user.email,
//                               style: TextStyle(
//                                 fontSize: 17.sp,
//                                 color: AppColors.black,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => EditProfileScreen(loginUser: user),
//                             ),
//                           );
//                         },
//                         child: Image.asset(
//                           AssetResource.editpic,
//                           height: 20,
//                           width: 20,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 // ---------------- SHOW USERS ONLY FOR MANAGER ----------------
//                 if (user.role == "Manager")
//                   _buildListTile(
//                     title: "Users",
//                     image: "",
//                     isSwitched: false,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => UsersScreen()),
//                       );
//                     },
//                   ),

//                 // ---------------- NOTIFICATION ----------------
//                 _buildListTile(
//                   title: "Notification",
//                   image: AssetResource.notificationpic,
//                   isSwitched: isSwitched,
//                   onSwitchChange: (value) async {
//                     final prefs = await SharedPreferences.getInstance();
//                     prefs.setBool("notificationStatus", value);
//                     setState(() {
//                       isSwitched = value;
//                     });
//                   },
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildListTile({
//     required String title,
//     required String image,
//     required bool isSwitched,
//     VoidCallback? onTap,
//     Function(bool)? onSwitchChange,
//   }) {
//     final isNotification = title == "Notification";

//     return ListTile(
//       onTap: !isNotification ? onTap : null,
//       leading: image.isNotEmpty ? Image.asset(image) : null,
//       title: Text(
//         title,
//         style: const TextStyle(
//           color: AppColors.blackColor,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//       trailing: isNotification
//           ? Switch(
//               value: isSwitched,
//               onChanged: onSwitchChange,
//             )
//           : const Icon(Icons.arrow_forward_ios, size: 16),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//         side: BorderSide(
//           color: AppColors.opacityGrey,
//         ),
//       ),
//     );
//   }
// }




// class Profilescreen extends ConsumerWidget {
//   Profilescreen({super.key});

//   bool isSwitched = false;

//   String userId = "";
//   String userName = "";
//   String userEmail = "";
//   String userPassword = "";

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final userdata = ref.watch(profileListProvider);

//     return Scaffold(
//       appBar: AppbarWidget(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Padding(
//               padding: EdgeInsets.only(left: 15),
//               child: Text(
//                 'Profile',
//                 style: TextStyle(
//                   color: AppColors.whiteColor,
//                   fontSize: 21,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: GestureDetector(
//                 onTap: () {
//                   logoutAlert(context);
//                 },
//                 child: const Icon(Icons.logout, color: AppColors.white),
//               ),
//             ),
//           ],
//         ),
//       ),

//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
//         child: Column(
//           children: [
//             // ================================
//             // PROFILE CARD
//             // ================================
//             Container(
//               padding: const EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                 color: AppColors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppColors.opacityGrey.withOpacity(0.2),
//                     blurRadius: 5,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: Image.asset(
//                       AssetResource.profilepic,
//                       height: 60,
//                       width: 60,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   const SizedBox(width: 15),

//                   Expanded(
//                     child: userdata.when(
//                       data: (user) {
//                         if (user == null) {
//                           return const Text("No user found");
//                         }
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               user.name,
//                               style: TextStyle(
//                                 fontSize: 23.sp,
//                                 color: AppColors.blackColor,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             Text(
//                               user.email,
//                               style: TextStyle(
//                                 color: AppColors.black,
//                                 fontSize: 17.sp,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ],
//                         );
//                       },
//                       loading: () => const CircularProgressIndicator(),
//                       error: (e, st) => Text("Error: $e"),
//                     ),
//                   ),

//                   // EDIT ICON
//                   GestureDetector(
//                     onTap: () {
//                       if (userdata.value != null) {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 EditProfileScreen(loginUser: userdata.value!),
//                           ),
//                         );
//                       }
//                     },
//                     child: SizedBox(
//                       height: 20,
//                       width: 40,
//                       child: Image.asset(
//                         AssetResource.editpic,
//                         height: 16,
//                         width: 16,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 20),

            
//             userdata.when(
//               data: (user) {
//                 if (user == null) return const SizedBox();

//                 return Column(
//                   children: [
//                     if (user.role == "Manager")
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 12.0),
//                         child: _buildListTile(
//                           title: 'Users',
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => UsersScreen()),
//                             );
//                           },
//                           image: '',
//                           isSwitched: isSwitched,
//                         ),
//                       ),

//                     // 👇 GAP ADDED HERE
//                     const SizedBox(height: 10),
//                   ],
//                 );
//               },
//               loading: () => const CircularProgressIndicator(),
//               error: (e, st) => Text("Error"),
//             ),

            
//             _buildListTile(
//               image: AssetResource.notificationpic,
//               title: "Notification",
//               isSwitched: isSwitched,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

  
//   Widget _buildListTile({
//     required String image,
//     required String title,
//     VoidCallback? onTap,
//     required bool isSwitched,
//   }) {
//     final bool hasSwitch = title == 'Notification';

//     return ListTile(
//       onTap: () {
//         if (!hasSwitch) onTap?.call();
//       },
//       leading: image.isNotEmpty ? Image.asset(image) : null,
//       title: Text(
//         title,
//         style: const TextStyle(
//           color: AppColors.blackColor,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//       trailing: hasSwitch
//           ? Switch(
//               value: this.isSwitched,
//               onChanged: (value) async {
//                 final prefs = await SharedPreferences.getInstance();
//                 await prefs.setBool("notificationStatus", value);
//               },
//               activeColor: AppColors.blackColor,
//             )
//           : const Icon(Icons.arrow_forward_ios, size: 16),
//       tileColor: AppColors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//         side: BorderSide(
//           color: AppColors.opacityGrey,
//           width: 1,
//         ),
//       ),
//     );
//   }
// }

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/constant/app_colors.dart';
import 'package:property_managment/core/constant/asset_resource.dart';
import 'package:property_managment/core/utils/appbar_widget.dart';
import 'package:property_managment/features/profile/controllers/profileControllers.dart';
import 'package:property_managment/modelClass/user_model.dart';
import 'package:property_managment/features/profile/screens/edit_profile.dart';
import 'package:property_managment/features/users/screens/users_screen.dart';
import 'package:property_managment/features/property/screens/propertydetails/widget/logout_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profilescreen extends ConsumerStatefulWidget {
  const Profilescreen({super.key});

  @override
  ConsumerState<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends ConsumerState<Profilescreen> {
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    _loadNotificationStatus();
  }

  Future<void> _loadNotificationStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isSwitched = prefs.getBool("notificationStatus") ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userdata = ref.watch(profileListProvider);

    return Scaffold(
      appBar: AppbarWidget(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding:  EdgeInsets.only(left: 15),
              child:  Text('Profile', style: TextStyle(color: AppColors.whiteColor, fontSize: 21,fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: GestureDetector(
                onTap: () => logoutAlert(context),
                child: const Icon(Icons.logout, color: AppColors.white,fontWeight: FontWeight.bold,),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
        child: Column(
          children: [
            // ---------- Profile Card ----------
            userdata.when(
              data: (user) {
                if (user == null) return const Text("No user found");

                return Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(color: AppColors.opacityGrey.withOpacity(0.2), blurRadius: 5, offset: const Offset(0,2))],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(AssetResource.profilepic, height: 60, width: 60, fit: BoxFit.cover),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.name, style: TextStyle(fontSize: 23.sp, fontWeight: FontWeight.bold, color: AppColors.blackColor)),
                            Text(user.email, style: TextStyle(fontSize: 17.sp, color: AppColors.black)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => EditProfileScreen(loginUser: user)),
                          );
                        },
                        child: Image.asset(AssetResource.editpic, height: 20, width: 20),
                      ),
                    ],
                  ),
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (e, st) => Text("Error: $e"),
            ),

            const SizedBox(height: 20),

            // ---------- Users tile for Manager ----------
            userdata.when(
              data: (user) {
                if (user == null) return const SizedBox();
                if (user.role != "Manager") return const SizedBox();

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: _buildListTile(
                    title: "Users",
                    image: "",
                    isSwitched: false,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => UsersScreen()));
                    },
                  ),
                );
              },
              loading: () => const SizedBox(),
              error: (e, st) => const SizedBox(),
            ),

            const SizedBox(height: 10),

            // ---------- Notification Tile ----------
            _buildListTile(
              title: "Notification",
              image: AssetResource.notificationpic,
              isSwitched: isSwitched,
              onSwitchChange: (value) async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool("notificationStatus", value);
                setState(() {
                  isSwitched = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    required String image,
    required bool isSwitched,
    VoidCallback? onTap,
    Function(bool)? onSwitchChange,
  }) {
    final isNotification = title == "Notification";

    return ListTile(
      onTap: !isNotification ? onTap : null,
      leading: image.isNotEmpty ? Image.asset(image) : null,
      title: Text(title, style: const TextStyle(color: AppColors.blackColor, fontWeight: FontWeight.w500)),
      trailing: isNotification
          ? Switch(value: isSwitched, onChanged: onSwitchChange, activeColor: AppColors.blackColor)
          : const Icon(Icons.arrow_forward_ios, size: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: AppColors.opacityGrey),
      ),
    );
  }
}
