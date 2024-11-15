import 'package:flutter/material.dart';

class SpendingSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.pie_chart),
        title: Text('Spending Summary'),
        subtitle: Text('This Month: \$500'),
        trailing: IconButton(
          icon: Icon(Icons.arrow_forward),
          onPressed: () {
            // Navigate to detailed reports
          },
        ),
      ),
    );
  }
}
