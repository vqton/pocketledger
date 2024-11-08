import 'package:flutter/material.dart';
import '../services/account_service.dart';
import '../models/account.dart';
import '../models/account_type.dart';

class AddEditAccountScreen extends StatefulWidget {
  final bool isEdit;
  final Account? account;
  final AccountService accountService;

  AddEditAccountScreen({this.isEdit = false, this.account, required this.accountService});

  @override
  _AddEditAccountScreenState createState() => _AddEditAccountScreenState();
}

class _AddEditAccountScreenState extends State<AddEditAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late double _balance;
  late AccountType _type;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.account != null) {
      _name = widget.account!.name;
      _balance = widget.account!.balance;
      _type = widget.account!.type;
    } else {
      _name = '';
      _balance = 0.0;
      _type = AccountType.checking;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Edit Account' : 'Add Account'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Account Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an account name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                initialValue: _balance.toString(),
                decoration: InputDecoration(labelText: 'Initial Balance'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an initial balance';
                  }
                  return null;
                },
                onSaved: (value) {
                  _balance = double.parse(value!);
                },
              ),
              DropdownButtonFormField<AccountType>(
                value: _type,
                decoration: InputDecoration(labelText: 'Account Type'),
                items: AccountType.values.map((AccountType type) {
                  return DropdownMenuItem<AccountType>(
                    value: type,
                    child: Text(type.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (AccountType? newValue) {
                  setState(() {
                    _type = newValue!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select an account type';
                  }
                  return null;
                },
                onSaved: (value) {
                  _type = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.isEdit ? 'Update' : 'Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final accountData = Account(
        id: widget.isEdit ? widget.account!.id : DateTime.now().toString(),
        name: _name,
        balance: _balance,
        type: _type,
      );

      if (widget.isEdit) {
        widget.accountService.updateAccount(accountData.id, accountData);
      } else {
        widget.accountService.addAccount(accountData);
      }

      Navigator.of(context).pop();
    }
  }
}
