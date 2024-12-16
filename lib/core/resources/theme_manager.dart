import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'style_manager.dart';
import 'values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    //main color
    scaffoldBackgroundColor: ColorManager.white,
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.lightPrimary,

    //color
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: ColorManager.primary,
      onPrimary: ColorManager.lightPrimary,
      secondary: ColorManager.darkPrimary,
      onSecondary: ColorManager.lightPrimary,
      error: ColorManager.textFormErrorBorder,
      onError: ColorManager.textFormErrorBorder,
      surface: ColorManager.white,
      onSurface: ColorManager.simiBlack,
    ),
    //cardView theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      elevation: AppSize.s4,
      shadowColor: ColorManager.grey1,
    ),
    //appBar Theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: AppSize.s4,
      color: ColorManager.darkPrimary,
      shadowColor: ColorManager.lightPrimary,
      titleTextStyle: getBoldStyle(
        fontSize: FontSize.s28,
        color: ColorManager.white,
      ),
    ),
    // button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.white,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(
        color: ColorManager.primary,
      ),
      unselectedItemColor: ColorManager.grey1,
      selectedItemColor: ColorManager.primary,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: getMediumStyle(
        fontSize: FontSize.s12,
        color: ColorManager.primary,
      ),
      unselectedLabelStyle: getMediumStyle(
        fontSize: FontSize.s12,
        color: ColorManager.grey1,
      ),
    ),
    // elevated button them
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
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle:
        getRegularStyle(
            fontSize: FontSize.s14, color: ColorManager.primary)
            .copyWith(
          fontFamily: 'Montserrat',
        ),
      ),
    ),
    //text theme
    textTheme: TextTheme(
      displayLarge: getLightStyle(
        color: ColorManager.white,
        fontSize: FontSize.s22,
      ),
      // use in title for pages
      headlineLarge: getMediumStyle(
        color: ColorManager.simiBlack,
        fontSize: FontSize.s20,
      ),
      // used in sub title for pages
      headlineMedium: getRegularStyle(
        color: ColorManager.simiBlue,
        fontSize: FontSize.s14,
      ),

      bodyLarge: getRegularStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s14,
      ),
      // used in google and facebook buttons
      bodySmall: getLightStyle(
        color: ColorManager.grey1,
        fontSize: FontSize.s16,
      ),
      labelSmall: getRegularStyle(
        color: ColorManager.simiBlue,
        fontSize: FontSize.s14,
      ),
      labelMedium: getMediumStyle(
        color: ColorManager.simiBlack,
        fontSize: FontSize.s18,
      ),
      labelLarge: getBoldStyle(
        color: ColorManager.simiBlack,
        fontSize: FontSize.s24,
      ),
      displayMedium: getBoldStyle(
        color: ColorManager.white,
        fontSize: FontSize.s25,
      ),
      titleLarge: getMediumStyle(
        color: ColorManager.simiBlack,
        fontSize: FontSize.s48,
      ),
      titleMedium: getRegularStyle(
        fontSize: FontSize.s16,
        color: ColorManager.simiBlack,
      ),
    ),
    //input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      //content padding
      contentPadding: const EdgeInsets.all(
        AppPadding.p20,
      ),
      //error style
      errorStyle: getRegularStyle(
        fontSize: FontSize.s12,
        color: ColorManager.textFormErrorBorder,
      ),

      //hint style
      hintStyle: getRegularStyle(
        color: ColorManager.grey1,
        fontSize: FontSize.s14,
      ),
      //label style
      labelStyle: getMediumStyle(
        color: ColorManager.grey1,
        fontSize: FontSize.s14,
      ),
      fillColor: ColorManager.textFormBackground,
      filled: true,
      //enable border style
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.textFormBorder,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(
          AppSize.s12,
        ),
      ),

      //focused Border style
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppSize.s12,

        ),
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
      ),

      //error border style
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppSize.s12,
        ),
        borderSide: const BorderSide(
          color: ColorManager.textFormErrorBorder,
          width: AppSize.s1_5,
        ),
      ),

      //focused error border style
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          AppSize.s12,
        ),
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
      ),
    ),
  );
}
