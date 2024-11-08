import 'package:flutter/material.dart';
import '../services/account_service.dart';

class ViewAccountsScreen extends StatelessWidget {
  final AccountService accountService;

  ViewAccountsScreen({required this.accountService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accounts'),
      ),
      body: ListView.builder(
        itemCount: accountService.accounts.length,
        itemBuilder: (context, index) {
          final account = accountService.accounts[index];
          return ListTile(
            title: Text(account.name),
            subtitle: Text('${account.type} - \$${account.balance}'),
            onTap: () {
              // Navigate to account details or edit screen
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add account screen
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
