import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:property_managment/core/utils/cloudinary_img/dio.dart';
import 'package:property_managment/features/property/controllers/property_cntlr.dart';


// final picker = ImagePicker();
// List<File> files = [];

// pickAndUpload() async {
//   final picked = await picker.pickImage(
//     source: ImageSource.gallery,
//     maxWidth: 1600,
//   );
//   if (picked == null) return;
//   final pickedList = await picker.pickMultiImage(maxWidth: 1600);
//   if (pickedList.isEmpty) return;

//    files = pickedList.map((x) => File(x.path)).toList();

// }






