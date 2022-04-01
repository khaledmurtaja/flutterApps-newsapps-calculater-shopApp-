import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

class themes{
  static ThemeData lightTheme=ThemeData(
    primarySwatch: defaultColor,
    appBarTheme: AppBarTheme(
      color: Colors.white,
      titleTextStyle: TextStyle(
          color: Colors.black
      ),
      elevation: 0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.white
      ),
      iconTheme: IconThemeData(
          color: Colors.black
      ),

    ),
    textTheme:TextTheme(
      headline1:TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontSize: 18
      ),
      headline2: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.white,
          fontSize: 18
      ),
    ) ,
    scaffoldBackgroundColor: Colors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
    ),


  );
  static ThemeData DarkTheme=ThemeData(
    textTheme:TextTheme(
      headline1:TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontSize: 18
      ),
    ) ,
    primarySwatch: defaultColor,
    appBarTheme: AppBarTheme(
      color: HexColor('333739'),
      elevation: 0,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.white
      ),
      iconTheme: IconThemeData(
          color: Colors.white
      ),

    ),
    scaffoldBackgroundColor: HexColor('333739'),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.grey,
      backgroundColor:HexColor('333739'),
    ),
  );
}