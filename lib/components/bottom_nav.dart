import 'package:flutter/material.dart';
import 'package:negotiator/components/route_manager.dart';
import 'package:negotiator/pages/profile.dart';

import '../pages/dashboard.dart';

Widget BottomBar(BuildContext context, int index, String username){
  return BottomNavigationBar(
    // Navigation Bar at the bottom
    backgroundColor: Colors.white,
    unselectedItemColor: Colors.grey,
    selectedItemColor: Colors.blueAccent,
    unselectedFontSize: 10.0,
    selectedFontSize: 10.0,
    selectedLabelStyle: const TextStyle(
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.normal,
    ),
    unselectedLabelStyle: const TextStyle(
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.normal,
    ),
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart),
        label: 'Dashboard',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile',
      ),
    ],
    type: BottomNavigationBarType.fixed,
    currentIndex: index,
    // Set the current index (active link)
    onTap: (index) {
      // Handle navigation here
      if (index == 0) {
        // Navigate to the Product
        Navigator.of(context).push(createRoute(DashboardScreen(username: username)));
      } else if (index == 1) {
        // Navigate to profile
        Navigator.of(context).push(createRoute(ProfileScreen(username: username)));
      }
    },
  );
}