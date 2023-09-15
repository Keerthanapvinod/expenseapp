import 'package:flutter/material.dart';
import 'package:expense_craker/Widget/expenses.dart';

var kColorcScheme= ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 72, 29, 147)
  );

  var kDarkcolorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 5, 99, 125),
    );

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([
    //DeviceOrientation.portraitUp
 // ]).then((fn){
  runApp(
    MaterialApp(
      darkTheme:ThemeData.dark().copyWith(
        useMaterial3: true,
      colorScheme: kDarkcolorScheme,


      cardTheme: const CardTheme().copyWith(
        color: kDarkcolorScheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style:ElevatedButton.styleFrom(
            backgroundColor: kColorcScheme.primaryContainer,
            foregroundColor: kDarkcolorScheme.onPrimaryContainer,
          ) ,
      ),
      ),
      theme:ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorcScheme,
        appBarTheme:const AppBarTheme().copyWith(
          backgroundColor: kColorcScheme.onPrimaryContainer,
          foregroundColor: kColorcScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color:kColorcScheme.secondaryContainer,
          margin:const EdgeInsets.symmetric(horizontal: 16,vertical:8 ) ,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style:ElevatedButton.styleFrom(
            backgroundColor: kColorcScheme.primaryContainer,
          ) ,
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color:kColorcScheme.onPrimaryContainer,
            fontSize: 16
             ),
        ),
      ),
      themeMode: ThemeMode.system,
      home:const Expenses(),
    ),
  );
}