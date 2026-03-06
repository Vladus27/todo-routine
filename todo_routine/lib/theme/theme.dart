import 'package:flutter/material.dart';

var _kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);
// k prefix behind the variable means constant value

//fromSeed method contains different shades from one color

var _kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 12, 56, 62),
);

ThemeData themeLight = ThemeData().copyWith(
  //copyWith method needs to edit individual properties without changing others
  colorScheme: _kColorScheme,
  appBarTheme: const AppBarTheme().copyWith(
    backgroundColor:
        _kColorScheme
            .onPrimaryContainer, //these properties needs for set shade of color
    foregroundColor: _kColorScheme.primaryContainer,
  ),
  cardTheme: const CardTheme().copyWith(
    color: _kColorScheme.secondaryContainer,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _kColorScheme.primaryContainer,
    ),
  ),
  textTheme: ThemeData().textTheme.copyWith(
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      color: _kColorScheme.onSecondaryContainer,
      fontSize: 16,
    ),
  ),
);

ThemeData themeDark = ThemeData.dark().copyWith(
  colorScheme: _kDarkColorScheme,
  cardTheme: const CardTheme().copyWith(
    color: _kDarkColorScheme.secondaryContainer,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _kDarkColorScheme.onPrimaryContainer,
      foregroundColor: _kDarkColorScheme.primaryContainer,
    ),
  ),
  appBarTheme: const AppBarTheme().copyWith(
    titleTextStyle: const TextStyle(fontSize: 16),
  ),
  inputDecorationTheme: const InputDecorationTheme().copyWith(
    hintStyle: TextStyle(color: _kDarkColorScheme.onSecondaryContainer),
    filled: false,
    fillColor: _kDarkColorScheme.onSecondaryContainer,
  ),
  textTheme: ThemeData().textTheme.copyWith(
    bodyLarge: TextStyle(color: _kDarkColorScheme.onSecondaryContainer),
    titleMedium: TextStyle(
      fontWeight: FontWeight.bold,
      color: _kDarkColorScheme.onSurface,
    ),
    bodyMedium: TextStyle(color: _kDarkColorScheme.onSurface),
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      color: _kDarkColorScheme.onSecondaryContainer,
      fontSize: 16,
    ),
  ),
);
