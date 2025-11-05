import 'package:flutter/material.dart';
import 'package:property_managment/modelClass/property_model.dart';

void showLandlordPopup(BuildContext context, PropertyModel property) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Landlord',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Name
            Row(
              children: [
                const Icon(Icons.person_outline, color: Colors.teal),
                const SizedBox(width: 8),
                Text(
                  property.ownername, // ✅ Using property data
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Property Type (Optional)
            Row(
              children: [
                const Icon(Icons.home_outlined, color: Colors.teal),
                const SizedBox(width: 8),
                Text(
                  property.propertyType,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Mobile
            Row(
              children: [
                const Icon(Icons.phone_outlined, color: Colors.teal),
                const SizedBox(width: 8),
                Text(
                  property.contact,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Email
            Row(
              children: [
                const Icon(Icons.email_outlined, color: Colors.teal),
                const SizedBox(width: 8),
                Text(
                  property.email,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),

           
          ],
        ),
      ),
    ),
  );
}
