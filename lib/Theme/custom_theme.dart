import 'package:flutter/material.dart';
import 'package:my_movie_recomandation_app/Theme/palette.dart';

class CustomTheme {
  //dark theme
  static ThemeData darkTheme(BuildContext context) {
    final theme = Theme.of(context);
    return ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: MaterialColor(
          Palette.red500.value,
          const {
            100: Palette.red100,
            200: Palette.red200,
            300: Palette.red300,
            400: Palette.red400,
            500: Palette.red500,
            600: Palette.red600,
            700: Palette.red700,
            800: Palette.red800,
            900: Palette.red900,
          },
      ),
      brightness: Brightness.dark,
      ).copyWith(secondary: Palette.red500),
      scaffoldBackgroundColor: Palette.almostBlack,
      appBarTheme: const AppBarTheme(
        color: Palette.almostBlack,
        elevation: 0,
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: Colors.orange,
        inactiveTrackColor: Colors.grey.shade800,
        thumbColor: Colors.white,
        valueIndicatorColor: Palette.red500,
        inactiveTickMarkColor: Colors.transparent,
        activeTickMarkColor: Colors.transparent,
      ),
      textTheme: theme.primaryTextTheme.apply(
        bodyColor: Palette.red500,
      )
        .copyWith(
          button: theme.primaryTextTheme.button?.copyWith(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          )
        )
        .apply(
          displayColor: Colors.white,
        ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}