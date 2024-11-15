import 'package:flutter/material.dart';

class RecentTransactions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Search Transactions',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.receipt),
              title: Text('Recent Transactions'),
              subtitle: Text('Groceries - \$50'),
            ),
          ),
        ],
      ),
    );
  }
}
