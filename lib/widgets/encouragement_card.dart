import 'dart:math';

import 'package:flutter/material.dart';

class EncouragementCard extends StatelessWidget {
  const EncouragementCard({super.key});

  String _getRandomEncouragement() {
    final encouragements = [
      "You're doing great!",
      "Every step counts.",
      "Your feelings matter.",
      "Stay positive.",
      "Embrace the journey.",
      "You are stronger than you think.",
    ];
    return encouragements[Random().nextInt(encouragements.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Colors.brown[100], // Light brown background
        child: SizedBox(
          width: 400, // Constant width of 400
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Text(
              _getRandomEncouragement(),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: 28.0, // Font size
                    color: Colors.brown[800], // Dark brown text
                    fontWeight: FontWeight.bold, // Strong emphasis
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
