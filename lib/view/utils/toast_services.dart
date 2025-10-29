import 'package:flutter/material.dart';
import 'package:flutter_task_app/view/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ToastServices {
  static final ToastServices _singleton = ToastServices._internal();

  final GlobalKey<NavigatorState> globalKey = GlobalKey();

  factory ToastServices() {
    return _singleton;
  }
  ToastServices._internal();

  showSuccess(String? msg, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        msg ?? '',
        style: GoogleFonts.poppins(color: AppColors.appBackgroundColor),
      ),
      backgroundColor: AppColors.greenTextColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  showError(String? msg, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        msg ?? '',
        style: GoogleFonts.poppins(color: AppColors.appBackgroundColor),
      ),
      backgroundColor: AppColors.redTextColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
