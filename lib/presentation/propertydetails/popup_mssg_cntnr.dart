import 'package:flutter/material.dart';


  void showLandlordPopup(BuildContext context) {
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
                children: const [
                  Icon(Icons.person_outline, color: Colors.teal),
                  SizedBox(width: 8),
                  Text(
                    'Hrishilal',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Mobile
              Row(
                children: const [
                  Icon(Icons.phone_outlined, color: Colors.teal),
                  SizedBox(width: 8),
                  Text(
                    '+91 9605922260',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Email
              Row(
                children: const [
                  Icon(Icons.email_outlined, color: Colors.teal),
                  SizedBox(width: 8),
                  Text(
                    'Hrishilal@gmail.com',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Date
              Row(
                children: const [
                  Icon(Icons.calendar_today_outlined, color: Colors.teal),
                  SizedBox(width: 8),
                  Text(
                    '2-3-2025',
                    style: TextStyle(fontSize: 16),
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

 