import 'package:flutter/material.dart';

class GoalsSavings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.savings),
        title: Text('Savings Goals'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Vacation: \$2000'),
            LinearProgressIndicator(
              value: 0.5, // Example progress value
              backgroundColor: Colors.grey[300],
              color: Colors.blue,
            ),
            SizedBox(height: 8),
            Text('Emergency Fund: \$5000'),
            LinearProgressIndicator(
              value: 0.3, // Example progress value
              backgroundColor: Colors.grey[300],
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
