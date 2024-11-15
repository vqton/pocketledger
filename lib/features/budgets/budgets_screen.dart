import 'package:flutter/material.dart';

class BudgetScreen extends StatefulWidget {
  @override
  _BudgetScreenState createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  List<Map<String, dynamic>> budgets = [
    {"category": "Groceries", "amount": 500.0, "spent": 300.0},
    {"category": "Entertainment", "amount": 200.0, "spent": 150.0},
    {"category": "Utilities", "amount": 100.0, "spent": 80.0},
  ];

  int _selectedIndex = 3;

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
        break;
      case 2:
        // Navigate to Transactions screen
        break;
      case 3:
        // Already on Budget screen
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
        title: Text('Budget Management'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBudgetSummary(),
            SizedBox(height: 20),
            _buildBudgetList(),
            SizedBox(height: 20),
            _buildAddBudgetButton(),
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
      ),
    );
  }

  Widget _buildBudgetSummary() {
    double totalBudget = budgets.fold(0, (sum, item) => sum + item['amount']);
    double totalSpent = budgets.fold(0, (sum, item) => sum + item['spent']);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Budget Summary",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSummaryItem("Total Budget", "\$$totalBudget"),
              _buildSummaryItem("Total Spent", "\$$totalSpent"),
              _buildSummaryItem("Remaining", "\$${totalBudget - totalSpent}"),
            ],
          ),
          SizedBox(height: 10),
          Container(
            height: 100,
            child: Placeholder(), // Replace with actual chart widget
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String title, String amount) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 5),
        Text(
          amount,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildBudgetList() {
    return Expanded(
      child: ListView.builder(
        itemCount: budgets.length,
        itemBuilder: (context, index) {
          return _buildBudgetItem(budgets[index]);
        },
      ),
    );
  }

  Widget _buildBudgetItem(Map<String, dynamic> budget) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(budget['category']),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: budget['spent'] / budget['amount'],
              backgroundColor: Colors.grey[300],
              color: Colors.teal,
            ),
            SizedBox(height: 5),
            Text(
              "Spent: \$${budget['spent']} / Budget: \$${budget['amount']}",
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            // Edit budget
          },
        ),
      ),
    );
  }

  Widget _buildAddBudgetButton() {
    return ElevatedButton(
      onPressed: () {
        // Add new budget
      },
      child: Text("Add New Budget"),
    );
  }
}
