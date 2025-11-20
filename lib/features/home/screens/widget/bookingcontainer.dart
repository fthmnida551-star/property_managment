import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:property_managment/core/constant/app_colors.dart';
import 'package:property_managment/core/constant/app_textstyl.dart';
import 'package:property_managment/core/constant/asset_resource.dart';
import 'package:property_managment/modelClass/bookingmodel.dart';
import 'package:property_managment/modelClass/property_model.dart';
import 'package:property_managment/features/booking/screens/booked_details.dart';

class BookingConatainerWidget extends StatefulWidget {
  final BookingModel bookedProperty;
  final PropertyModel property;
  final Color? color;
  final String? imagepath1;
  final String? imagepath2;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  const BookingConatainerWidget({
    super.key,
    this.color,
    this.imagepath1,
    this.imagepath2,
    this.padding,
    this.borderRadius,
    required this.bookedProperty,
    required this.property,
  });

  @override
  State<BookingConatainerWidget> createState() =>
      _BookingConatainerWidgetState();
}

class _BookingConatainerWidgetState extends State<BookingConatainerWidget> {
  // getPropertyImage() async{
  //   print("22222222222222222  ${widget.bookedProperty.propertyId}");
  //   property = await getPropertyById(widget.bookedProperty.propertyId);
  //   log("propertyyyyyy $property");
  //   if(property != null)
  //   {log("wwwwwwwww ${property!.image}");}

  // }

  @override
  Widget build(BuildContext context) {
    // if(property != null)log(property!.image[0]);

    return InkWell(
      onTap: () async {
        print(" Booking tapped!");
        print("Property ID from booking: ${widget.bookedProperty.propertyId}");

        //  property = await getPropertyById(widget.bookedProperty.propertyId);

        // print("Fetched property: ${widget.property.name ?? 'NULL'}");

        try {
          if (widget.property != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookedDetails(
                  userName: widget.bookedProperty.name,
                  bookedProperty: widget.bookedProperty,
                  property: widget.property,
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Property not found")));
          }
        } catch (e) {
          print("Navigation error: $e");
        }
      },
      child: Container(
        height: 75.h,
        padding: widget.padding ?? const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.opacitygreyColor),
          color: widget.color ?? AppColors.white,
          borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: AppColors.black,
              spreadRadius: 0.7,
              blurRadius: 0.7,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: widget.property.image.isNotEmpty
                  ? Image.network(
                      widget.property.image[0],
                      fit: BoxFit.cover,
                      height: 50,
                      width: 50,
                    )
                  : Container(
                    height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1,color: Colors.grey.shade400),),
                    child: Icon(Icons.image,color: Colors.grey,))
            ),
            SizedBox(width: 15.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
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
                    const SizedBox(width: 5),
                    Text(widget.bookedProperty.contact),
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
