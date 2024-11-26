// Start application
import 'package:mimix_app/utils/storage/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mimix_app/utils/view/app_theme.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mimix_app/user_management/view/registration_page.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Simulate initialization
  final bool isLoggedIn = await _simulateInitialization();

  FlutterNativeSplash.remove();

  runApp(MimixApp(isLoggedIn: isLoggedIn));
}

// TODO: Initialize the resources needed by app while the splash screen is displayed.
Future<bool> _simulateInitialization() async {
  final dbHelper = DatabaseHelper();
  Database db = await dbHelper.database;
  print('database: $db');
  return false;
}

class MimixApp extends StatelessWidget {
  final bool isLoggedIn;

  const MimixApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mimix App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: isLoggedIn ? const HomePage() : const RegistrationPage(),
    );
  }
}

// TODO: remove after that HomePage is created
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
        body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(48),
              child: Center(
                  child: Text("Home Page!")
              ),
            )
        )
    );
  }
}

// TODO: remove after that RegisterPage is created
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
        body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(48),
              child: Center(
                  child: Text("Register Page!")
              ),
            )
        )
    );
  }
}
