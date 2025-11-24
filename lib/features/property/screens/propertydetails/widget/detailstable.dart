import 'package:flutter/material.dart';
import 'package:property_managment/core/constant/app_colors.dart';

class DetailsTable extends StatefulWidget {
  final IconData icons;
  final String text;
  final String? details;
  final Widget? detailsWidget;
  const DetailsTable({
    super.key,
    required this.text,
     this.details,
    required this.icons,
    this.detailsWidget
  });

  @override
  State<DetailsTable> createState() => _DetailsTableState();
}

class _DetailsTableState extends State<DetailsTable> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(widget.icons, color: AppColors.black),
            Text(widget.text),
          ],
        ),
        // Padding(
        //   padding: const EdgeInsets.only(right: 8.0),
        //   child: Text(widget.details),
        // ),
        SizedBox(width: 65,),
         Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 2.0),
            child: Align(
              alignment: Alignment.centerRight,
              child:widget.detailsWidget ?? Text(widget.details ?? ""),
            ),
          ),
        ),
      ],
    );
  }
}
