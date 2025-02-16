import 'package:flutter/material.dart';
import 'package:mimix_app/utils/view/app_palette.dart';

class DialogUtils {

  static void showErrorDialog({
    required BuildContext context,
    required String title,
    required String message,
    VoidCallback? onTap,
    required String buttonMessage,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return PopScope(
            canPop: false,
            child:AlertDialog(
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
                onPressed: onTap ?? () {
                  Navigator.of(context).pop(); // close dialog
                },
                child: Text(
                  buttonMessage,
                  style: const TextStyle(
                      color: PaletteColor.darkBlue,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          )
        );
      },
    );
  }
}