import 'package:flutter/material.dart';
import '../services/transaction_service.dart';
import '../services/account_service.dart';
import '../screens/add_edit_transaction_screen.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> transaction;
  final TransactionService transactionService;
  final AccountService accountService;

  TransactionDetailsScreen({required this.transaction, required this.transactionService, required this.accountService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit transaction screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditTransactionScreen(
                    isEdit: true,
                    transaction: transaction,
                    transactionService: transactionService,
                    accountService: accountService, // Add this line
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Handle delete transaction
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Delete Transaction'),
                  content: Text('Are you sure you want to delete this transaction?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        // Delete the transaction
                        transactionService.deleteTransaction(transaction['id']);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text('Delete'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Title: ${transaction['title']}', style: TextStyle(fontSize: 18.0)),
            SizedBox(height: 8.0),
            Text('Amount: \$${transaction['amount']}', style: TextStyle(fontSize: 18.0)),
            SizedBox(height: 8.0),
            Text('Category: ${transaction['category']}', style: TextStyle(fontSize: 18.0)),
            SizedBox(height: 8.0),
            Text('Date: ${transaction['date']}', style: TextStyle(fontSize: 18.0)),
            SizedBox(height: 8.0),
            Text('Notes: ${transaction['notes']}', style: TextStyle(fontSize: 18.0)),
          ],
        ),
      ),
    );
  }
}
