import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import 'entry_detail_screen.dart';

class CategoryEntriesScreen extends StatelessWidget {
  final int userId;
  final String type;

  const CategoryEntriesScreen(
      {super.key, required this.userId, required this.type});

  @override
  Widget build(BuildContext context) {
    final _dbHelper = DatabaseHelper();

    return Scaffold(
      appBar: AppBar(
        title: Text('$type entries'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.brown.shade700,
        iconTheme: IconThemeData(color: Colors.brown.shade50),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _dbHelper.getEntriesByType(userId, type),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final entries = snapshot.data!;

          if (entries.isEmpty) {
            return Center(
              child: Text(
                'No entries found in this category.',
                style: TextStyle(color: Colors.brown.shade700),
              ),
            );
          }

          return ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final entry = entries[index];
              return ListTile(
                title: Text(
                  entry['title'],
                  style: TextStyle(color: Colors.brown.shade900),
                ),
                subtitle: Text(
                  entry['dateCreated'],
                  style: TextStyle(color: Colors.brown.shade700),
                ),
                leading: Icon(
                  _getIconForType(type),
                  color: Colors.brown.shade700,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EntryDetailScreen(entryId: entry['id']),
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
