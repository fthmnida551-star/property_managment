// // // import 'dart:developer';
// // // import 'dart:io';

// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // // import 'package:image_picker/image_picker.dart';
// // // import 'package:property_managment/core/constant/app_colors.dart';
// // // import 'package:property_managment/core/utils/appbar_widget.dart';
// // // import 'package:property_managment/core/utils/bottom_navigation_bar.dart';
// // // import 'package:property_managment/core/utils/green_button.dart';
// // // import 'package:property_managment/core/utils/text_field.dart';
// // // import 'package:property_managment/features/profile/controllers/profileControllers.dart';
// // // import 'package:property_managment/modelClass/user_model.dart';

// // // class EditProfileScreen extends ConsumerStatefulWidget {
// // //   final UserModel loginUser;
// // //   const EditProfileScreen({super.key, required this.loginUser, required user});

// // //   @override
// // //   ConsumerState<EditProfileScreen> createState() => _EditprofileScreenState();
// // // }

// // // class _EditprofileScreenState extends ConsumerState<EditProfileScreen> {
// // //   final _formkey = GlobalKey< FormState >();
// // //   bool obscurePassword = false;
// // //   TextEditingController nameCtlr = TextEditingController();
// // //   TextEditingController emailCtrl = TextEditingController();
// // //   TextEditingController roleCtrl = TextEditingController();
// // //   TextEditingController passwordCtrl = TextEditingController();
// // //   File? _selectedImage;
// // //   final ImagePicker _picker = ImagePicker(); 
// // //   Future<void> _pickImage() async {
// // //     final pickedFile = await _picker.pickImage(
// // //       source: ImageSource.gallery,
// // //       // imageQuality: 80,
// // //     );

// // //     // if (pickedFile != null) {
// // //     //   setState(() {
// // //     //     _selectedImage = File(pickedFile.path);
// // //     //   });
// // //     // }
// // //   }

// // //   @override
// // //   void initState() {
// // //     // TODO: implement initState
// // //     super.initState();
// // //     emailCtrl.text = widget.loginUser.email;
// // //     passwordCtrl.text = widget.loginUser.password;

// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final repo=ref.read(profileRepositoryProvider);
// // //     return Scaffold(
// // //       appBar: AppbarWidget(
// // //         child: Row(
// // //           mainAxisAlignment: MainAxisAlignment.start,
// // //           children: [
// // //             Padding(
// // //               padding: const EdgeInsets.only(left: 10.0),
// // //               child: GestureDetector(
// // //                 onTap: () {
// // //                   Navigator.pop(context);
// // //                 },
// // //                 child: Icon(
// // //                   Icons.keyboard_arrow_left,
// // //                   size: 30,
// // //                   color: AppColors.white,
// // //                 ),
// // //               ),
// // //             ),
// // //             SizedBox(width: 10),
// // //             const Text(
// // //               'Edit Profile',
// // //               style: TextStyle(
// // //                 color: AppColors.white,
// // //                 fontSize: 21,
// // //                 fontWeight: FontWeight.w600,
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //       body: Padding(
// // //         padding: const EdgeInsets.only(right: 10.0, top: 15.0),
// // //         child: SingleChildScrollView(
// // //           child: Form(
// // //             key: _formkey,
// // //             child: Column(
// // //               children: [
// // //                 Stack(
// // //                   children: [
// // //                     Container(
// // //                       height: 100,
// // //                       width: 100,
// // //                       decoration: BoxDecoration(
// // //                         shape: BoxShape.circle,
// // //                         // borderRadius: BorderRadius.circular(50),
// // //                         border: Border.all(color: AppColors.OpacitygreyColor),
// // //                          image: _selectedImage != null
// // //                             ? DecorationImage(
// // //                                 image: FileImage(_selectedImage!),
// // //                                 fit: BoxFit.cover,
// // //                               )
// // //                             : null,
// // //                       ),
// // //                       child: _selectedImage != null
// // //                           ? null
// // //                           : Icon(Icons.person, color: AppColors.OpacitygreyColor),
// // //                       // Image.asset(AssetResource.profilepic),
// // //                     ),
// // //                     Positioned(
// // //                       bottom: 0,
// // //                       right: 5,
// // //                       child: InkWell(
// // //                         onTap: () => _pickImage(),
// // //                         child: Container(
// // //                           height: 30,
// // //                           width: 30,
// // //                           decoration: BoxDecoration(
// // //                             color: AppColors.greenColor,
// // //                             shape: BoxShape.circle,
// // //                           ),
                        
