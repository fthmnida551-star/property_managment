import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:property_managment/core/constant/app_colors.dart';
import 'package:property_managment/core/utils/location/concert_section.dart';

class AddressWidget extends StatelessWidget {
  final double lat;
  final double lng;
  final TextStyle? style;

  const AddressWidget({
    super.key,
    required this.lat,
    required this.lng,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future:convertLatLngToAddress (lat, lng),
      builder: (context, snapshot) {
        String text = "Loading...";

        if (snapshot.connectionState == ConnectionState.done) {
          text = snapshot.data ?? "Unknown location";
        }

        return Text(
          text,
          style: style ?? TextStyle(fontSize: 15, color: AppColors.black),
          maxLines: 6,
          overflow: TextOverflow.ellipsis,
        );
      },
    );
  }
 
}
