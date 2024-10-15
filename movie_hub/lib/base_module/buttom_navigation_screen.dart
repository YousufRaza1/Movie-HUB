import 'package:flutter/material.dart';
import 'home_screen/view/home_screen.dart';
class BottomNavScreen extends StatefulWidget {
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 0;

  // List of widget pages corresponding to each tab
  final List<Widget> _pages = [
    HomeScreen(),
    SearchScreen(),
    SettingsScreen(),
    BookmarkScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Displaying the current tab content
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the current tab
          });
        },
        selectedItemColor: Theme.of(context).colorScheme.onPrimary, // Selected item color
        unselectedItemColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
        backgroundColor: Theme.of(context).colorScheme.primary,
        type: BottomNavigationBarType.fixed, // Ensures all labels are visible
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmark',
          ),
        ],
      ),
    );
  }
}



// Search Screen
class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Search Screen', style: TextStyle(fontSize: 24)),
    );
  }
}

// Settings Screen
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Settings Screen', style: TextStyle(fontSize: 24)),
    );
  }
}

// Bookmark Screen
class BookmarkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Bookmark Screen', style: TextStyle(fontSize: 24)),
    );
  }
}