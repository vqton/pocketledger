import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'add_edit_transaction_screen.dart';
import 'transaction_details_screen.dart';
import 'add_edit_account_screen.dart';
import 'account_list_screen.dart';
import '../services/transaction_service.dart';
import '../services/account_service.dart';

class DashboardScreen extends StatelessWidget {
  final TransactionService transactionService = TransactionService();
  final AccountService accountService = AccountService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Ledger Dashboard'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('John Doe'),
              accountEmail: Text('john.doe@example.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://example.com/profile.jpg'),
              ),
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/dashboard');
              },
            ),
            ExpansionTile(
              leading: FaIcon(FontAwesomeIcons.exchangeAlt),
              title: Text('Transactions'),
              children: <Widget>[
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.plusCircle),
                  title: Text('Add Transaction'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEditTransactionScreen(
                          transactionService: transactionService,
                          accountService: accountService,
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.list),
                  title: Text('View Transactions'),
                  onTap: () {
                    // Navigate to view transactions screen
                  },
                ),
              ],
            ),
            ExpansionTile(
              leading: FaIcon(FontAwesomeIcons.wallet),
              title: Text('Accounts'),
              children: <Widget>[
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.plusCircle),
                  title: Text('Add Account'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEditAccountScreen(
                          accountService: accountService,
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.list),
                  title: Text('View Accounts'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AccountListScreen(
                          accountService: accountService,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.chartLine),
              title: Text('Reports'),
              onTap: () {
                // Navigate to view reports screen
              },
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.cog),
              title: Text('Settings'),
              onTap: () {
                // Navigate to settings screen
              },
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.questionCircle),
              title: Text('Help & Support'),
              onTap: () {
                // Navigate to help & support screen
              },
            ),
            Divider(),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.signOutAlt),
              title: Text('Logout'),
              onTap: () {
                // Handle logout
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Balance Overview
              Card(
                child: ListTile(
                  leading: FaIcon(FontAwesomeIcons.wallet), // Balance icon
                  title: Text('Total Balance'),
                  subtitle: Text('\$12,345.67'),
                ),
              ),
              SizedBox(height: 16.0),
              
              // Recent Transactions
              Text(
                'Recent Transactions',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Card(
                child: ListTile(
                  leading: FaIcon(FontAwesomeIcons.shoppingCart), // Transaction icon
                  title: Text('Grocery Shopping'),
                  subtitle: Text('- \$123.45'),
                  trailing: Text('Nov 6, 2024'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransactionDetailsScreen(
                          transaction: {
                            'id': '1',
                            'title': 'Grocery Shopping',
                            'amount': 123.45,
                            'category': 'Groceries',
                            'date': 'Nov 6, 2024',
                            'notes': 'Bought groceries for the week',
                          },
                          transactionService: transactionService,
                          accountService: accountService,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: FaIcon(FontAwesomeIcons.moneyBill), // Transaction icon
                  title: Text('Salary'),
                  subtitle: Text('+ \$2,000.00'),
                  trailing: Text('Nov 5, 2024'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransactionDetailsScreen(
                          transaction: {
                            'id': '2',
                            'title': 'Salary',
                            'amount': 2000.00,
                            'category': 'Income',
                            'date': 'Nov 5, 2024',
                            'notes': 'Monthly salary',
                          },
                          transactionService: transactionService,
                          accountService: accountService,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: FaIcon(FontAwesomeIcons.lightbulb), // Transaction icon
                  title: Text('Electricity Bill'),
                  subtitle: Text('- \$67.89'),
                  trailing: Text('Nov 4, 2024'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransactionDetailsScreen(
                          transaction: {
                            'id': '3',
                            'title': 'Electricity Bill',
                            'amount': 67.89,
                            'category': 'Utilities',
                            'date': 'Nov 4, 2024',
                            'notes': 'Monthly electricity bill',
                          },
                          transactionService: transactionService,
                          accountService: accountService,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16.0),
              
              // Quick Actions
              Text(
                'Quick Actions',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: [
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.plusCircle), // Add transaction icon
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEditTransactionScreen(
                                transactionService: transactionService,
                                accountService: accountService,
                              ),
                            ),
                          );
                        },
                      ),
                      Text('Add Transaction'),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.chartLine), // View reports icon
                        onPressed: () {
                          // Navigate to view reports screen
                        },
                      ),
                      Text('View Reports'),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.cog), // Settings icon
                        onPressed: () {
                          // Navigate to settings screen
                        },
                      ),
                      Text('Settings'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
