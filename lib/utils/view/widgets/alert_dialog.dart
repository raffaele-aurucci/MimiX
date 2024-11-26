import 'package:flutter/material.dart';
import 'package:mimix_app/utils/view/app_palette.dart';

class DialogUtils {

  static void showErrorDialog({required BuildContext context, required String title,
    required String message}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
        title: Text(
            title,
            style: const TextStyle(
              color: PaletteColor.darkBlue,
              fontWeight: FontWeight.w500,),
        ),
        content: Text(
            message,
            style: const TextStyle(
              color: PaletteColor.darkBlue,
            ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // close dialog
            },
            child: const Text(
                "OK",
                style: TextStyle(
                    color: PaletteColor.darkBlue,
                    fontWeight: FontWeight.w500),
            ),
          ),
        ],
      );
      },
    );
  }
}