import 'package:flutter/material.dart';
import 'package:journaling_app/extensions/string_extension.dart';

import '../database/database_helper.dart';

class EntryDetailScreen extends StatelessWidget {
  final int entryId;
  final _dbHelper = DatabaseHelper();

  EntryDetailScreen({super.key, required this.entryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entry Details'),
        backgroundColor: Colors.brown.shade700,
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.brown.shade50),
      ),
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
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.brown.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Type: ${entry['type'].toString().capitalize()}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.brown.shade700,
                      ),
                ),
                Text(
                  'Date: ${DateTime.parse(entry['dateCreated']).toString()}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.brown.shade700,
                      ),
                ),
                const SizedBox(height: 16),
                Text(
                  entry['content'],
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.brown.shade800,
                      ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
