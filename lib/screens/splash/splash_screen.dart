import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../auth/login_screen.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    navigateUser();
  }

  void navigateUser() {
    Timer(
      const Duration(seconds: 3),
          () {
        final user =
            FirebaseAuth.instance.currentUser;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => user != null
                ? const HomeScreen()
                : const LoginScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0014A8),

      body: Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [

            Container(
              width: 150,
              height: 150,

              child: Image.asset(
                'assets/images/logo.png',
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Expense Tracker",
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Track Every Rupee",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 40),

            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}