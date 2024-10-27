import 'package:flutter/material.dart';
import 'package:cinema/pages/HomePage.dart';
import 'package:cinema/pages/Movies.dart';
import 'package:cinema/pages/TvShows.dart';
import 'package:cinema/pages/User.dart';

class ButtomNavBar extends StatefulWidget {
  const ButtomNavBar({Key? key}) : super(key: key);

  @override
  State<ButtomNavBar> createState() => _ButtomNavBarState();
}

class _ButtomNavBarState extends State<ButtomNavBar> {
  int _currentIndex = 0;

  // Lista de las vistas a mostrar
  final List<Widget> _pages = const [
    HomePage(),
    Movies(),
    TvShows(),
    UserProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Muestra la página correspondiente
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        selectedItemColor: Colors.blue.shade900,
        unselectedItemColor: Colors.blue.shade300,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Movies',
            icon: Icon(Icons.movie),
          ),
          BottomNavigationBarItem(
            label: 'TvShows',
            icon: Icon(Icons.tv),
          ),
          BottomNavigationBarItem(
            label: 'User',
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
