
// Encouragement card widget (lib/widgets/encouragement_card.dart)
import 'package:flutter/material.dart';
import 'dart:math';

class EncouragementCard extends StatelessWidget {
  const EncouragementCard({super.key});

  String _getRandomEncouragement() {
    final encouragements = [
      "You're doing great!",
      "Every step counts",
      "Your feelings matter",
      "Stay positive",
      "Embrace the journey",
      "You are stronger than you think",
    ];
    return encouragements[Random().nextInt(encouragements.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          _getRandomEncouragement(),
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}