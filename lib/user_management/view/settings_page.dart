import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../../utils/view/app_palette.dart';
import '../../utils/view/widgets/texts/description_text.dart';
import '../../utils/view/widgets/texts/header_text.dart';
import '../beans/user_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {

  bool switchValue1 = true;
  bool switchValue2 = true;

  // To change switch value
  void handleChangeSwitch1Value(bool value) {
    setState(() {
      if(switchValue1)
        switchValue1 = false;
      else
        switchValue1 = true;
    });
  }

  void handleChangeSwitch2Value(bool value) {
    setState(() {
      if(switchValue2)
        switchValue2 = false;
      else
        switchValue2 = true;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                // Title of page
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeaderText(text: 'Settings', size: HeaderText.H4),
                  ],),

                const SizedBox(height: 45),

                // Profile Avatar
                CircleAvatar(
                  radius: 50,
                  backgroundColor: PaletteColor.progressBarBackground,
                  child: Image.asset('assets/images/icons/user.png')
                ),
                SizedBox(height: 8),

                // Profile Name
                HeaderText(
                    text: '${context.watch<UserProvider>().user!.username}',
                    size: HeaderText.H4
                ),
                SizedBox(height: 24),

                // Notification Toggle
                ListTile(
                  leading: Icon(Icons.notifications, color: PaletteColor.darkBlue),
                  title: DescriptionText(
                      text: 'Notification',
                      size: DescriptionText.P1
                  ),
                  trailing: SizedBox(
                    width: 50,
                    child: FlutterSwitch(
                      value: switchValue1,
                      onToggle: (value) {
                        handleChangeSwitch1Value(value);
                      },
                      activeColor: PaletteColor.whiteColor,
                      inactiveColor: PaletteColor.whiteColor,
                      toggleSize: 20,
                      borderRadius: 15.0,
                      width: 50.0,
                      height: 28.0,
                      toggleBorder: Border.all(color: PaletteColor.darkBlue, width: 3),
                      switchBorder: Border.all(color: PaletteColor.darkBlue, width: 3),
                    ),
                  )
                ),

                // Sound Toggle
                ListTile(
                  leading: Icon(Icons.volume_up, color: PaletteColor.darkBlue),
                  title: DescriptionText(
                      text: 'Sound',
                      size: DescriptionText.P1
                  ),
                  trailing: SizedBox(
                    width: 50,
                    child: FlutterSwitch(
                      value: switchValue2,
                      onToggle: (value) {
                        handleChangeSwitch2Value(value);
                      },
                      activeColor: PaletteColor.whiteColor,
                      inactiveColor: PaletteColor.whiteColor,
                      toggleSize: 20,
                      borderRadius: 15.0,
                      width: 50.0,
                      height: 28.0,
                      toggleBorder: Border.all(color: PaletteColor.darkBlue, width: 3),
                      switchBorder: Border.all(color: PaletteColor.darkBlue, width: 3),
                    ),
                  )
                ),

                // Language Dropdown
                ListTile(
                  leading: const Icon(Icons.language, color: PaletteColor.darkBlue),
                  title: DescriptionText(
                      text: 'Language',
                      size: DescriptionText.P1
                  ),
                  trailing: DropdownButton<String>(
                    value: 'English',
                    style: TextStyle(color: PaletteColor.darkBlue),
                    items: const [
                      DropdownMenuItem(
                        value: 'English',
                        child: Text('English'),
                      ),
                      DropdownMenuItem(
                        value: 'Italian',
                        child: Text('Italian'),
                      ),
                      DropdownMenuItem(
                        value: 'Spanish',
                        child: Text('Spanish'),
                      ),
                    ],
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

}
