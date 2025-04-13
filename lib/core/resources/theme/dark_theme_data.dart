import 'package:flutter/material.dart';

import '../color_manager.dart';
import '../font_manager.dart';
import '../style_manager.dart';
import '../values_manager.dart';

ThemeData getDarkTheme() {
  return ThemeData(
    // Main color
    scaffoldBackgroundColor: ColorManager.simiBlack,
    primaryColor: ColorManager.darkModePrimary,
    primaryColorLight: ColorManager.lightGrey,
    primaryColorDark: ColorManager.black,
    disabledColor: ColorManager.grey2,
    splashColor: ColorManager.darkGrey,

    // Color scheme
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: ColorManager.darkModePrimary,
      onPrimary: ColorManager.lightPrimary,
      secondary: ColorManager.lightGreen,
      onSecondary: ColorManager.darkGrey,
      error: ColorManager.textFormErrorBorder,
      onError: ColorManager.textFormErrorBorder,
      surface: ColorManager.simiBlack,
      onSurface: ColorManager.white,
    ),

    // Card theme
    cardTheme: CardTheme(
      color: ColorManager.darkGrey,
      elevation: AppSize.s4,
      shadowColor: ColorManager.grey2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s12),
      ),
    ),

    // AppBar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: AppSize.s4,
      color: ColorManager.black,
      shadowColor: ColorManager.darkModePrimary,
      titleTextStyle: getBoldStyle(
        fontSize: FontSize.s28,
        color: ColorManager.black,
      ),
    ),

    // Button theme
    buttonTheme: ButtonThemeData(
      shape: StadiumBorder(
          side: BorderSide(
              color: ColorManager.lightGreen,
              width: AppSize.s1_5,
              style: BorderStyle.solid)),
      disabledColor: ColorManager.grey2,
      buttonColor: ColorManager.darkGreen,
      splashColor: ColorManager.lightGreen,
    ),

    // Outlined button theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: ColorManager.lightGreen,
            width: 2,
            style: BorderStyle.solid,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s15),
          )),
    ),

    // Elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle:
            getBoldStyle(color: ColorManager.white, fontSize: FontSize.s20),
        backgroundColor: ColorManager.primary,
        foregroundColor: ColorManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppSize.s15,
          ),
        ),
      ),
    ),

    // Text button theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle:
            getRegularStyle(fontSize: FontSize.s14, color: ColorManager.white)
                .copyWith(
          fontFamily: 'Montserrat',
        ),
      ),
    ),

    // Text theme
    textTheme: TextTheme(
      displayLarge: getLightStyle(
        color: ColorManager.white,
        fontSize: FontSize.s22,
      ),
      headlineLarge: getMediumStyle(
        color: ColorManager.white,
        fontSize: FontSize.s20,
      ),
      headlineMedium: getRegularStyle(
        color: ColorManager.grey2,
        fontSize: FontSize.s14,
      ),
      bodyLarge: getRegularStyle(
        color: ColorManager.lightGreen,
        fontSize: FontSize.s14,
      ),
      bodySmall: getLightStyle(
        color: ColorManager.grey1,
        fontSize: FontSize.s16,
      ),
      labelSmall: getRegularStyle(
        color: ColorManager.grey2,
        fontSize: FontSize.s14,
      ),
      labelMedium: getMediumStyle(
        color: ColorManager.white,
        fontSize: FontSize.s18,
      ),
      labelLarge: getBoldStyle(
        color: ColorManager.white,
        fontSize: FontSize.s24,
      ),
      displayMedium: getBoldStyle(
        color: ColorManager.white,
        fontSize: FontSize.s25,
      ),
      titleLarge: getMediumStyle(
        color: ColorManager.white,
        fontSize: FontSize.s48,
      ),
      titleMedium: getRegularStyle(
        fontSize: FontSize.s16,
        color: ColorManager.white,
      ),
    ),

    // Input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(
        AppPadding.p20,
      ),
      errorStyle: getRegularStyle(
        fontSize: FontSize.s12,
        color: ColorManager.red,
      ),
      hintStyle: getRegularStyle(
        color: ColorManager.grey3,
        fontSize: FontSize.s14,
      ),
      labelStyle: getMediumStyle(
        color: ColorManager.grey,
        fontSize: FontSize.s14,
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppSize.s12,
        ),
        borderSide: BorderSide(color: ColorManager.darkGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.darkGrey),
        borderRadius: BorderRadius.circular(
          AppSize.s12,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppSize.s12,
        ),
        borderSide: BorderSide(
          color: ColorManager.darkGrey,
          width: AppSize.s1_5,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppSize.s12,
        ),
        borderSide: BorderSide(color: ColorManager.grey1),
      ),
      fillColor: ColorManager.darkGrey.withOpacity(.2),
      filled: true,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorManager.white,
      selectionColor: ColorManager.black,
      selectionHandleColor: ColorManager.darkModePrimary,
    ),

    // ListTile theme
    listTileTheme: ListTileThemeData(
      iconColor: ColorManager.white,
      textColor: ColorManager.white,
      tileColor: ColorManager.black,
      contentPadding:
          const EdgeInsets.only(left: AppPadding.p12, right: AppPadding.p8),
    ),
  );
}
