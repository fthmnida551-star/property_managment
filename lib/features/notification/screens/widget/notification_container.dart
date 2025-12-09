import 'package:flutter/material.dart';
import 'package:property_managment/core/constant/app_colors.dart';

class NotificationContainer extends StatefulWidget {
  final String title;
  final String text;
  final Color color;
  const NotificationContainer({
    super.key,
    required this.title,
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
      height: 100,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 199, 243, 217),
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                  widget.title[0].toUpperCase(), // first letter icon
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title, // 🔥 DYNAMIC TITLE
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
