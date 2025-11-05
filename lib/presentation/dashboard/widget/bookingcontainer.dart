import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/core/theme/app_textstyl.dart';
import 'package:property_managment/core/theme/asset_resource.dart';
import 'package:property_managment/firebase/firebase_service.dart';
import 'package:property_managment/modelClass/bookingmodel.dart';
import 'package:property_managment/modelClass/property_model.dart';
import 'package:property_managment/presentation/dashboard/booked_details/booked_details.dart';
import 'package:property_managment/firebase/firebase_service.dart';

class BookingConatainerWidget extends StatefulWidget {
  final BookingModel bookedProperty;
  final Color? color;
  final String? imagepath1;
  final String? imagepath2;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  BookingConatainerWidget({
    super.key,
    this.color,
    this.imagepath1,
    this.imagepath2,
    this.padding,
    this.borderRadius,
    required this.bookedProperty,
  });

  @override
  State<BookingConatainerWidget> createState() =>
      _BookingConatainerWidgetState();
}

class _BookingConatainerWidgetState extends State<BookingConatainerWidget> {
  FirebaseFirestore fdb = FirebaseFirestore.instance;
  Future<PropertyModel?> getPropertyById(String propertyId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await fdb
          .collection('PROPERTIES')
          .doc(propertyId)
          .get();

      if (doc.exists && doc.data() != null) {
        // Merge Firestore ID with document data
        final data = doc.data()!;
        data['id'] = doc.id;
        return PropertyModel.fromMap(data);
      } else {
        print("No property found for ID: $propertyId");
        return null;
      }
    } catch (e) {
      print("Error fetching property: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        PropertyModel? property = await getPropertyById(
          widget.bookedProperty.propertyId,
        );

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => BookedDetails(
        //       userName: widget.bookedProperty.name,
        //       bookedProperty: widget.bookedProperty,
        //       property: property!,

        //     ),
        //   ),
        // );
        if (property != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookedDetails(
                userName: widget.bookedProperty.name,
                bookedProperty: widget.bookedProperty,
                property: property,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Property not found")));
        }
      },
      child: Container(
        height: 75.h,
        padding: widget.padding ?? EdgeInsets.all(12),

        decoration: BoxDecoration(
          border: BoxBorder.all(color: AppColors.opacitygreyColor),
          color: widget.color ?? AppColors.white,
          borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.black,
              spreadRadius: 0.7,
              blurRadius: 0.7,
              offset: Offset.infinite,
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.asset(
                AssetResource.bookingbuilding1,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 15),
            Column(
              children: [
                Text(
                  widget.bookedProperty.name,
                  style: AppTextstyle.propertyMediumTextstyle(
                    context,
                    fontColor: AppColors.black,
                  ),
                ),

                Row(
                  children: [
                    SvgPicture.asset(AssetResource.contact),
                    SizedBox(width: 5),
                    Text(widget.bookedProperty.contact.toString()),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
