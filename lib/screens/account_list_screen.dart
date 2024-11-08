import 'package:flutter/material.dart';
import '../services/account_service.dart';
import '../models/account.dart';

class AccountListScreen extends StatelessWidget {
  final AccountService accountService;

  AccountListScreen({required this.accountService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accounts'),
      ),
      body: FutureBuilder(
        future: accountService.loadAccounts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading accounts'));
          } else {
            final accounts = accountService.accounts;
            if (accounts.isEmpty) {
              return Center(child: Text('No accounts found'));
            }
            return ListView.builder(
              itemCount: accounts.length,
              itemBuilder: (context, index) {
                final account = accounts[index];
                return ListTile(
                  title: Text(account.name),
                  subtitle: Text('${account.type.toString().split('.').last} - \$${account.balance}'),
                  onTap: () {
                    // Handle account tap
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
