// Goals screen file 
import 'package:flutter/material.dart';

class GoalsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Savings Goals'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to Add Goal screen
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          GoalCard(
            title: 'Vacation',
            targetAmount: 2000,
            currentAmount: 1000,
            deadline: DateTime(2024, 12, 31),
          ),
          GoalCard(
            title: 'Emergency Fund',
            targetAmount: 5000,
            currentAmount: 1500,
            deadline: DateTime(2025, 6, 30),
          ),
          // Add more GoalCards as needed
        ],
      ),
    );
  }
}

class GoalCard extends StatelessWidget {
  final String title;
  final double targetAmount;
  final double currentAmount;
  final DateTime deadline;

  GoalCard({
    required this.title,
    required this.targetAmount,
    required this.currentAmount,
    required this.deadline,
  });

  @override
  Widget build(BuildContext context) {
    double progress = currentAmount / targetAmount;

    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Target: \$${targetAmount.toStringAsFixed(2)}'),
            Text('Current: \$${currentAmount.toStringAsFixed(2)}'),
            Text('Deadline: ${deadline.toLocal().toShortDateString()}'),
            SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              color: progress >= 1.0 ? Colors.green : Colors.blue,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    // Navigate to Edit Goal screen
                  },
                  child: Text('Edit'),
                ),
                TextButton(
                  onPressed: () {
                    // Show delete confirmation dialog
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

extension DateTimeExtension on DateTime {
  String toShortDateString() {
    return '${this.day}/${this.month}/${this.year}';
  }
}
