import 'dart:convert';
import 'dart:js_interop';

import 'package:agropulse/home_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login_page.dart';
import 'package:http/http.dart' as http;

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: kIsWeb
        ? '547716123620-jhjgron0hud5t61pelm7on3lalmoiepf.apps.googleusercontent.com'
        : '547716123620-rg31847rudsg23rg89k9e2st9l58hvok.apps.googleusercontent.com',
    scopes: [
      'profile',
      'email',
    ],
  );

  Future<void> _handleSignIn() async {
    try {
      print("Signing in...");
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      print("Signed in...");
      if (account != null) {
        // print(account.toJSBox);
        
        final GoogleSignInAuthentication auth = await account.authentication;
        // final String idToken = auth.idToken!;
        final String accessToken = auth.accessToken!;

        final url = 'https://agropulse.web.tr/api/get?accessToken=${Uri.encodeComponent(accessToken)}';

        final response = await http.get(
          Uri.parse(url),  // Use Uri.parse() for a full URL
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );


        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          print('Successfully sent to server: $responseData');
        } else {
          print('Failed to send to server: ${response.body}');
        }
      }
    } catch (error) {
      print(error);
    }
  }

  GoogleSignInAccount? get currentUser => _googleSignIn.currentUser;

  Widget? loginPage;
  Widget? homePage;

  Widget? currentPage;

  void changePage() {
    setState(() {
      currentPage = homePage;      
    });
  }

  @override
  void initState() {
    super.initState();
    loginPage = LoginPage(handleSignIn: _handleSignIn);
    homePage = HomePage();
    currentPage = _googleSignIn.currentUser == null ? loginPage : homePage;
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      if (account != null) {
        print("interchange");
        changePage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    currentPage = _googleSignIn.currentUser == null ? loginPage : homePage;
    return MaterialApp(
      title: 'AgroPulse',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme.copyWith(
            headlineSmall: GoogleFonts.inter(
              fontSize: 36,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            headlineLarge: GoogleFonts.inter(
              fontSize: 48,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
            bodyLarge: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
        useMaterial3: true,
      ),
      home: currentPage,
    );
  }
}