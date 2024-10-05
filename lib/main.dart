import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_page.dart';

void main() async {
  runApp(const MyApp());
}

bool kIsMobile = true;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    kIsMobile = true;
    return MaterialApp(
      title: 'AgroPulse',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme.copyWith(
            headlineSmall: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            headlineLarge: GoogleFonts.inter(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}