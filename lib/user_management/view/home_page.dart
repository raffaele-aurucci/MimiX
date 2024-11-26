import 'package:mimix_app/user_management/beans/user.dart';
import 'package:mimix_app/user_management/beans/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(48),
            child: Center(
              child: // use watch when you want that the widget update himself
              context.watch<UserProvider>().user == null
                  ? const Text('No user logged in')
                  : Text('Hello, ${context.watch<UserProvider>().user!.username}!'),
            ),
          )
      ),
      floatingActionButton: ElevatedButton(onPressed: () {
        User? user = context.read<UserProvider>().user; // use read when you update user
        user?.username = "Raffy28";
        context.read<UserProvider>().setUser(user!);    // update user into Provider
      }, child: const Text('Change username')),
    );
  }
}