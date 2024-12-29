import 'package:flutter/material.dart';
import 'package:journaling_app/extensions/string_extension.dart';

import '../database/database_helper.dart';

class AddEntryScreen extends StatefulWidget {
  final int userId;
  final String type;

  const AddEntryScreen({
    super.key,
    required this.userId,
    required this.type,
  });

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _dbHelper = DatabaseHelper();

  Future<void> _saveEntry() async {
    if (_formKey.currentState!.validate()) {
      final entry = {
        'userId': widget.userId,
        'type': widget.type,
        'title': _titleController.text,
        'content': _contentController.text,
        'dateCreated': DateTime.now().toIso8601String(),
      };

      await _dbHelper.insertEntry(entry);

      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown.shade700,
        title: Text(
          'New ${widget.type.capitalize()} Entry',
          style: TextStyle(color: Colors.brown.shade50),
        ),
        iconTheme: IconThemeData(color: Colors.brown.shade50),
      ),
      body: Container(
        color: Colors.brown.shade100,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Colors.brown.shade700),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.brown.shade700),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.brown.shade900),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: TextFormField(
                  controller: _contentController,
                  decoration: InputDecoration(
                    labelText: 'Content',
                    labelStyle: TextStyle(color: Colors.brown.shade700),
                    alignLabelWithHint: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown.shade700),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown.shade900),
                    ),
                  ),
                  maxLines: null,
                  expands: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some content';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown.shade700,
                  foregroundColor: Colors.brown.shade50,
                ),
                onPressed: _saveEntry,
                child: const Text('Save Entry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
