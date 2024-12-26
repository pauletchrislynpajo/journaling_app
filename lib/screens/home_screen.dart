
// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'library_screen.dart';
import 'entry_type_selection_screen.dart';

class HomeScreen extends StatefulWidget {
  final Future<Database> database;
  final int userId;

  const HomeScreen({
    Key? key,
    required this.database,
    required this.userId,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<String> _encouragingWords = [
    "Every day is a new beginning.",
    "You're doing great!",
    "Your feelings matter.",
    "Take it one day at a time.",
    "Your journey is uniquely yours.",
    "Trust the process.",
    "You are stronger than you know.",
  ];

  String get _randomEncouragement {
    return _encouragingWords[DateTime.now().millisecond % _encouragingWords.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'Home' : 'Library'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EntryTypeSelectionScreen(
                    database: widget.database,
                    userId: widget.userId,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: _selectedIndex == 0
          ? HomeBody(encouragement: _randomEncouragement)
          : LibraryScreen(database: widget.database, userId: widget.userId),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Library',
          ),
        ],
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  final String encouragement;

  const HomeBody({Key? key, required this.encouragement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.favorite,
              size: 80,
              color: Colors.pink,
            ),
            const SizedBox(height: 24),
            Text(
              encouragement,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
