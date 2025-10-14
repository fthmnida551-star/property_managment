import 'package:flutter/material.dart';
import 'package:property_managment/presentation/searching_page/widget/property_container.dart';

class BookedDetails extends StatelessWidget {
  const BookedDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
      child:Column(
        children:[
    PropertyContainer(text: 'abc',isShow: false,),

     Row(
      children: [
        Icon(Icons.person, color: Colors.green),
        SizedBox(width: 8),
        Text('Name\n Hrishilal'),
      ],
    ),Row(
      children: [
        Icon(Icons.phone, color: Colors.green),
        SizedBox(width: 8),
        Text('Mobile No'),
         Text('+91 960592260'),
      ],
    ),Row(
      children: [
        Icon(Icons.mail, color: Colors.green),
        SizedBox(width: 8),
        Text('Email\n Hrishilal@gmail.com'),
      ],
    ),Row(
      children: [
        Icon(Icons.calendar_month, color: Colors.green),
        SizedBox(width: 8),
        Text('Date\n 2-3-2025'),
      ],
    ),
        ]
      )
    ), 
    );
  }
}
