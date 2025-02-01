// Start application
import 'package:mimix_app/minigame_managment/view/minigame_page.dart';
import 'package:mimix_app/training_managment/view/training_page.dart';
import 'package:mimix_app/user_management/beans/check_log.dart';
import 'package:mimix_app/user_management/beans/user.dart';
import 'package:mimix_app/user_management/beans/user_provider.dart';
import 'package:mimix_app/user_management/storage/check_log_dao.dart';
import 'package:mimix_app/user_management/storage/user_dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mimix_app/user_management/view/check_ability_page.dart';
import 'package:mimix_app/user_management/view/menu_page.dart';
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
  final objects = await _simulateInitialization();

  FlutterNativeSplash.remove();

  runApp(MimixApp(objects: objects));
}

// TODO: Initialize the resources needed by app while the splash screen is displayed.
Future<Map<String, Object?>> _simulateInitialization() async {
  // final dbHelper = DatabaseHelper();
  // Database db = await dbHelper.database;
  // print('database: $db');

  // only one user in DB
  UserDao userDao = UserDao();
  User? user = await userDao.getUserById(1);

  // last check ability log
  CheckLog? checkLog;

  if (user != null){
    CheckLogDao checkLogDao = CheckLogDao();
    List<CheckLog> checkLogs = await checkLogDao.getCheckLogsByUserId(user.id!);
    if (checkLogs.isNotEmpty){
      checkLog = checkLogs[checkLogs.length - 1];
    }
  }

  return {'user': user, 'checkLog': checkLog};
}

class MimixApp extends StatelessWidget {

  final Map<String, Object?> objects;

  const MimixApp({super.key, required this.objects});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider( // initialize provider for all application
        create: (_) => UserProvider(objects['user'] as User?),
        child: MaterialApp(
          routes: {
            '/minigames_page': (context) => const MinigamePage(title: 'Minigames'),
            '/training_page': (context) => const TrainingPage(title: 'Training'),
          },
        title: 'Mimix App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: objects['user'] != null && objects['checkLog'] != null ? const MenuPage()
            : objects['user'] != null && objects['checkLog'] == null ? const CheckAbilityPage()
            : const RegistrationPage()
    )
    );
  }
}