// // //                           child: const Icon(
// // //                             Icons.add,
// // //                             color: AppColors.white,
// // //                             size: 20.0,
// // //                           ),
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //                 SizedBox(height: 80),
// // //                  Padding(
// // //                   padding: const EdgeInsets.only(left: 20.0, right: 15),
// // //                   child: TextFieldContainer(
// // //                     text: 'Name',
// // //                     controllerName: nameCtlr, validator: (String? value) {
// // //                      if (value == null || value.isEmpty) {
// // //                         return 'Please enter your name';
// // //                       }
// // //                       if (!RegExp(r'^[A-Z]').hasMatch(value)) {
// // //                         return 'First letter must be a capital letter';
// // //                       }
// // //                       return null;}, readOnly: false,
// // //                   ),
// // //                 ),
// // //                 SizedBox(height: 18),
// // //                 Padding(
// // //                   padding: const EdgeInsets.only(left: 20.0, right: 15),
// // //                   child: TextFieldContainer(
// // //                     text: 'Email',
// // //                     controllerName: emailCtrl, validator: (String? value) {
// // //                      if(value==null || value.isEmpty){
// // //                       return 'Please enter your email';
// // //                      }
// // //                      if(!value.contains('@')){
// // //                       return 'Please enter a valid email address';
// // //                      }
// // //                      return null;
// // //                       }, readOnly: false,
// // //                   ),
// // //                 ),
// // //                 // SizedBox(height: 18),
// // //                 // Padding(
// // //                 //   padding: const EdgeInsets.all(8),
// // //                 //    child: TextFieldContainer(
// // //                 //     text: "Role" ,
// // //                 //     controllerName: roleCtrl, validator: (String?value){
// // //                 //       if(value==null || value.isEmpty){
// // //                 //         return 'Please select your role';
// // //                 //       }
// // //                 //       return null;
// // //                 //     }),
// // //                 //   ),
// // //                 SizedBox(height: 18),
// // //                 Padding(
// // //                   padding: const EdgeInsets.only(left: 20.0, right: 15),
// // //                   child: Container(
// // //                     height: 50.h,
// // //                     width: 350.w,
// // //                     decoration: BoxDecoration(
// // //                       borderRadius: BorderRadius.circular(8),
// // //                       border: BoxBorder.all(
// // //                         width: 1,
// // //                         color: AppColors.opacitygreyColor,
// // //                       ),
// // //                     ),
// // //                     child: Padding(
// // //                       padding: const EdgeInsets.all(8),
// // //                       child: TextFormField(
// // //                         controller: passwordCtrl,
// // //                          validator: (String? value){
// // //                           if (value==null || value.isEmpty){
// // //                             return 'Please enter your password';
// // //                           }
// // //                           if(value.length < 8){
// // //                             return 'password must be at laest 8 characters';
// // //                           }
// // //                           return null;
// // //                          },
// // //                         obscureText: obscurePassword,
// // //                         decoration: InputDecoration(
// // //                           border: InputBorder.none,
// // //                           hintText: 'Change Password',
// // //                           hintStyle: TextStyle(
// // //                             fontSize: 18.sp,
// // //                             color: AppColors.opacitygrayColorText,
// // //                           ),
            
// // //                           suffixIcon: IconButton(
// // //                             icon: obscurePassword
// // //                                 ? Icon(Icons.visibility_off_outlined)
// // //                                 : Icon(Icons.visibility_outlined),
// // //                             onPressed: () {
// // //                               setState(() {
                              
