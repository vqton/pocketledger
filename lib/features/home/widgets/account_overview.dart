import 'package:flutter/material.dart';

class AccountOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.account_balance_wallet),
        title: Text('Total Balance'),
        subtitle: Text('\$10,000'),
        trailing: IconButton(
          icon: Icon(Icons.expand_more),
          onPressed: () {
            // Expand to show account details
          },
        ),
      ),
    );
  }
}
