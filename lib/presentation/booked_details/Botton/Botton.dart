import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/core/theme/app_colors.dart';

class Button extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final IconData icon;
  const Button({super.key,required this.text,required this.onTap,required this.icon});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 170.w,
        height:47.h ,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.greenColor,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon,color: AppColors.white,),
              SizedBox(width:10 ,),
              Text(
                widget.text,
                style: TextStyle(color: AppColors.white, fontSize: 21),
              ),
            ],
          ),
        ),
      ),
    );

  }
}