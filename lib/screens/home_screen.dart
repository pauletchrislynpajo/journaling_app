

// Home screen (lib/screens/home_screen.dart)
import 'package:flutter/material.dart';
import '../widgets/encouragement_card.dart';
import 'library_screen.dart';
import 'add_entry_screen.dart';

class HomeScreen extends StatelessWidget {
  final int userId;

  const HomeScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showEntryTypeDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          const EncouragementCard(),
          Expanded(
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LibraryScreen(userId: userId),
                    ),
                  );
                },
                child: const Text('View Library'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEntryTypeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
                      userId: userId,
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
                      userId: userId,
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
                      userId: userId,
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
