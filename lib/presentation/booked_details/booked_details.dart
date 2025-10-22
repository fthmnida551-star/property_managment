import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/presentation/searching_page/widget/property_container.dart';
import 'package:property_managment/widget/appbar_widget.dart';

class BookedDetails extends StatelessWidget {
  const BookedDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.keyboard_arrow_left, size: 30.sp),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              PropertyContainer(text: 'abc', isShow: false),
          
              Row(
                children: [
                  Icon(Icons.person, color: Colors.green),
                  SizedBox(width: 8),
                  Text('Name\n Hrishilal'),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.phone, color: Colors.green),
                  SizedBox(width: 8),
                  Text('Mobile No'),
                  Text('+91 960592260'),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.mail, color: Colors.green),
                  SizedBox(width: 8),
                  Text('Email\n Hrishilal@gmail.com'),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.calendar_month, color: Colors.green),
                  SizedBox(width: 8),
                  Text('Date\n 2-3-2025'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
