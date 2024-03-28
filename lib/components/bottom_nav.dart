import 'package:flutter/material.dart';

Widget BottomBar(BuildContext context, int index){
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
        Navigator.pushNamed(context, '/splash');
      } else if (index == 1) {
        // Navigate to profile
        Navigator.pushNamed(context, '/profile');
      }
    },
  );
}