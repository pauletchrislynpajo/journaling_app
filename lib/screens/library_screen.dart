import 'package:flutter/material.dart';
import 'package:journaling_app/screens/categories_entries_screen.dart';

import '../database/database_helper.dart';

class LibraryScreen extends StatefulWidget {
  final int userId;

  const LibraryScreen({super.key, required this.userId});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildCategoryCard(
            context,
            title: 'Mood',
            icon: Icons.mood,
            type: 'mood',
          ),
          _buildCategoryCard(
            context,
            title: 'Reflective',
            icon: Icons.psychology,
            type: 'reflective',
          ),
          _buildCategoryCard(
            context,
            title: 'Memory',
            icon: Icons.photo_album,
            type: 'memory',
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required String type,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4.0,
      child: ListTile(
        leading: Icon(
          icon,
          size: 40.0,
          color: Color(0xFF6A4E23), // Example custom brown color
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryEntriesScreen(
                userId: widget.userId,
                type: type,
              ),
            ),
          );
        },
      ),
    );
  }
}
