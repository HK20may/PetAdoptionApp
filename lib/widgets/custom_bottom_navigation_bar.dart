import 'package:FurEverHome/screens/home_screen.dart';
import 'package:FurEverHome/screens/pet_history_screen.dart';
import 'package:FurEverHome/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const PetHistoryScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColors.primaryBgColor,
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.history_toggle_off_rounded,
                size: 30,
              ),
              label: 'History',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.buttonColor,
          unselectedItemColor: AppColors.buttonInActiveColor,
          unselectedFontSize: 16,
          selectedFontSize: 20,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
