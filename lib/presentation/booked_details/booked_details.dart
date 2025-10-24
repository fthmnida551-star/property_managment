import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:property_managment/presentation/booked_details/Botton/Botton.dart';
import 'package:property_managment/presentation/searching_page/widget/property_container.dart';
import 'package:property_managment/widget/appbar_widget.dart';

class BookedDetails extends StatelessWidget {
  const BookedDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppbarWidget(child: GestureDetector(onTap: () {
        Navigator.pop(context);
      },child: Icon(Icons.keyboard_arrow_left,size: 30.sp,),),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              PropertyContainer(text: 'abc', isShow: false),
             SizedBox(height: 16),
              Row(
                children:[
                  Icon(Icons.person_rounded, color: Colors.green),
                  SizedBox(width: 8),
                  Text('Name\nHrishilal'),
                ],
              ),
               SizedBox(height: 12),             
                Row(
                children: [
                  Icon(Icons.phone_rounded, color: Colors.green),
                  SizedBox(width: 8),
                  Text('Mobile No\n+91 960592260'),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.mail_rounded, color: Colors.green),
                  SizedBox(width: 8),
                  Text('Email\nHrishilal@gmail.com'),
                ],
              ),
            SizedBox(height: 12),
              Row(
                children:[
                  Icon(Icons.calendar_month_rounded, color: Colors.green),
                  SizedBox(width: 8),
                  Text('Date\n2-3-2025'),
                ],
              ), 
              SizedBox(height: 100,),
                Row(
                  children: [
                    Button(text: 'Delete', onTap: (){}, icon: Icons.delete_outline_outlined),
                    SizedBox(width: 20,),
                    Button(text: 'Edit', onTap: (){}, icon: Icons.edit_outlined),
                  ],
                )   
            ],
          ),     
        ),           
      ),  
    );
  }
}