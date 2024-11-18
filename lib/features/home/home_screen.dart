import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'widgets/profile_section.dart';
import 'widgets/account_overview.dart';
import 'widgets/quick_actions.dart';
import 'widgets/recent_transactions.dart';
import 'widgets/spending_summary.dart';
import 'widgets/goals_savings.dart';
import 'widgets/promotional_banners.dart';

class HomeScreen extends StatefulWidget {
  final GoogleSignInAccount user;

  HomeScreen({required this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home'),
    Text('Accounts'),
    Text('Transactions'),
    Text('Budget'),
    Text('Goals'),
    Text('Profile'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        // Navigate to Accounts screen
        Navigator.pushNamed(context, '/accounts');
        break;
      case 2:
        // Navigate to Transactions screen
        break;
      case 3:
        Navigator.pushNamed(context, '/budgets'); // Navigate to Budget screen
        break;
      case 4:
        Navigator.pushNamed(context, '/goals');
        break;
      case 5:
        // Navigate to Profile screen
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pocket Ledger'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileSection(user: widget.user),
            AccountOverview(),
            QuickActions(),
            RecentTransactions(),
            SpendingSummary(),
            GoalsSavings(),
            PromotionalBanners(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Quick access to add transaction
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.savings),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
