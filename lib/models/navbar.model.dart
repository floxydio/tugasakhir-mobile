import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../constant/shared_pref.dart';
import '../screens/login/login_screen.dart';

class NavbarItem {
  List<PersistentBottomNavBarItem> navbarItem(BuildContext context) {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.book_online),
        title: ("Mapel"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.logout),
        title: ("Logout"),
        onPressed: (contexts) {
          // Provider.of<AuthViewModel>(context, listen: false).logout();
          SharedPrefs().clearAll();
          Get.offAll(const LoginScreen());
        },
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      )
    ];
  }
}
