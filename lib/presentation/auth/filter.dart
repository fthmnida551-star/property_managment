import 'package:flutter/material.dart';
import 'package:property_managment/core/theme/app_colors.dart';

class FilterSortPage extends StatefulWidget {
  const FilterSortPage({super.key});

  @override
  State<FilterSortPage> createState() => _FilterSortPageState();
}

class _FilterSortPageState extends State<FilterSortPage> {
  int selectedIndex = 0;
  RangeValues priceRange = const RangeValues(1000, 10000);
  RangeValues sqftRange = const RangeValues(500, 5000);

  Map<String, bool> propertyTypes = {
    'Apartment': false,
    'Villa': false,
    'Plot': false,
    'Commercial': false,
  };

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
        foregroundColor:AppColors.black,
      ),
      body: SafeArea( // ✅ Prevents bottom overflow
        child: Row(
          children: [
            // Left Side Menu
            Container(
              width: 130,
              color:AppColors.greyColor,
              child: ListView(
                children: [
                  buildMenuItem("Property Type", 0),
                  buildMenuItem("Price", 1),
                  buildMenuItem("Price per Sqft", 2),
                  buildMenuItem("Area Sqft", 3),
                ],
              ),
            ),

            // Right Side Content
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: getFilterContent(),
                    ),
                  ),

                  // Buttons Section
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, bottom: 20, top: 10), // ✅ Space above nav bar
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                propertyTypes.updateAll((key, value) => false);
                                priceRange = const RangeValues(1000, 10000);
                                sqftRange = const RangeValues(500, 5000);
                              });
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
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
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

  Widget buildMenuItem(String title, int index) {
    bool selected = selectedIndex == index;
    return InkWell(
      onTap: () => setState(() => selectedIndex = index),
      child: Container(
        color: selected ? Colors.green.shade700 : Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        child: Text(
          title,
          style: TextStyle(
            color: selected ?AppColors.white :AppColors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget getFilterContent() {
    switch (selectedIndex) {
      case 0:
        return ListView(
          children: propertyTypes.keys.map((type) {
            return CheckboxListTile(
              title: Text(
                type,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
            const Text("Select Price Range (₹)",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            RangeSlider(
              values: priceRange,
              min: 1000,
              max: 10000,
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

      case 2:
        return const Center(
          child: Text(
            "Price per Sqft filter coming soon...",
            style: TextStyle(fontSize: 16),
          ),
        );

      case 3:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Choose a range below (sq ft)",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            RangeSlider(
              values: sqftRange,
              min: 500,
              max: 10000,
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