// // //                                 obscurePassword = !obscurePassword;
// // //                               });
// // //                             },
// // //                           ),
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 ),
            
                
// // //                 SizedBox(height: 30),
// // //               ],
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //       bottomNavigationBar: Padding(
// // //         padding: const EdgeInsets.all(20.0),
// // //         child: GreenButton(
// // //           text: 'submit',
// // //           onTap: () async{
// // //             if(_formkey.currentState!.validate()){
// // //             Map<String, dynamic> userDetails = {
// // //              "USER_NAME":nameCtlr.text.trim(),
// // //              "USER_EMAIL": emailCtrl.text.trim(),
// // //              "USER_PASSWORD": passwordCtrl.text.trim(),
// // //             };
// // //             //await updatePerson(userDetails);
// // //             ref.read(updateProfileControllerProvider);
// // //             }
// // //             Navigator.push(
// // //               context,
// // //               MaterialPageRoute(
// // //                 builder: (context) => BottomNavigationWidget(currentIndex: 3, propertytype:[] , price: null, sqft: null, ),
// // //               ),
// // //             );
// // //           },
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //   // updatePerson(Map<String, dynamic> userDetails) async {
// // //   //   FirebaseFirestore.instance.collection("STAFF").doc(widget.loginUser.id)
// // //   //    .update(userDetails).then((value) {
// // //   //   log("Updated successfully");
// // //   // }).onError((e, stackTrace) {
// // //   //   log("Error is $e", name: "oxdo");
// // //   // });
// // //   // }
   
// // // }

// // import 'dart:developer';
// // import 'dart:io';

// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:property_managment/core/constant/app_colors.dart';
// // import 'package:property_managment/core/utils/appbar_widget.dart';
// // import 'package:property_managment/core/utils/bottom_navigation_bar.dart';
// // import 'package:property_managment/core/utils/green_button.dart';
// // import 'package:property_managment/core/utils/text_field.dart';
// // import 'package:property_managment/features/profile/controllers/profileControllers.dart';
// // import 'package:property_managment/modelClass/user_model.dart';

// // class EditProfileScreen extends ConsumerStatefulWidget {
// //   final UserModel loginUser;

// //   const EditProfileScreen({
// //     super.key,
// //     required this.loginUser,
// //   });

// //   @override
// //   ConsumerState<EditProfileScreen> createState() => _EditprofileScreenState();
// // }

// // class _EditprofileScreenState extends ConsumerState<EditProfileScreen> {
// //   final _formkey = GlobalKey<FormState>();

// //   bool obscurePassword = false;

// //   TextEditingController nameCtlr = TextEditingController();
// //   TextEditingController emailCtrl = TextEditingController();
// //   TextEditingController passwordCtrl = TextEditingController();

// //   File? _selectedImage;
// //   final ImagePicker _picker = ImagePicker();

// //   Future<void> _pickImage() async {
// //     final pickedFile = await _picker.pickImage(
// //       source: ImageSource.gallery,
// //     );

// //     if (pickedFile != null) {
// //       setState(() {
// //         _selectedImage = File(pickedFile.path);
// //       });
// //     }
// //   }

// //   @override
// //   void initState() {
// //     super.initState();

// //     // Prefill user data
// //     nameCtlr.text = widget.loginUser.name;
// //     emailCtrl.text = widget.loginUser.email;
// //     passwordCtrl.text = widget.loginUser.password;
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final repo = ref.read(profileRepositoryProvider);

// //     return Scaffold(
// //       appBar: AppbarWidget(
// //         child: Row(
// //           children: [
// //             Padding(
// //               padding: const EdgeInsets.only(left: 10.0),
// //               child: GestureDetector(
// //                 onTap: () => Navigator.pop(context),
// //                 child: Icon(Icons.keyboard_arrow_left,
// //                     size: 30, color: AppColors.white),
// //               ),
// //             ),
// //             const SizedBox(width: 10),
// //             const Text(
// //               'Edit Profile',
// //               style: TextStyle(
// //                 color: AppColors.white,
// //                 fontSize: 21,
// //                 fontWeight: FontWeight.w600,
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),

