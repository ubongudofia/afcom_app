import 'package:flutter/material.dart';
import 'package:afcom_app/splash/pages/splash_page.dart';

import 'auth/servicenumber.dart';
import 'auth/name.dart';
import 'auth/phonenumber.dart';
import 'auth/otpscreen.dart';
import 'auth/email.dart';
import 'auth/emailotp.dart';
import 'auth/password.dart';
import 'login/loginpage.dart';
import 'login/forgot_password.dart';
import 'nav_screens/contact_screen.dart';
import 'nav_screens/chat_screen.dart';
import 'nav_screens/call_screen.dart';
import 'nav_screens/setting_screen.dart';

import 'welcome.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Assuming you have a variable to check if the user is logged in
  // For example: bool isLoggedIn = false;
  final bool isLoggedIn = false; // Change this based on login status

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DSA Messaging App',
      debugShowCheckedModeBanner: false,
      // Use initial route based on login status
      initialRoute: isLoggedIn ? '/chat_screen' : '/welcome',

      routes: {
        // Splash Screen Route
        '/': (context) => SplashScreen(),

        // Welcome Screen
        '/welcome': (context) => WelcomeScreen(),

        // New User Registration Path
        '/service_number': (context) => ServiceNumberScreen(),
        '/name': (context) => NameScreen(),
        '/phone': (context) => PhoneNumberScreen(),
        '/otp': (context) => PhoneOtpScreen(),
        '/email': (context) => EmailScreen(),
        '/email_otp': (context) => EmailOtpScreen(),
        '/password_setup': (context) => PasswordSetupScreen(),
        '/contact_screen': (context) =>
            ContactScreen(), // Final contact screen after registration

        // Already Registered User Path
        '/login_page': (context) => LoginPage(),
        '/forgot_password': (context) => ForgotPasswordScreen(),
        '/password_screen': (context) =>
            PasswordSetupScreen(), // Use this for password login
        '/chat_screen': (context) =>
            ChatScreen(), // Chat screen for logged-in users

        // Navigation Screens
        '/call_screen': (context) => CallScreen(),
        '/settings_screen': (context) => SettingsScreen(),
        '/contact_screens': (context) => ContactScreen(),
      },
    );
  }
}
