import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './home.dart';

var kColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 14, 26, 105),
    brightness: Brightness.light);
var kDarkColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 5, 95, 125),
    brightness: Brightness.dark);

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
  //   (value) => 
      runApp(
      MaterialApp(
        themeMode: ThemeMode.system,
        home: const home_screen(),
        darkTheme: ThemeData(colorScheme: kDarkColorScheme),
        theme: ThemeData(
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme()
              .copyWith(backgroundColor: kColorScheme.onPrimary),
          cardTheme: const CardTheme().copyWith(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          ),
        ),
      ),
    );
  // );
}
