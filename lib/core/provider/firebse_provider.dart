import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:property_managment/core/constant/firebase_const.dart';

final firebaseServiceProvider = Provider((ref) => FirebaseService());