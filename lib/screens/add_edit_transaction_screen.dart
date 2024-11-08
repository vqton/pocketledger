import 'package:flutter/material.dart';
import '../models/account.dart';
import '../services/transaction_service.dart';
import '../services/account_service.dart';

class AddEditTransactionScreen extends StatefulWidget {
  final bool isEdit;
  final Map<String, dynamic>? transaction;
  final TransactionService transactionService;
  final AccountService accountService;

  AddEditTransactionScreen(
      {this.isEdit = false,
      this.transaction,
      required this.transactionService,
      required this.accountService});

  @override
  _AddEditTransactionScreenState createState() =>
      _AddEditTransactionScreenState();
}

class _AddEditTransactionScreenState extends State<AddEditTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late double _amount;
  late String _category;
  late DateTime _date;
  late String _notes;
  late String _accountId;
  List<Account> _accounts = []; // Update the type to List<Account>
// Update the type to List<Account>

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.transaction != null) {
      _title = widget.transaction!['title'];
      _amount = widget.transaction!['amount'];
      _category = widget.transaction!['category'];
      _date = widget.transaction!['date'];
      _notes = widget.transaction!['notes'];
      _accountId = widget.transaction!['accountId'];
    } else {
      _title = '';
      _amount = 0.0;
      _category = '';
      _date = DateTime.now();
      _notes = '';
      _accountId = '';
    }
    _fetchAccounts();
  }

  Future<void> _fetchAccounts() async {
    final accounts = await widget.accountService.getAccounts();
    setState(() {
      _accounts = accounts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Edit Transaction' : 'Add Transaction'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: _title,
                  decoration: InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _title = value!;
                  },
                ),
                TextFormField(
                  initialValue: _amount.toString(),
                  decoration: InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an amount';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _amount = double.parse(value!);
                  },
                ),
                TextFormField(
                  initialValue: _category,
                  decoration: InputDecoration(labelText: 'Category'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a category';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _category = value!;
                  },
                ),
                TextFormField(
                  initialValue: _notes,
                  decoration: InputDecoration(labelText: 'Notes'),
                  onSaved: (value) {
                    _notes = value!;
                  },
                ),
                DropdownButtonFormField<String>(
                  value: _accountId.isNotEmpty ? _accountId : null,
                  decoration: InputDecoration(labelText: 'Account'),
                  items: _accounts.map((account) {
                    return DropdownMenuItem<String>(
                      value: account.id,
                      child: Text(account.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _accountId = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an account';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _accountId = value!;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final transactionData = {
                        'title': _title,
                        'amount': _amount,
                        'category': _category,
                        'date': _date,
                        'notes': _notes,
                        'accountId': _accountId,
                      };
                      if (widget.isEdit) {
                        await widget.transactionService
                            .editTransaction(transactionData);
                      } else {
                        await widget.transactionService
                            .addTransaction(transactionData);
                      }
                      Navigator.pop(context);
                    }
                  },
                  child:
                      Text(widget.isEdit ? 'Save Changes' : 'Add Transaction'),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
