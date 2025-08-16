import 'package:challenge_pinapp/core/injector.dart';
import 'package:challenge_pinapp/presentation/controllers/home/home_bloc_controller.dart';
import 'package:challenge_pinapp/presentation/ui/core/constants/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'presentation/ui/core/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injector.setUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Challenge PinApp',
      builder: (context, child) =>
          BlocProvider(create: (BuildContext context) => Injector.get<HomeBloc>(), child: child),
      theme: ThemeData(
        fontFamily: GoogleFonts.inter().fontFamily,
        textTheme: TextTheme(
          headlineLarge: GoogleFonts.inter().copyWith(fontSize: 30.0, fontWeight: FontWeight.w400),
          titleLarge: GoogleFonts.inter().copyWith(fontSize: 20.0, fontWeight: FontWeight.w400),
          bodyLarge: GoogleFonts.inter().copyWith(fontSize: 14.0, fontWeight: FontWeight.w400),
        ),
        useMaterial3: true,
      ),
      routes: Routes.getRoutes(),
      initialRoute: RoutesNames.home,
    );
  }
}
