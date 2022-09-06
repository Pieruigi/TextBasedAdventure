import 'package:flutter/material.dart';

const Color _mainThemePrimaryColor = Colors.blue;

final mainTheme = ThemeData(
    primaryColor: _mainThemePrimaryColor,

    textTheme: const TextTheme(

      button: TextStyle(
        fontFamily: 'arial',
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: _mainThemePrimaryColor,
      ),

      headline1: TextStyle(

      fontFamily: 'courier_new',
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: Colors.blueGrey,
    )));

final commonPromptTheme = ThemeData(
    primaryColor: Colors.yellow,
    textTheme: const TextTheme(
      headline1: TextStyle(
      fontFamily: 'courier_new',
      fontSize: 28,
      fontWeight: FontWeight.w500,
      color: Colors.white60,
    )));
