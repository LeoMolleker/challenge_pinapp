import 'package:challenge_pinapp/core/constants/routes_names.dart';
import 'package:challenge_pinapp/core/injector.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Injector.setUp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Challenge PinApp',
      theme: ThemeData(
        fontFamily: GoogleFonts.inter().fontFamily,
        textTheme: TextTheme(
          headlineLarge: GoogleFonts.inter().copyWith(
            fontSize: 30.0,
            fontWeight: FontWeight.w400,
          ),
          titleLarge: GoogleFonts.inter().copyWith(
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
          ),
          bodyLarge: GoogleFonts.inter().copyWith(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        useMaterial3: true,
      ),
      routes: Routes.getRoutes(),
      initialRoute: RoutesNames.home,
    );
  }
}
