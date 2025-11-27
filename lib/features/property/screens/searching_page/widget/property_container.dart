import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/constant/app_colors.dart';
import 'package:property_managment/core/utils/cloudinary_img/picking_img.dart';
import 'package:property_managment/core/utils/location/concert_section.dart';
import 'package:property_managment/modelClass/property_model.dart';
import 'package:property_managment/features/property/screens/propertydetails/property_details/not_booked.dart';

class PropertyContainer extends StatefulWidget {
  final String text;
  final Color? color;
  final Color? textColor;
  final bool isShow;
  final VoidCallback? onTap;
  final PropertyModel property;
  const PropertyContainer({
    super.key,
    required this.text,
    this.color,
    this.textColor,
    this.isShow = true,
    this.onTap,
    required this.property,
  });
  @override
  State<PropertyContainer> createState() => _PropertyContainerState();
}

class _PropertyContainerState extends State<PropertyContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          widget.onTap ??
          () {
            log("PropertyContainer ${widget.property.id}");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotBookedPropertyScreen(
                  userName: '',
                  property: widget.property,
                ),
              ), //NotBookedPropertyScreen()),
            );
          },
      child: Container(
        height: 400.h,
        color: AppColors.propertyContainer,
        margin: EdgeInsets.only(bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.property.image.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    // child: Image.asset(
                    //   // AssetResource.building,
                    //   ('${widget.property.image}'),
                    //   fit: BoxFit.cover,
                    //   height: 209,
                    //   width: 356,
                    // ),
                    child: Image.network(
                      widget.property.image[0],
                      fit: BoxFit.cover,
                      height: 209,
                      width: 356,
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    height: 209,
                    width: 356,
                    child: Center(
                      child: Icon(
                        Icons.image,
                        color: Colors.grey.shade400,
                        size: 45,
                      ),
                    ),
                  ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // 'modern amenities',
                  widget.property.name.toUpperCase(),
                  style: TextStyle(fontSize: 21.sp, color: AppColors.black),
                ),
                Text(
                  widget.property.propertyType,
                  style: TextStyle(fontSize: 12, color: AppColors.black),
                ),
              ],
            ),
            Text(
              // '90,000',
              "${widget.property.price}",
              style: TextStyle(fontSize: 44.sp, color: AppColors.black),
            ),
            // Row(
            //   children: [
            //     Icon(Icons.location_on_outlined, size: 20),
            //     Text(
            //       // 'Azizi Aliyah,al jaddaf, Dubai',
            //       widget.property.location,
            //       style: TextStyle(fontSize: 19.sp, color: AppColors.black),
            //     ),
            //   ],
            // ),
            if (widget.property.latitude != null &&
                widget.property.longitude != null)
              FutureBuilder(
                future: convertLatLngToAddress(
                  widget.property.latitude!,
                  widget.property.longitude!,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: EdgeInsets.only(top: 4.0),
                      child: Text(
                        "Fetching location...",
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Text("Error loading address");
                  }

                  return Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    // child: Text(
                    //   (snapshot.data as String?) ?? "Location not available",

                    //   style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    // ),
                    child: Text(
                      (snapshot.data as String?) ?? "Location not available",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                  );
                },
              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.property.propertyType != "LAND")
                  Row(
                    children: [
                      Icon(Icons.bed_outlined, size: 20.sp),
                      Center(child: Text('${widget.property.bhk}')),
                    ],
                  ),
                if (widget.property.propertyType != "LAND")
                  Row(
                    children: [
                      Icon(Icons.bathtub_outlined, size: 18.sp),
                      Center(child: Text('${widget.property.bathrooms}')),
                    ],
                  ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(' ${widget.property.sqft}'),
                    Text(
                      'sqf',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                widget.isShow
                    ? Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 99.75.w,
                          height: 35.h,
                          decoration: BoxDecoration(
                            color: widget.color ?? AppColors.propertyContainer,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.bookingNow),
                          ),
                          child: Center(
                            child: Text(
                              widget.text,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: widget.textColor ?? AppColors.black,
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
