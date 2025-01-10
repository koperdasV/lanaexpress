import 'package:flutter/material.dart';
import 'package:lanaexpress/constants/colors.dart';
import 'package:lanaexpress/constants/dimens.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: whiteColor,
  scaffoldBackgroundColor: background,
  dialogBackgroundColor: background,
  appBarTheme: const AppBarTheme(
    backgroundColor: background,
    elevation: 0,
    scrolledUnderElevation: 0,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: mainPrimaryColor,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: dark,
    unselectedItemColor: dark,
    selectedLabelStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  ),
  dropdownMenuTheme: const DropdownMenuThemeData(
    menuStyle: MenuStyle(
      backgroundColor: MaterialStatePropertyAll(whiteColor),
    ),
    textStyle: TextStyle(
      color: dark,
      fontSize: 18,
      fontWeight: FontWeight.w400,
    ),
  ),
  menuButtonTheme: const MenuButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStatePropertyAll(
        TextStyle(
          color: dark,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  ),
  tabBarTheme: const TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    dividerColor: Colors.transparent,
    labelStyle: TextStyle(
      color: whiteColor,
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
    unselectedLabelStyle: TextStyle(
      color: whiteColor,
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
    labelColor: whiteColor,
    unselectedLabelColor: whiteColor,
    indicator: BoxDecoration(
      borderRadius: AppBordersRadius.borderRadiusAllXS,
      color: mainPrimaryColor,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: AppBordersRadius.borderRadiusAllXS,
      borderSide: BorderSide(
        color: backgroundBorder,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: AppBordersRadius.borderRadiusAllXS,
      borderSide: BorderSide(
        color: backgroundBorder,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: AppBordersRadius.borderRadiusAllXS,
      borderSide: BorderSide(
        color: focusedBorder,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: AppBordersRadius.borderRadiusAllXS,
      borderSide: BorderSide(
        color: errorBorder,
      ),
    ),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w700,
      color: dark,
    ),
    displayMedium: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w500,
      color: dark,
      letterSpacing: -0.25,
    ),
    displaySmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: whiteColor,
      letterSpacing: -0.25,
    ),
    titleLarge: TextStyle(
      color: dark,
      fontSize: 18,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      color: dark,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      color: grey,
      fontSize: 15,
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: grey,
    ),
    labelMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: mainPrimaryColor,
    ),
    labelLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: dark,
    ),
    headlineSmall: TextStyle(
      color: dark,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    headlineMedium: TextStyle(
      color: dark,
      fontSize: 24,
      fontWeight: FontWeight.w500,
    ),
    headlineLarge: TextStyle(
      color: dark,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
  ),
);

// final ThemeData darkTheme = ThemeData(
//   //   timePickerTheme: TimePickerThemeData(
//   //   backgroundColor: ThemeData.dark().copyWith(colorScheme: const ColorScheme.dark(primary: containerBackgroundColor )).primaryColor,
//   // ),
//   // brightness: Brightness.dark,
//   // splashColor: colorAccentDark,
//   // dividerColor: transparentColor,
//   // primaryColor: backgroundColor.withOpacity(0.5),
//   // cardColor: containerBackgroundColor,
//   // appBarTheme: const AppBarTheme(
//   //   color: backgroundColor,
//   //   iconTheme: IconThemeData(color: whiteColor),
//   //   ),
//   //   colorScheme: const ColorScheme(
//   //     brightness: Brightness.dark,
//   //     primary: containerBackgroundColor,
//   //     onPrimary: whiteColor,
//   //     secondary: colorAccentDark,
//   //     onSecondary: containerBackgroundColor,
//   //     error: colorAccentDark,
//   //     onError: containerBackgroundColor,
//   //     background: containerBackgroundColor,
//   //     onBackground: blackColor,
//   //     surface: containerBackgroundColor,
//   //     onSurface: blackColor,
//   //     tertiaryContainer: gray500,
//   // ),
//   bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//     selectedItemColor: whiteColor,
//     selectedLabelStyle: TextStyle(
//       //fontFamily: mainFontFamily,
//       fontSize: 10,
//       fontWeight: FontWeight.w600,
//     ),
//     unselectedLabelStyle: TextStyle(
//       //fontFamily: mainFontFamily,
//       fontSize: 10,
//       fontWeight: FontWeight.w600,
//     ),
//   ),
//   // cupertinoOverrideTheme: const CupertinoThemeData(
//   //   primaryColor: colorAccent,
//   //   textTheme: CupertinoTextThemeData(
//   //     primaryColor: colorAccent,
//   //   ),
//   // ),
//   // textSelectionTheme: TextSelectionThemeData(
//   //   cursorColor: colorAccent,
//   //   selectionColor: colorAccent.withOpacity(.3),
//   //   selectionHandleColor: colorAccent,
//   // ),
//   // navigationRailTheme: const NavigationRailThemeData(
//   //   unselectedLabelTextStyle: TextStyle(
//   //     overflow: TextOverflow.fade,
//   //     //fontFamily: mainFontFamily,
//   //     fontSize: 14,
//   //     fontWeight: FontWeight.w700,
//   //     color: gray300,
//   //   ),
//   //   selectedLabelTextStyle: TextStyle(
//   //     overflow: TextOverflow.fade,
//   //     //fontFamily: mainFontFamily,
//   //     fontSize: 15,
//   //     fontWeight: FontWeight.w700,
//   //     color: grey1,
//   //   ),
//   // ),
//   // tabBarTheme: const TabBarTheme(
//   //   labelStyle: TextStyle(
//   //     color: grey1,
//   //     overflow: TextOverflow.ellipsis,
//   //     fontWeight: FontWeight.bold,
//   //     fontSize: 14,
//   //     //fontFamily: mainFontFamily,
//   //   ),
//   //   unselectedLabelStyle: TextStyle(
//   //     overflow: TextOverflow.ellipsis,
//   //     color: grey1,
//   //     fontWeight: FontWeight.bold,
//   //     fontSize: 14,
//   //     //fontFamily: mainFontFamily,
//   //   ),
//   //   labelColor: whiteColor,
//   //   unselectedLabelColor: whiteColor,
//   //   // indicator: BoxDecoration(
//   //   //   borderRadius: BorderRadius.all(Radius.circular(4)),
//   //   //   color: colorAccent,
//   //   // ),
//   // ),
//   // canvasColor: backgroundColor,
//   //fontFamily: mainFontFamily,
//   // floatingActionButtonTheme: const FloatingActionButtonThemeData(
//   //   splashColor: colorAccentDark,
//   //   backgroundColor: backgroundColor,
//   // ),
//   inputDecorationTheme: const InputDecorationTheme(
//     hintStyle: TextStyle(
//       //fontFamily: mainFontFamily,
//       color: whiteColor,
//       fontWeight: FontWeight.w400,
//       fontSize: 14,
//       letterSpacing: -0.15,
//     ),
//     helperStyle: TextStyle(
//       //fontFamily: mainFontFamily,
//       color: whiteColor,
//       fontWeight: FontWeight.w400,
//       fontSize: 12,
//       letterSpacing: -0.15,
//     ),
//     labelStyle: TextStyle(
//       //fontFamily: mainFontFamily,
//       color: whiteColor,
//       fontWeight: FontWeight.w400,
//       fontSize: 14,
//       letterSpacing: -0.15,
//     ),
//     counterStyle: TextStyle(
//       //fontFamily: mainFontFamily,
//       color: grey,
//       fontWeight: FontWeight.w400,
//       fontSize: 14,
//       letterSpacing: -0.15,
//     ),
//     prefixStyle: TextStyle(
//       //fontFamily: mainFontFamily,
//       fontSize: 14,
//       fontWeight: FontWeight.w400,
//       color: whiteColor,
//       letterSpacing: -0.15,
//     ),
//   ),
//   buttonTheme: const ButtonThemeData(
//     buttonColor: mainPrimaryColor,
//     // disabledColor: backgroundColor,
//     // splashColor: colorAccentDark,
//   ),
//   //iconTheme: const IconThemeData(color: gray400),
//   textTheme: const TextTheme(
//     displayLarge: TextStyle(
//       //fontFamily: mainFontFamily,
//       fontSize: 22,
//       fontWeight: FontWeight.w700,
//       letterSpacing: -0.5,
//       color: whiteColor,
//     ),
//     displayMedium: TextStyle(
//       //fontFamily: mainFontFamily,
//       fontSize: 18,
//       fontWeight: FontWeight.w700,
//       color: whiteColor,
//       letterSpacing: -0.25,
//     ),
//     displaySmall: TextStyle(
//       //fontFamily: mainFontFamily,
//       fontSize: 18,
//       fontWeight: FontWeight.w400,
//       color: whiteColor,
//       letterSpacing: -0.15,
//     ),
//     headlineMedium: TextStyle(
//       //fontFamily: mainFontFamily,
//       fontWeight: FontWeight.w700,
//       letterSpacing: -0.25,
//       fontSize: 14,
//       color: whiteColor,
//     ),
//     headlineSmall: TextStyle(
//       //fontFamily: mainFontFamily,
//       fontWeight: FontWeight.w400,
//       fontSize: 14,
//       color: whiteColor,
//       letterSpacing: -0.25,
//     ),
//     titleMedium: TextStyle(
//       //fontFamily: mainFontFamily,
//       color: whiteColor,
//       fontSize: 14,
//       letterSpacing: -0.2,
//       fontWeight: FontWeight.w500,
//     ),
//     titleSmall: TextStyle(
//       //fontFamily: mainFontFamily,
//       fontWeight: FontWeight.w400,
//       fontSize: 14,
//       letterSpacing: -0.15,
//       color: whiteColor,
//     ),
//     labelLarge: TextStyle(
//       //fontFamily: mainFontFamily,
//       fontWeight: FontWeight.w700,
//       fontSize: 14,
//       color: whiteColor,
//       letterSpacing: 0.3,
//     ),
//     bodySmall: TextStyle(
//       //fontFamily: mainFontFamily,
//       fontWeight: FontWeight.w400,
//       fontSize: 12,
//       letterSpacing: -0.15,
//       color: whiteColor,
//     ),
//     labelSmall: TextStyle(
//       //fontFamily: mainFontFamily,
//       color: grey,
//     ),
//   ),
//   scaffoldBackgroundColor: background,
// );

// // final _timePickerTheme = TimePickerThemeData(
// //   backgroundColor: ,
// //   dayPeriodColor: Colors.blueGrey.shade600,
// //   dayPeriodTextColor: Colors.white,
// //   hourMinuteColor: MaterialStateColor.resolveWith((states) =>
// //       states.contains(MaterialState.selected) ? Colors.orange : Colors.blueGrey.shade800),
// //   hourMinuteTextColor: MaterialStateColor.resolveWith(
// //       (states) => states.contains(MaterialState.selected) ? Colors.white : Colors.orange),
// //   helpTextStyle:
// //       const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
// // );

// // Color popUpChatAttachIconsColor(BuildContext context) {
// //   final themeManger = getThemeManager(context);
// //   if (themeManger.isDarkMode) {
// //     return Colors.white;
// //   }
// //   return Colors.black;
// // }

// // TextStyle drawerTitle() => const TextStyle(
// //     fontWeight: FontWeight.w700,
// //     fontSize: 14,
// //     //fontFamily: mainFontFamily,
// //     letterSpacing: 0.3,
// //     color: gray300);


// // final ThemeData pickerTheme = ThemeData(
// //   primaryColor: colorAccent,
// //   cupertinoOverrideTheme: const CupertinoThemeData(
// //     primaryColor: colorAccent,
// //     textTheme: CupertinoTextThemeData(
// //       primaryColor: colorAccent,
// //     ),
// //   ),
// //   colorScheme: const ColorScheme(
// //     brightness: Brightness.light,
// //     primary: colorAccent,
// //     onPrimary: whiteColor,
// //     secondary: colorAccent,
// //     onSecondary: whiteColor,
// //     error: colorAccent,
// //     onError: whiteColor,
// //     background: whiteColor,
// //     onBackground: blackColor,
// //     surface: whiteColor,
// //     onSurface: blackColor,
// //   ),
// // );
