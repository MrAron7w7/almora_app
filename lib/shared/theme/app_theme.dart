import 'package:flutter/material.dart';

/* 
  Se creara el tema de la app
  para tener los colores en un unico archivo y poder llamarlos ahi
*/

class AppTheme {
  static ThemeData get appTheme => ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
        ),
        colorScheme: const ColorScheme.light(
          primary: Color(0xfff99f1c),
          secondary: Color(0xffd3d2d1),
        ),
      );
}
