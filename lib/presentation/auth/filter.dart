import 'package:flutter/material.dart';
import 'package:property_managment/core/theme/app_colors.dart';
import 'package:property_managment/core/theme/app_textstyl.dart';

import 'package:property_managment/widget/checkbox.dart';

class FilterSortPage extends StatefulWidget {
  const FilterSortPage({super.key});

  @override
  State<FilterSortPage> createState() => _FilterSortPageState();
}

class _FilterSortPageState extends State<FilterSortPage> {
  int selectedIndex = 0;

  // Range values
  RangeValues _priceRange = const RangeValues(1000, 50000);
  RangeValues _pricePerSqftRange = const RangeValues(200, 1500);
  RangeValues _areaRange = const RangeValues(500, 5000);

  // Checkbox values
  bool apartment = false;
  bool villa = false;
  bool house = false;

  final List<String> filterItems = [
    'Property Type',
    'Price',
    'Price per Sqft',
    'Area Sqft',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Row(
          children: [
            // Left Filter Menu
            Container(
              width: 120,
              color: AppColors.propertyContainer,
              child: ListView.builder(
                itemCount: filterItems.length,
                itemBuilder: (context, index) {
                  bool isSelected = index == selectedIndex;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.white : AppColors.propertyContainer,
                        border: Border(
                          right: BorderSide(
                            color: isSelected ? AppColors.greenColor : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Text(
                        filterItems[index],
                        style: AppTextstyle.propertysmallTextstyle(
                          context,
                          fontColor: AppColors.black,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Right Content Area
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                color: AppColors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Filters & Sort',
                          style: AppTextstyle.propertyLargeTextstyle(
                            context,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Icon(Icons.close),
                      ],
                    ),
                    const SizedBox(height: 25),

                    // Property Type Section
                    if (selectedIndex == 0) ...[
                      Text(
                        'Select Property Type',
                        style: AppTextstyle.propertyMediumTextstyle(
                          context,
                          fontColor: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CheckboxWithListenable(
                        text: 'Apartment',
                        value: apartment,
                        onChanged: (val) {
                          setState(() {
                            apartment = val ?? false;
                          });
                        },
                      ),
                      CheckboxWithListenable(
                        text: 'Villa',
                        value: villa,
                        onChanged: (val) {
                          setState(() {
                            villa = val ?? false;
                          });
                        },
                      ),
                      CheckboxWithListenable(
                        text: 'House',
                        value: house,
                        onChanged: (val) {
                          setState(() {
                            house = val ?? false;
                          });
                        },
                      ),
                    ],

                    // Price Section
                    if (selectedIndex == 1) ...[
                      Text(
                        'Select Price Range',
                        style: AppTextstyle.propertyMediumTextstyle(
                          context,
                          fontColor: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      RangeSlider(
                        values: _priceRange,
                        min: 0,
                        max: 100000,
                        divisions: 10,
                        activeColor: AppColors.greenColor,
                        inactiveColor: AppColors.opacitygreyColor,
                        labels: RangeLabels(
                          '₹${_priceRange.start.toStringAsFixed(0)}',
                          '₹${_priceRange.end.toStringAsFixed(0)}',
                        ),
                        onChanged: (values) {
                          setState(() {
                            _priceRange = values;
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('₹0', style: AppTextstyle.propertysmallTextstyle(context)),
                          Text('₹100000+', style: AppTextstyle.propertysmallTextstyle(context)),
                        ],
                      ),
                    ],

                    // Price Per Sqft Section
                    if (selectedIndex == 2) ...[
                      Text(
                        'Price per Sqft',
                        style: AppTextstyle.propertyMediumTextstyle(
                          context,
                          fontColor: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      RangeSlider(
                        values: _pricePerSqftRange,
                        min: 0,
                        max: 3000,
                        divisions: 15,
                        activeColor: AppColors.greenColor,
                        inactiveColor: AppColors.opacitygreyColor,
                        labels: RangeLabels(
                          '₹${_pricePerSqftRange.start.toStringAsFixed(0)}',
                          '₹${_pricePerSqftRange.end.toStringAsFixed(0)}',
                        ),
                        onChanged: (values) {
                          setState(() {
                            _pricePerSqftRange = values;
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('₹0', style: AppTextstyle.propertysmallTextstyle(context)),
                          Text('₹3000+', style: AppTextstyle.propertysmallTextstyle(context)),
                        ],
                      ),
                    ],

                    // Area Sqft Section
                    if (selectedIndex == 3) ...[
                      Text(
                        'Select Area Range (Sqft)',
                        style: AppTextstyle.propertyMediumTextstyle(
                          context,
                          fontColor: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      RangeSlider(
                        values: _areaRange,
                        min: 0,
                        max: 10000,
                        divisions: 10,
                        activeColor: AppColors.greenColor,
                        inactiveColor: AppColors.opacitygreyColor,
                        labels: RangeLabels(
                          '${_areaRange.start.toStringAsFixed(0)}',
                          '${_areaRange.end.toStringAsFixed(0)}+',
                        ),
                        onChanged: (values) {
                          setState(() {
                            _areaRange = values;
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('0 sqft', style: AppTextstyle.propertysmallTextstyle(context)),
                          Text('10000+ sqft', style: AppTextstyle.propertysmallTextstyle(context)),
                        ],
                      ),
                    ],

                    const Spacer(),

                    // Bottom Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                apartment = false;
                                villa = false;
                                house = false;
                                _priceRange = const RangeValues(1000, 50000);
                                _pricePerSqftRange = const RangeValues(200, 1500);
                                _areaRange = const RangeValues(500, 5000);
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.opacitygreyColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Clear All',
                              style: AppTextstyle.propertyMediumTextstyle(
                                context,
                                fontColor: AppColors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Apply filters logic here
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.greenColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Apply',
                              style: AppTextstyle.propertyMediumTextstyle(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
