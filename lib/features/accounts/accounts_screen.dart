// Accounts screen file
import 'package:flutter/material.dart';

class AccountsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accounts'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Logout action placeholder
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildProfileSection(),
          Expanded(child: _buildAccountsList()),
          _buildAddAccountButton(),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
                'https://www.w3schools.com/w3images/avatar2.png'), // Placeholder image
            radius: 30,
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, John Doe!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'johndoe@gmail.com',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAccountsList() {
    final accounts = [
      {'name': 'Bank of America', 'type': 'bank', 'balance': 1200.75},
      {'name': 'Cash Wallet', 'type': 'cash', 'balance': 350.00},
    ];

    return ListView.builder(
      itemCount: accounts.length,
      itemBuilder: (context, index) {
        final account = accounts[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blueAccent,
              child: Icon(
                _getAccountIcon(account['type'] as String?),
                color: Colors.white,
              ),
            ),
            title: Text(
              account['name'] as String? ?? 'Unknown Account',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Balance: \$${(account['balance'] as double? ?? 0.0).toStringAsFixed(2)}',
              style: TextStyle(
                color: (account['balance'] as double?)! < 0
                    ? Colors.red
                    : Colors.green,
              ),
            ),
            trailing: Icon(Icons.more_vert),
            onTap: () {
              // Account options placeholder
            },
          ),
        );
      },
    );
  }

  Widget _buildAddAccountButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton.icon(
        onPressed: () {
          // Add account action placeholder
        },
        icon: Icon(Icons.add),
        label: Text('Add New Account'),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  IconData _getAccountIcon(String? accountType) {
    switch (accountType?.toLowerCase()) {
      case 'bank':
        return Icons.account_balance;
      case 'cash':
        return Icons.money;
      default:
        return Icons.account_balance_wallet;
    }
  }
}
