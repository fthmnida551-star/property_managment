import 'package:flutter/material.dart';
import 'package:property_managment/core/constant/app_colors.dart';

class NotificationContainer extends StatefulWidget {
  final String text;
  final Color color;
  const NotificationContainer({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  State<NotificationContainer> createState() => _NotificationContainerState();
}

class _NotificationContainerState extends State<NotificationContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 71,
      decoration: BoxDecoration(
        color: AppColors.searchbar,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            Container(
              height: 43,
              width: 43,
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(
                  "P",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Propert Booked',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.text,
                  style: TextStyle(color: AppColors.greyColor, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
