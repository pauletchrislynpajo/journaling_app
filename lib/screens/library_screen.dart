

// Library screen (lib/screens/library_screen.dart)
import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import 'entry_detail_screen.dart';

class LibraryScreen extends StatefulWidget {
  final int userId;

  const LibraryScreen({super.key, required this.userId});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  String _currentType = 'all';
  final _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Library')),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _getNavIndex(_currentType),
        onTap: (index) {
          setState(() {
            _currentType = _getTypeFromIndex(index);
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.all_inclusive),
            label: 'All',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mood),
            label: 'Mood',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.psychology),
            label: 'Reflective',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_album),
            label: 'Memory',
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _currentType == 'all'
            ? _dbHelper.getAllEntries(widget.userId)
            : _dbHelper.getEntriesByType(widget.userId, _currentType),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final entries = snapshot.data!;
          
          return ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final entry = entries[index];
              return ListTile(
                title: Text(entry['title']),
                subtitle: Text(entry['dateCreated']),
                leading: Icon(_getIconForType(entry['type'])),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EntryDetailScreen(entryId: entry['id']),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  int _getNavIndex(String type) {
    switch (type) {
      case 'all':
        return 0;
      case 'mood':
        return 1;
      case 'reflective':
        return 2;
      case 'memory':
        return 3;
      default:
        return 0;
    }
  }

  String _getTypeFromIndex(int index) {
    switch (index) {
      case 0:
        return 'all';
      case 1:
        return 'mood';
      case 2:
        return 'reflective';
      case 3:
        return 'memory';
      default:
        return 'all';
    }
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'mood':
        return Icons.mood;
      case 'reflective':
        return Icons.psychology;
      case 'memory':
        return Icons.photo_album;
      default:
        return Icons.note;
    }
  }
}