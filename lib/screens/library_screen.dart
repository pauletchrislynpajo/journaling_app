

// lib/screens/library_screen.dart
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'entry_detail_screen.dart';

class LibraryScreen extends StatefulWidget {
  final Future<Database> database;
  final int userId;

  const LibraryScreen({
    Key? key,
    required this.database,
    required this.userId,
  }) : super(key: key);

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  String _selectedType = 'mood';

  Future<List<Map<String, dynamic>>> _getEntries() async {
    final db = await widget.database;
    return db.query(
      'entries',
      where: 'userId = ? AND type = ?',
      whereArgs: [widget.userId, _selectedType],
      orderBy: 'date DESC',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTypeFilter('Mood', Icons.mood),
              _buildTypeFilter('Reflective', Icons.psychology),
              _buildTypeFilter('Memory', Icons.photo_album),
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: _getEntries(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return Center(
                    child: Text('No ${_selectedType} entries yet'),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final entry = snapshot.data![index];
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(entry['title']),
                        subtitle: Text(
                          entry['description'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Text(
                          DateTime.parse(entry['date'])
                              .toLocal()
                              .toString()
                              .split(' ')[0],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EntryDetailScreen(entry: entry),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTypeFilter(String type, IconData icon) {
    final isSelected = _selectedType == type.toLowerCase();
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: isSelected ? Colors.white : Colors.grey,
          ),
          const SizedBox(width: 4),
          Text(
            type,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
      selected: isSelected,
      onSelected: (bool selected) {
        setState(() {
          _selectedType = type.toLowerCase();
        });
      },
    );
  }
}