// //       body: Padding(
// //         padding: const EdgeInsets.only(right: 10.0, top: 15),
// //         child: SingleChildScrollView(
// //           child: Form(
// //             key: _formkey,
// //             child: Column(
// //               children: [
// //                 // PROFILE IMAGE
// //                 Stack(
// //                   children: [
// //                     Container(
// //                       height: 100,
// //                       width: 100,
// //                       decoration: BoxDecoration(
// //                         shape: BoxShape.circle,
// //                         border: Border.all(color: AppColors.OpacitygreyColor),
// //                         image: _selectedImage != null
// //                             ? DecorationImage(
// //                                 image: FileImage(_selectedImage!),
// //                                 fit: BoxFit.cover,
// //                               )
// //                             : null,
// //                       ),
// //                       child: _selectedImage == null
// //                           ? Icon(Icons.person,
// //                               color: AppColors.OpacitygreyColor, size: 55)
// //                           : null,
// //                     ),
// //                     Positioned(
// //                       bottom: 0,
// //                       right: 5,
// //                       child: InkWell(
// //                         onTap: _pickImage,
// //                         child: Container(
// //                           height: 30,
// //                           width: 30,
// //                           decoration: BoxDecoration(
// //                             color: AppColors.greenColor,
// //                             shape: BoxShape.circle,
// //                           ),
// //                           child: const Icon(Icons.add,
// //                               color: AppColors.white, size: 20),
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),

// //                 const SizedBox(height: 40),

// //                 // NAME
// //                 Padding(
// //                   padding: const EdgeInsets.symmetric(horizontal: 20),
// //                   child: TextFieldContainer(
// //                     text: 'Name',
// //                     controllerName: nameCtlr,
// //                     readOnly: false,
// //                     validator: (String? value) {
// //                       if (value == null || value.isEmpty) {
// //                         return 'Please enter your name';
// //                       }
// //                       if (!RegExp(r'^[A-Z]').hasMatch(value)) {
// //                         return 'First letter must be capital';
// //                       }
// //                       return null;
// //                     },
// //                   ),
// //                 ),

// //                 const SizedBox(height: 18),

// //                 // EMAIL
// //                 Padding(
// //                   padding: const EdgeInsets.symmetric(horizontal: 20),
// //                   child: TextFieldContainer(
// //                     text: 'Email',
// //                     controllerName: emailCtrl,
// //                     readOnly: false,
// //                     validator: (String? value) {
// //                       if (value == null || value.isEmpty) {
// //                         return 'Please enter your email';
// //                       }
// //                       if (!value.contains('@')) {
// //                         return 'Enter a valid email';
// //                       }
// //                       return null;
// //                     },
// //                   ),
// //                 ),

// //                 const SizedBox(height: 18),

// //                 // PASSWORD
// //                 Padding(
// //                   padding: const EdgeInsets.symmetric(horizontal: 20),
// //                   child: Container(
// //                     height: 50.h,
// //                     decoration: BoxDecoration(
// //                       borderRadius: BorderRadius.circular(8),
// //                       border:
// //                           Border.all(width: 1, color: AppColors.opacitygreyColor),
// //                     ),
// //                     child: TextFormField(
// //                       controller: passwordCtrl,
// //                       obscureText: obscurePassword,
// //                       validator: (String? value) {
// //                         if (value == null || value.isEmpty) {
// //                           return 'Enter your password';
// //                         }
// //                         if (value.length < 8) {
// //                           return 'Password must be at least 8 chars';
// //                         }
// //                         return null;
// //                       },
// //                       decoration: InputDecoration(
// //                         border: InputBorder.none,
// //                         hintText: 'Change Password',
// //                         suffixIcon: IconButton(
// //                           icon: obscurePassword
// //                               ? Icon(Icons.visibility_off_outlined)
// //                               : Icon(Icons.visibility_outlined),
// //                           onPressed: () {
// //                             setState(() {
// //                               obscurePassword = !obscurePassword;
// //                             });
// //                           },
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ),

// //                 const SizedBox(height: 30),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),

// //       // SUBMIT BUTTON
// //       bottomNavigationBar: Padding(
// //         padding: const EdgeInsets.all(20),
// //         child: GreenButton(
// //           text: 'Submit',
// //           onTap: () async {
// //             if (_formkey.currentState!.validate()) {
// //               Map<String, dynamic> userDetails = {
// //                 "USER_NAME": nameCtlr.text.trim(),
// //                 "USER_EMAIL": emailCtrl.text.trim(),
// //                 "USER_PASSWORD": passwordCtrl.text.trim(),
// //               };

