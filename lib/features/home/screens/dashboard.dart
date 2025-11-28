import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:property_managment/core/constant/app_colors.dart';
import 'package:property_managment/core/constant/app_textstyl.dart';
import 'package:property_managment/core/constant/asset_resource.dart';
import 'package:property_managment/core/utils/appbar_widget.dart';
import 'package:property_managment/features/home/controller/dashboard_controller.dart';
import 'package:property_managment/modelClass/bookingmodel.dart';
import 'package:property_managment/modelClass/property_model.dart';
import 'package:property_managment/features/home/screens/widget/bookingcontainer.dart';
import 'package:property_managment/features/home/screens/widget/container_widget.dart';

// ignore: must_be_immutable
class DashboardScreen extends ConsumerWidget {
  DashboardScreen({super.key});

  final FirebaseFirestore fdb = FirebaseFirestore.instance;

  List<BookingModel> bookedDetails = [];

  PropertyModel? property;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookedAsync = ref.watch(bookedpropertyListProvider);
    final propertyCountAsync = ref.watch(propertyListProvider);
    final bookedcountAsync = ref.watch(bookedListProvider);
    final total = ref.watch(propertyListProvider).value ?? 0;
    final booked = ref.watch(bookedListProvider).value ?? 0;
    final vacant = (total - booked) < 0 ? 0 : (total - booked);


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarWidget(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 30),
          child: Column(
            children: [
              SvgPicture.asset(AssetResource.appLogo),
              Text(
                'Property Mangement',
                style: AppTextstyle.propertyMediumTextstyle(
                  context,
                  fontColor: AppColors.black,
                  fontSize: 12.sp,
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
                          SizedBox(height: 5),
                          Text(
                            'Booked',
                            style: AppTextstyle.propertyMediumTextstyle(
                              context,
                              fontColor: AppColors.black,
                            ),
                          ),
                          SizedBox(height: 5),

                          bookedcountAsync.when(
                            data: (count) => Text(
                              '$count',
                              style: AppTextstyle.propertyLargeTextstyle(
                                context,
                                fontColor: AppColors.greenColor,
                              ),
                            ),
                            loading: () => const Text("..........."),
                            error: (e, s) => Text(
                              "0",
                              style: AppTextstyle.propertyLargeTextstyle(
                                context,
                                fontColor: AppColors.redcolor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(8.w)),
                ContainerWidget(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(AssetResource.vacant),
                        SizedBox(height: 5),
                        Text(
                          'vacant',
                          style: AppTextstyle.propertyMediumTextstyle(
                            context,
                            fontColor: AppColors.black,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '$vacant',
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
                      padding: const EdgeInsets.only(left: 100),
                      child: propertyCountAsync.when(
                        data: (count) => Text(
                          "$count",
                          style: AppTextstyle.propertyLargeTextstyle(
                            context,
                            fontColor: AppColors.yellowcolor,
                          ),
                        ),
                        loading: () => CircularProgressIndicator(),
                        error: (e, s) => Text(
                          "0",
                          style: AppTextstyle.propertyLargeTextstyle(
                            context,
                            fontColor: AppColors.redcolor,
                          ),
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
              child: bookedAsync.when(
                data: (bookedList) {
                  if (bookedList.isEmpty) {
                    return const Center(child: Text("No bookings available"));
                  }

                  return ListView.builder(
                    itemCount: bookedList.length,
                    itemBuilder: (context, index) {
                      final booking = bookedList[index];

                      final propertyAsync = ref.watch(
                        propertyByIdProvider(booking.propertyId),
                      );

                      return propertyAsync.when(
                        data: (property) {
                          if (property == null) return SizedBox.shrink();

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BookingConatainerWidget(
                              bookedProperty: booking,
                              property: property,
                            ),
                          );
                        },
                        loading: () => SizedBox(),
                        error: (e, s) => Text("Error loading property"),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, s) => Center(child: Text("Error loading bookings")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
