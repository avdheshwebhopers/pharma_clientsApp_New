import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharma_clients_app/resources/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Button extends StatelessWidget {
  Button({
    this.onPress, @required this.title,
    required this.loading,
    Key? key}) : super(key: key);

  dynamic onPress;
  dynamic title;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            minimumSize: Size(MediaQuery.of(context).size.width / 3,
                MediaQuery.of(context).size.height / 15),
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(2.h)))),
        child: loading
            ? const CircularProgressIndicator(color: Colors.white,)
            : Text(
          title,
          style: GoogleFonts.workSans(
              color: Colors.white,
              textStyle: Theme.of(context).textTheme.bodyMedium,
              fontSize: 18.sp,
              fontWeight: FontWeight.w400),
        )
    );
  }
}
