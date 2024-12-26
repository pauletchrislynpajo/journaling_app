

// Entry detail screen (lib/screens/entry_detail_screen.dart)
import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class EntryDetailScreen extends StatelessWidget {
  final int entryId;
  final _dbHelper = DatabaseHelper();

  EntryDetailScreen({super.key, required this.entryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Entry Details')),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _dbHelper.getEntry(entryId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final entry = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry['title'],
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Type: ${entry['type'].toString().capitalize()}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  'Date: ${DateTime.parse(entry['dateCreated']).toString()}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                Text(
                  entry['content'],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
