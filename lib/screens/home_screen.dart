import 'package:flutter/material.dart';

import '../widgets/encouragement_card.dart';
import 'add_entry_screen.dart';
import 'library_screen.dart';

class HomeScreen extends StatefulWidget {
  final int userId;

  const HomeScreen({super.key, required this.userId});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // Pages for navigation
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeContent(userId: widget.userId),
      LibraryContent(userId: widget.userId),
    ];
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[700],
        foregroundColor: Colors.white,
        title: const Text('Memoir App'),
        actions: [
          if (_currentIndex == 0)
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _showEntryTypeDialog(context),
            ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        backgroundColor: Colors.brown[700],
        selectedItemColor: Colors.orange[300],
        unselectedItemColor: Colors.brown[200],
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

  void _showEntryTypeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.brown[50],
        title: const Text('Choose Entry Type'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Mood'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEntryScreen(
                      userId: widget.userId,
                      type: 'mood',
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Reflective'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEntryScreen(
                      userId: widget.userId,
                      type: 'reflective',
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Memory'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEntryScreen(
                      userId: widget.userId,
                      type: 'memory',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final int userId;

  const HomeContent({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[50],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Encouragement Section
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: EncouragementCard(),
          ),

          // "How are you feeling today?" Section
          Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.orange[100],
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.brown.withOpacity(0.2),
                  blurRadius: 8.0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                'How are you feeling today?',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[700],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Mood Cards Section
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown.withOpacity(0.1),
                    blurRadius: 6.0,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ListView(
                children: [
                  _buildMoodCard(context, 'Happy', Colors.orange[200]!),
                  const SizedBox(height: 10),
                  _buildMoodCard(context, 'Grateful', Colors.brown[200]!),
                  const SizedBox(height: 10),
                  _buildMoodCard(context, 'Relaxed', Colors.green[200]!),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodCard(BuildContext context, String title, Color color) {
    return Card(
      elevation: 4,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              Icons.emoji_emotions,
              color: Colors.brown[700],
              size: 30,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.brown[900],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LibraryContent extends StatelessWidget {
  final int userId;

  const LibraryContent({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[50],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Library',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Explore your journal entries.',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.brown,
              ),
            ),
          ),
          Expanded(
            child: LibraryScreen(userId: userId),
          ),
        ],
      ),
    );
  }
}
