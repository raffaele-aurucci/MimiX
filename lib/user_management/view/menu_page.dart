import 'package:flutter/material.dart';
import 'package:mimix_app/user_management/view/settings_page.dart';
import 'package:mimix_app/user_management/view/stats_page.dart';

import '../../utils/view/widgets/footer_menu.dart';
import 'home_page.dart';
import 'notification_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    StatsPage(),
    NotificationsPage(),
    SettingsPage(),
  ];

  // To manage the exchange of pages
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Show selected page
      bottomNavigationBar: FooterMenu(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
