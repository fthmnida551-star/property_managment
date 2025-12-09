import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:property_managment/features/home/controller/dashboard_controller.dart';

void showThemePop(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Consumer(
        builder: (context, ref, child) {
          final themeMode = ref.watch(themeProvider);

          return AlertDialog(
            title: const Text("Choose Theme"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<ThemeMode>(
                  title: const Text("Light Mode"),
                  value: ThemeMode.light,
                  groupValue: themeMode,
                  onChanged: (value) {
                    ref.read(themeProvider.notifier).state = ThemeMode.light;
                    Navigator.pop(context);
                  },
                ),
                RadioListTile<ThemeMode>(
                  title: const Text("Dark Mode"),
                  value: ThemeMode.dark,
                  groupValue: themeMode,
                  onChanged: (value) {
                    ref.read(themeProvider.notifier).state = ThemeMode.dark;
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
      );
    },
  );
}


