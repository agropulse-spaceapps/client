import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  final Future<void> Function() _handleSignIn;

  LoginPage({Key? key, required Future<void> Function() handleSignIn})
      : _handleSignIn = handleSignIn,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    
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
