import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_valley_admin/providers/add_slider_provider/add_slider_provider.dart';
import 'package:new_valley_admin/providers/add_villa_provider/add_villa_provider.dart';
import 'package:new_valley_admin/providers/dashboard/page_provider.dart';
import 'package:new_valley_admin/providers/login_provider/login_provider.dart';
import 'package:new_valley_admin/screens/add_post/add_post_screen.dart';
import 'package:new_valley_admin/screens/add_slider/add_slider.dart';
import 'package:new_valley_admin/screens/dashboard/starter_screen.dart';
import 'package:new_valley_admin/screens/login/login_screen.dart';
import 'package:new_valley_admin/screens/payments/payment_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDYmjj1xmYCz-FKi5mZqMZMZsVrntCvSdQ",
      authDomain: "vacation-villa-rental.firebaseapp.com",
      projectId: "vacation-villa-rental",
      storageBucket: "vacation-villa-rental.appspot.com",
      messagingSenderId: "906898398200",
      appId: "1:906898398200:web:01abb8daf874057a64d40d",
      measurementId: "G-L8997E8D19",
    ),
  );

  // Initialize AuthProvider to check login status
  final authProvider = AuthProvider();
  await authProvider.checkLoginStatus(); // Check if the user is logged in

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PageProvider()), // Manage page navigation
        ChangeNotifierProvider(create: (_) => authProvider), // Use the same instance of AuthProvider
        ChangeNotifierProvider(create: (_) => SliderProvider()),
        ChangeNotifierProvider(create: (_) => AddVillaProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Admin Panel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          log("isLoggedIn: ${authProvider.isLoggedIn}");
          // Show login screen if not logged in, otherwise show dashboard
          return authProvider.isLoggedIn
              ? StarterScreen() // Redirect to Admin Dashboard if logged in
              : AdminLoginScreen(); // Show login screen otherwise
        },
      ),
      routes: {
        '/adminDashboard': (context) => StarterScreen(),
        '/addPost': (context) => AddPostPage(),
        '/payments': (context) => PaymentsPage(),
        '/addSlider': (context) => AddSliderPage(),
      },
    );
  }
}
