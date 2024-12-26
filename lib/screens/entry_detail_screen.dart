
// lib/screens/entry_detail_screen.dart
import 'package:flutter/material.dart';

class EntryDetailScreen extends StatelessWidget {
  final Map<String, dynamic> entry;

  const EntryDetailScreen({
    Key? key,
    required this.entry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(entry['type'].toString().capitalize()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              entry['title'],
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              DateTime.parse(entry['date'])
                  .toLocal()
                  .toString()
                  .split('.')[0],
              style: Theme.of(context).textTheme.caption,
            ),
            const SizedBox(height: 16),
            Text(
              entry['description'],
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}