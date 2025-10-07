import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/core/theme/app_textstyl.dart';
import 'package:property_managment/core/theme/asset_resource.dart';
import 'package:property_managment/presentation/dashboard/widget/bookingcontainer.dart';
import 'package:property_managment/presentation/dashboard/widget/container_widget.dart';
import 'package:property_managment/widget/appbar_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppbarWidget(
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Text(
                'Hi',
                style: AppTextstyle.propertysmallTextstyle(
                  context,
                  fontSize: 14.sp,
                  fontColor: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Nidha c',
                style: AppTextstyle.propertyMediumTextstyle(
                  context,
                  fontSize: 16.sp,
                  fontColor: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: ContainerWidget(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(AssetResource.booked),
                          SizedBox(height: 5,),
                          Text(
                            'Booked',
                            style: AppTextstyle.propertyMediumTextstyle(
                              context,
                              fontColor: AppColors.black,
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            '100',
                            style: AppTextstyle.propertyLargeTextstyle(
                              context,
                              fontColor: AppColors.greenColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(8.w)),
                ContainerWidget(
                  //imagepath: AssetResources.vacant,
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(AssetResource.vacant),
                        SizedBox(height: 5,),
                        Text(
                          'vacant',
                          style: AppTextstyle.propertyMediumTextstyle(
                            context,
                            fontColor: AppColors.black,
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          '30',
                          style: AppTextstyle.propertyLargeTextstyle(
                            context,
                            fontColor: AppColors.redcolor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: ContainerWidget(
                height: 70.h,
                width: 350.w,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: SvgPicture.asset(AssetResource.totalproperty),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Total Properties',
                        style: AppTextstyle.propertyMediumTextstyle(
                          context,
                          fontColor: AppColors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 130),
                      child: Text(
                        '130',
                        style: AppTextstyle.propertyLargeTextstyle(
                          context,
                          fontColor: AppColors.yellowcolor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5.h),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Recent Booking',
                    style: AppTextstyle.propertyLargeTextstyle(
                      context,
                      fontWeight: FontWeight.bold,
                      fontColor: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BookingConatainerWidget(child: Column()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    
    );
  }
}
