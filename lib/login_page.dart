import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_web/google_sign_in_web.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '547716123620-jhjgron0hud5t61pelm7on3lalmoiepf.apps.googleusercontent.com',
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> _handleSignIn() async {
    try { 
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        final GoogleSignInAuthentication auth = await account.authentication;
        final String idToken = auth.idToken!;
        debugPrint("\n dam2n \n");
        final String accessToken = auth.accessToken!;
        debugPrint("\n dam2n \n");

        final response = await http.post(
          Uri.parse('https://agropulse.web.tr/auth/google/callback'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'idToken': idToken,
            'accessToken': accessToken,
          }),
        );

        debugPrint("\n dam2n \n");
        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          print('Successfully sent to server: $responseData');
        } else {
          print('Server error: ${response.statusCode}');
          print('Response body: ${response.body}');
        }
      } else {
        print('Sign in aborted by user');
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    debugPrint("check");
    
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Center(
              child: FractionallySizedBox(
                widthFactor: 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Text(
                      'AgroPulse',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      'Sign In.',
                      style: Theme.of(context).textTheme.headlineLarge, 
                    ),
                    const Spacer(),
                    GoogleAuthButton(onSignIn: _handleSignIn),
                    const Spacer(),
                  ],
                ),
              )
            ),
          ),
          if(screenSize.width > screenSize.height)
            Expanded(
              child: Image.asset(
                'assets/login_ciftci.png',
                fit: BoxFit.cover,
                alignment: Alignment.center,
                height: double.infinity,
              ),
            )
        ],
      ),
    );
  }
}

class GoogleAuthButton extends StatelessWidget {
  final Future<void> Function() onSignIn;

  GoogleAuthButton({super.key, required this.onSignIn});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onSignIn, // implement goole auth for web
      style: TextButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 217, 217, 217),
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      icon: SvgPicture.asset(
        'assets/google_logo.svg', // Path to your SVG file
        width: 24, // Adjust the size as needed
        height: 24,
      ),
      label: const Row(children: [Spacer(), Text('Sign in with Google'), Spacer()]),
    );
  }
}
