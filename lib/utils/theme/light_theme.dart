import 'package:flutter/material.dart';
import 'package:pharma_clients_app/resources/app_colors.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        background: AppColors.backgroundColor,
        primary: AppColors.primaryColor,
        secondary: Colors.white
    )
);