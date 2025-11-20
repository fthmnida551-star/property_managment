import 'dart:io';
import 'package:dio/dio.dart';

Future<String> uploadUnsigned(File file, {
  required String cloudName,
  required String uploadPreset,
}) async {
  final dio = Dio();
  final url = 'https://api.cloudinary.com/v1_1/$cloudName/image/upload';

  final formData = FormData.fromMap({
    'file': await MultipartFile.fromFile(file.path, filename: file.path.split('/').last),
    'upload_preset': uploadPreset,
    // optionally 'folder': 'my_app_folder'
  });

  final resp = await dio.post(url, data: formData);
  if (resp.statusCode == 200 || resp.statusCode == 201) {
    return resp.data['secure_url'] as String;
  } else {
    throw Exception('Upload failed: ${resp.statusCode}');
  }
}

Future<List<String>> uploadMultipleUnsigned(
  List<File> files, {
  required String cloudName,
  required String uploadPreset,
}) async {
  List<String> uploadedUrls = [];

  for (var file in files) {
    final url = await uploadUnsigned(
      file,
      cloudName: cloudName,
      uploadPreset: uploadPreset,
    );
    uploadedUrls.add(url);
  }

  return uploadedUrls;
}

