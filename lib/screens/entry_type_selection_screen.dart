// lib/screens/entry_type_selection_screen.dart
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'add_entry_screen.dart';

class EntryTypeSelectionScreen extends StatelessWidget {
  final Future<Database> database;
  final int userId;

  const EntryTypeSelectionScreen({
    Key? key,
    required this.database,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Entry')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTypeButton(
              context,
              'Mood',
              Icons.mood,
              Colors.blue,
            ),
            const SizedBox(height: 16),
            _buildTypeButton(
              context,
              'Reflective',
              Icons.psychology,
              Colors.purple,
            ),
            const SizedBox(height: 16),
            _buildTypeButton(
              context,
              'Memory',
              Icons.photo_album,
              Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeButton(
    BuildContext context,
    String type,
    IconData icon,
    Color color,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.all(20),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddEntryScreen(
              database: database,
              userId: userId,
              type: type.toLowerCase(),
            ),
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(type),
        ],
      ),
    );
  }
}