// //               // UPDATE PROFILE
// //               await FirebaseFirestore.instance
// //                   .collection("STAFF")
// //                   .doc(widget.loginUser.id)
// //                   .update(userDetails);

// //               log("Updated Successfully");

// //               Navigator.push(
// //                 context,
// //                 MaterialPageRoute(
// //                   builder: (_) => BottomNavigationWidget(
// //                     currentIndex: 3,
// //                     propertytype: [],
// //                     price: null,
// //                     sqft: null,
// //                   ),
// //                 ),
// //               );
// //             }
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:developer';
// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:property_managment/core/constant/app_colors.dart';
// import 'package:property_managment/core/provider/is_loading.dart';
// import 'package:property_managment/core/utils/appbar_widget.dart';
// import 'package:property_managment/core/utils/bottom_navigation_bar.dart';
// import 'package:property_managment/core/utils/cloudinary_img/dio.dart';
// import 'package:property_managment/core/utils/green_button.dart';
// import 'package:property_managment/core/utils/text_field.dart';
// import 'package:property_managment/features/profile/controllers/profileControllers.dart';
// import 'package:property_managment/modelClass/user_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class EditProfileScreen extends ConsumerStatefulWidget {
//   final UserModel loginUser;

//   const EditProfileScreen({
//     super.key,
//     required this.loginUser,
//   });

//   @override
//   ConsumerState<EditProfileScreen> createState() => _EditprofileScreenState();
// }

// class _EditprofileScreenState extends ConsumerState<EditProfileScreen> {
//   final _formkey = GlobalKey<FormState>();

//   bool obscurePassword = false;

//   TextEditingController nameCtlr = TextEditingController();
//   TextEditingController emailCtrl = TextEditingController();
//   TextEditingController passwordCtrl = TextEditingController();
//   TextEditingController phoneCtrl = TextEditingController(); // ⭐ ADDED

//   String? existingImageUrl;

//   // Future<void> _pickImage() async {
//   //   final pickedFile = await _picker.pickImage(
//   //     source: ImageSource.gallery,
//   //   );

//   //   if (pickedFile != null) {
//   //     setState(() {
//   //       _selectedImage = File(pickedFile.path);
//   //     });
//   //   }
//   // }

//   @override
//   void initState() {
//     super.initState();

//     // Prefill user data
//     nameCtlr.text = widget.loginUser.name;
//     emailCtrl.text = widget.loginUser.email;
//     passwordCtrl.text = widget.loginUser.password;
//     phoneCtrl.text = widget.loginUser.Mobilenumber ?? ""; // ⭐ ADDED
//      existingImageUrl =
//         (widget.loginUser.profileImage != null &&
//             widget.loginUser.profileImage!.isNotEmpty)
//         ? widget.loginUser.profileImage
//         : null;
  
//   }
//   pickImg(WidgetRef ref) async {
//     final picker = ImagePicker();
//     final picked = await picker.pickImage(
//       source: ImageSource.gallery,
//       maxWidth: 1600,
//     );
//     if (picked == null) return;

//     ref.read(profileImageProvider.notifier).setImage(File(picked.path));
//   } 
 

//   @override
//   Widget build(BuildContext context) {
//     final repo = ref.read(profileRepositoryProvider);
//     final pickedImage = ref.watch(profileImageProvider);
//     return Scaffold(
//       appBar: AppbarWidget(
//         child: Row(
//           children: [
//             GestureDetector(
//               onTap: () => Navigator.pop(context),
//               child: Icon(Icons.keyboard_arrow_left,
//                   size: 30, color: AppColors.white),
//             ),
//             const SizedBox(width: 10),
//             const Text(
//               'Edit Profile',
//               style: TextStyle(
//                 color: AppColors.white,
//                 fontSize: 21,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),

