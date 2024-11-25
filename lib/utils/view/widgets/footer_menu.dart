import 'package:flutter/material.dart';
import 'package:mimix_app/utils/view/app_palette.dart';

class FooterMenu extends StatelessWidget {
  // final Function(int) onItemTapped; // Add the function to navigate in the app pages
  final int selectedIndex;

  const FooterMenu({
    Key? key,
    required this.selectedIndex,
    // this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      // onTap: onItemTapped,
      type: BottomNavigationBarType.fixed, // Required to add more than 4 elements in the footer
      selectedItemColor: PaletteColor.darkBlue,
      unselectedItemColor: PaletteColor.lightSkyBlue,
      showSelectedLabels: false, // Hidden the label of selected icon
      showUnselectedLabels: false, // Hidden the label of not selected icon
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.window_sharp),
          label: '', // Empty label
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: '',
        ),
      ],
    );
  }
}

//  CREATION EXAMPLE
//  bottomNavigationBar:
//          FooterMenu(
//                    selectedIndex: 0,
//                    onItemTapped: FUNCTION
//                    ),

// This snippet of code creates a footer menu in the page.
// The "selectedIndex" variable provides information about the current page.
// It was required a function in "onItemTapped" to navigate in the app.
