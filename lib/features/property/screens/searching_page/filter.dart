import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:property_managment/core/constant/app_colors.dart';
import 'package:property_managment/core/utils/bottom_navigation_bar.dart';
import 'package:property_managment/features/property/controllers/property_cntlr.dart';
import 'package:property_managment/modelClass/property_model.dart';
import 'dart:developer';

class FilterSortPage extends ConsumerStatefulWidget {
  int initialIndex;
  FilterSortPage({super.key, required this.initialIndex});

  @override
  ConsumerState<FilterSortPage> createState() => _FilterSortPageState();
}

class _FilterSortPageState extends ConsumerState<FilterSortPage> {
  FirebaseFirestore fdb = FirebaseFirestore.instance;

  // late int selectedIndex;
  RangeValues priceRange = const RangeValues(1000, 1000000);
  RangeValues sqftRange = const RangeValues(100, 50000);

  // 🔹 Keep all property types initially false
  Map<String, bool> propertyTypes = {
    'Apartment': false,
    'Villa': false,
    'Land': false,
  };

  // 🔹 List to store selected property types
  List<String> selectedproperty = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Filters & Sort",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 1,
        foregroundColor: AppColors.black,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavigationWidget(
                  currentIndex: 1,
                  price: null,
                  propertytype: [],
                  sqft: null,
                  // loginUser: null,
                ),
              ),
            );
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Row(
          children: [
            // Left Menu
            Container(
              width: 130,
              color: AppColors.white,
              child: ListView(
                children: [
                  buildMenuItem("Property Type", 0),
                  buildMenuItem("Price", 1),

                  buildMenuItem("Area Sqft", 2),
                ],
              ),
            ),

            // Right Content
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: getFilterContent(),
                    ),
                  ),

                  // Buttons
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 20,
                      top: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // 🔹 CLEAR BUTTON
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // setState(() {
                              // Reset all filters
                              propertyTypes.updateAll((key, value) => false);
                              priceRange = const RangeValues(1000, 100000);
                              sqftRange = const RangeValues(100, 50000);
                              selectedproperty.clear(); // clear list too
                              ref.read(typeFilterProvider.notifier).state =
                                  null;
                              ref.read(priceFilterProvider.notifier).state =
                                  null;
                              ref.read(sqftFilterProvider.notifier).state =
                                  null;

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Filters cleared successfully!',
                                  ),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade300,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              minimumSize: const Size(double.infinity, 48),
                            ),
                            child: const Text(
                              "Clear",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // 🔹 APPLY BUTTON
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              selectedproperty.clear();

                              // Collect selected property types
                              propertyTypes.forEach((key, value) {
                                if (value == true) {
                                  selectedproperty.add(key.toUpperCase());
                                }
                              });

                              // ---- VALIDATION ----
                              if (selectedproperty.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Please select at least one property type!',
                                    ),
                                  ),
                                );
                                return;
                              }

                              // ---- SAVE FILTERS INTO RIVERPOD ----

                              // TYPE FILTER
                              ref.read(typeFilterProvider.notifier).state =
                                  selectedproperty;

                              // PRICE FILTER
                              ref.read(priceFilterProvider.notifier).state =
                                  priceRange;

                              // SQFT FILTER
                              ref.read(sqftFilterProvider.notifier).state =
                                  sqftRange;

                              Navigator.pop(context);
                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.greenColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              minimumSize: const Size(double.infinity, 48),
                            ),
                            child: const Text(
                              "Apply",
                              style: TextStyle(color: AppColors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Left-side Menu Builder
  Widget buildMenuItem(String title, int index) {
    bool selected = widget.initialIndex == index;
    return InkWell(
      onTap: () => setState(() => widget.initialIndex = index),
      child: Container(
        color: selected ? AppColors.greenColor : Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        child: Text(
          title,
          style: TextStyle(
            color: selected ? AppColors.white : AppColors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // 🔹 Filter Options
  Widget getFilterContent() {
    log("getFilterContent  ${widget.initialIndex}");
    switch (widget.initialIndex) {
      case 0:
        return ListView(
          children: propertyTypes.keys.map((type) {
            return CheckboxListTile(
              title: Text(
                type,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              value: propertyTypes[type],
              onChanged: (value) {
                setState(() {
                  propertyTypes[type] = value!;
                });
              },
            );
          }).toList(),
        );

      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Price Range (₹)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            RangeSlider(
              values: priceRange,
              min: 1000,
              max: 1000000,
              divisions: 10,
              labels: RangeLabels(
                "₹${priceRange.start.toInt()}",
                "₹${priceRange.end.toInt()}+",
              ),
              onChanged: (values) {
                setState(() {
                  priceRange = values;
                });
              },
            ),
          ],
        );

      // case 2:
      //   return const Center(
      //     child: Text(
      //       "Price per Sqft filter coming soon...",
      //       style: TextStyle(fontSize: 16),
      //     ),
      //   );

      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choose a range below (sq ft)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            RangeSlider(
              values: sqftRange,
              min: 100,
              max: 50000,
              divisions: 10,
              labels: RangeLabels(
                sqftRange.start.toInt().toString(),
                "${sqftRange.end.toInt()}+",
              ),
              onChanged: (values) {
                setState(() {
                  sqftRange = values;
                });
              },
            ),
          ],
        );

      default:
        return const SizedBox();
    }
  }
}