//       body: Padding(
//         padding: const EdgeInsets.only(right: 10.0, top: 15),
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formkey,
//             child: Column(
//               children: [
//                 // PROFILE IMAGE
//                 Stack(
//                   children: [
//                     Container(
//                       height: 100,
//                       width: 100,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(color: AppColors.OpacitygreyColor),
//                        image: pickedImage != null
//                             ? DecorationImage(
//                                 image: FileImage(pickedImage),
//                                 fit: BoxFit.cover,
//                               )
//                             : (existingImageUrl != null
//                                   ? DecorationImage(
//                                       image: NetworkImage(existingImageUrl!),
//                                       fit: BoxFit.cover,
//                                     )
//                                   : null),
//                       ),
//                       child: pickedImage == null
//                           ? null
//                           : Icon(
//                               Icons.person,
//                               color: AppColors.OpacitygreyColor,
//                             ),
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       right: 5,
//                       child: InkWell(
//                         onTap: () => pickImg(ref),
//                         child: Container(
//                           height: 30,
//                           width: 30,
//                           decoration: const BoxDecoration(
//                             color: AppColors.greenColor,
//                             shape: BoxShape.circle,
//                           ),
//                           child: const Icon(Icons.add,
//                               color: AppColors.white, size: 20),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 40),

//                 // NAME
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: TextFieldContainer(
//                     text: 'Name',
//                     controllerName: nameCtlr,
//                     readOnly: false,
//                     validator: (String? value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your name';
//                       }
//                       if (!RegExp(r'^[A-Z]').hasMatch(value)) {
//                         return 'First letter must be capital';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),

//                 const SizedBox(height: 18),

//                 // EMAIL
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: TextFieldContainer(
//                     text: 'Email',
//                     controllerName: emailCtrl,
//                     readOnly: false,
//                     validator: (String? value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your email';
//                       }
//                       if (!value.contains('@')) {
//                         return 'Enter a valid email';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),

//                 const SizedBox(height: 18),

//                 //  PHONE NUMBER FIELD
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: TextFieldContainer(
//                     text: 'Contact',
//                     controllerName: phoneCtrl,
//                     readOnly: false,
//                     validator: (String? value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter phone number';
//                       }
//                       if (value.length != 10) {
//                         return 'Phone number must be 10 digits';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),

//                 const SizedBox(height: 18),

//                 // PASSWORD
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Container(
//                     height: 50.h,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       border:
//                           Border.all(width: 1, color: AppColors.opacitygreyColor),
//                     ),
//                     child: TextFormField(
//                       controller: passwordCtrl,
//                       obscureText: obscurePassword,
//                       validator: (String? value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Enter your password';
//                         }
//                         if (value.length < 8) {
//                           return 'Password must be at least 8 chars';
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                         hintText: 'Change Password',
//                         suffixIcon: IconButton(
//                           icon: obscurePassword
//                               ? Icon(Icons.visibility_off_outlined)
//                               : Icon(Icons.visibility_outlined),
//                           onPressed: () {
//                             setState(() {
//                               obscurePassword = !obscurePassword;
//                             });
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 30),
//               ],
//             ),
//           ),
//         ),
//       ),

//       // SUBMIT BUTTON
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(20),
//         child: GreenButton(
//           text: 'Submit',
//           onTap: () async {
//             if (_formkey.currentState!.validate()) {
//               Map<String, dynamic> userDetails = {
//                 "USER_NAME": nameCtlr.text.trim(),
//                 "USER_EMAIL": emailCtrl.text.trim(),
//                 "USER_PASSWORD": passwordCtrl.text.trim(),
//                 "USER_PHONE": phoneCtrl.text.trim(), 
//               };

//               await FirebaseFirestore.instance
//                   .collection("STAFF")
//                   .doc(widget.loginUser.id)
//                   .update(userDetails);

//               log("Updated Successfully");

//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => BottomNavigationWidget(
//                     currentIndex: 3,
//                     propertytype: [],
//                     price: null,
//                     sqft: null,
//                   ),
//                 ),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:property_managment/core/constant/app_colors.dart';
import 'package:property_managment/core/utils/appbar_widget.dart';
import 'package:property_managment/core/utils/green_button.dart';
import 'package:property_managment/core/utils/text_field.dart';
import 'package:property_managment/core/utils/cloudinary_img/dio.dart';
import 'package:property_managment/features/profile/controllers/profileControllers.dart';
import 'package:property_managment/modelClass/user_model.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  final UserModel loginUser;

  const EditProfileScreen({super.key, required this.loginUser});

  @override
  ConsumerState<EditProfileScreen> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  bool obscurePassword = false;
  String? existingImageUrl;

  @override
  void initState() {
    super.initState();
    nameCtrl.text = widget.loginUser.name;
    emailCtrl.text = widget.loginUser.email;
    passCtrl.text = widget.loginUser.password;
    phoneCtrl.text = widget.loginUser.Mobilenumber ?? "";
    existingImageUrl = widget.loginUser.profileImage;
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      ref
          .read(profileImageProvider.notifier)
          .setImage(File(picked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final pickedImage = ref.watch(profileImageProvider);

    return Scaffold(
      appBar: AppbarWidget(
        child: const Text(
          "Edit Profile",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),

              /// ✅ PROFILE IMAGE
              Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: pickedImage != null
                        ? FileImage(pickedImage)
                        : (existingImageUrl != null
                            ? NetworkImage(existingImageUrl!)
                            : null) as ImageProvider?,
                    backgroundColor: AppColors.opacityGrey,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: pickImage,
                      child: const CircleAvatar(
                        radius: 16,
                        backgroundColor: AppColors.greenColor,
                        child: Icon(Icons.edit,
                            size: 16, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 30),

              /// NAME
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFieldContainer(
                  text: "Name",
                  controllerName: nameCtrl,
                  readOnly: false,
                ),
              ),

              const SizedBox(height: 15),

              /// EMAIL
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFieldContainer(
                  text: "Email",
                  controllerName: emailCtrl,
                  readOnly: false,
                ),
              ),

              const SizedBox(height: 15),

              /// PHONE
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFieldContainer(
                  text: "Contact",
                  controllerName: phoneCtrl,
                  readOnly: false,
                ),
              ),

              // const SizedBox(height: 15),

              // /// PASSWORD
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: TextFormField(
              //     controller: passCtrl,
              //     obscureText: obscurePassword,
              //     decoration: InputDecoration(
              //       hintText: "Password",
              //       suffixIcon: IconButton(
              //         icon: Icon(obscurePassword
              //             ? Icons.visibility_off
              //             : Icons.visibility),
              //         onPressed: () {
              //           setState(() {
              //             obscurePassword = !obscurePassword;
              //           });
              //         },
              //       ),
              //     ),
              //   ),
              // ),

              const SizedBox(height: 15),

Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child: Container(
    height: 48, // 🔥 Reduced height
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: AppColors.opacitygreyColor),
      color: Colors.transparent, // 🔥 No white background
    ),
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: passCtrl,
            obscureText: obscurePassword,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Password",
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ),
        ),

        IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(
            obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: AppColors.greenColor,
            size: 20,   // 🔥 smaller icon
          ),
          onPressed: () {
            setState(() {
              obscurePassword = !obscurePassword;
            });
          },
        )
      ],
    ),
  ),
),


            ],
          ),
        ),
      ),

      /// ✅ SUBMIT
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: GreenButton(
          text: "Update",
          onTap: () async {
            if (!_formKey.currentState!.validate()) return;

            String? imageUrl = existingImageUrl;

            if (pickedImage != null) {
              imageUrl = await uploadUnsigned(
                pickedImage!,
                cloudName: "cloudName",
                uploadPreset: "uploadPresset",
                );
            }

            await FirebaseFirestore.instance
                .collection("STAFF")
                .doc(widget.loginUser.id)
                .update({
              "USER_NAME": nameCtrl.text.trim(),
              "USER_EMAIL": emailCtrl.text.trim(),
              "USER_PASSWORD": passCtrl.text.trim(),
              "USER_PHONE": phoneCtrl.text.trim(),
              "PROFILE_IMAGE": imageUrl,
            });

             ref.read(profileImageProvider.notifier).clear();

            // log("Profile updated");
           
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

