import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


final picker = ImagePicker();
List<File> files = [];

pickAndUpload() async {
  final picked = await picker.pickImage(
    source: ImageSource.gallery,
    maxWidth: 1600,
  );
  if (picked == null) return;
  final pickedList = await picker.pickMultiImage(maxWidth: 1600);
  if (pickedList.isEmpty) return;

   files = pickedList.map((x) => File(x.path)).toList();
// 
  // final imageUrls = await uploadMultipleUnsigned(
  //   files,
  //   cloudName: 'dcijrvaw3',
  //   uploadPreset: 'property_images',
  // );

  // choose uploadSigned(file) or uploadUnsigned(file)
  // final imageUrl = await uploadUnsigned(file, cloudName: 'dcijrvaw3', uploadPreset: 'property_images');
  // final imageUrl= await uploadMultipleUnsigned(
  // [file1, file2, file3],
  // cloudName: 'your_cloud_name',
  // uploadPreset: 'your_upload_preset',
  // );
  // print(imageUrl);

  // // save metadata to Firestore
  // await FirebaseFirestore.instance.collection('uploads').add({
  //   'url': imageUrl,
  //   'uploadedBy': 'uid-or-name',
  //   'timestamp': FieldValue.serverTimestamp(),
  // });

  // print('Uploaded URL: $imageUrls');
}
