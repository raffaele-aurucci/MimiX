// Start application
import 'package:mimix_app/minigame_managment/view/minigame_page.dart';
import 'package:mimix_app/training_managment/view/training_page.dart';
import 'package:mimix_app/user_management/beans/user.dart';
import 'package:mimix_app/user_management/beans/user_provider.dart';
import 'package:mimix_app/user_management/storage/user_dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mimix_app/user_management/view/home_page.dart';
import 'package:mimix_app/utils/view/app_theme.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:mimix_app/user_management/view/registration_page.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Permission.camera.request();
  await Permission.microphone.request();

  // Simulate initialization
  final user = await _simulateInitialization();

  FlutterNativeSplash.remove();

  runApp(MimixApp(user: user));
}

// TODO: Initialize the resources needed by app while the splash screen is displayed.
Future<User?> _simulateInitialization() async {
  // final dbHelper = DatabaseHelper();
  // Database db = await dbHelper.database;
  // print('database: $db');

  // only one user in DB
  UserDao userDao = UserDao();
  User? user = await userDao.getUserById(1);

  return user;
}

class MimixApp extends StatelessWidget {

  final User? user;

  const MimixApp({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider( // initialize provider for all application
        create: (_) => UserProvider(user),
        child: MaterialApp(
          routes: {
            '/minigame_page': (context) => const MinigamePage(title: 'Minigames'),
            '/training_page': (context) => const TrainingPage(title: 'Training'),
          },
        title: 'Mimix App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: user != null ? const HomePage() : const RegistrationPage(),
    )
    );
  }
}
