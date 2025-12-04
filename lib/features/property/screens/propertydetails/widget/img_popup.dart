import 'package:flutter/material.dart';
import 'package:property_managment/core/constant/app_colors.dart';
import 'package:property_managment/modelClass/property_model.dart';

void imgpopup(BuildContext context, PropertyModel property, String imgUrl) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              imgUrl,
              
            ),
          ),
        ),
        child: Align(
          alignment: Alignment.topRight,
          child: CircleAvatar(
            radius: 15,
            backgroundColor: AppColors.white,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.close, color: AppColors.black),
            ),
          ),
        ),

        // SizedBox(height: 30,),
      ),
    ),
  );
}
