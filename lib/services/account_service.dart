import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/account.dart';
import '../models/account_type.dart';
import '../interfaces/i_account_service.dart';

class AccountService implements IAccountService {
  List<Account> _accounts = [];

  Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/accounts.json');
  }

  @override
  Future<void> loadAccounts() async {
    try {
      final file = await _getLocalFile();
      if (await file.exists()) {
        final contents = await file.readAsString();
        final List<dynamic> jsonData = json.decode(contents);
        _accounts = jsonData.map((json) => Account.fromJson(json)).toList();
      }
    } catch (e) {
      print('Error loading accounts: $e');
    }
  }

  @override
  Future<void> saveAccounts() async {
    try {
      final file = await _getLocalFile();
      final jsonData = _accounts.map((account) => account.toJson()).toList();
      await file.writeAsString(json.encode(jsonData));
    } catch (e) {
      print('Error saving accounts: $e');
    }
  }

  @override
  List<Account> getAccounts() {
    return _accounts;
  }

  @override
  void addAccount(Account account) {
    _accounts.add(account);
    saveAccounts();
  }

  @override
  void updateAccount(String id, Account updatedAccount) {
    final index = _accounts.indexWhere((account) => account.id == id);
    if (index != -1) {
      _accounts[index] = updatedAccount;
      saveAccounts();
    }
  }

  @override
  void deleteAccount(String id) {
    _accounts.removeWhere((account) => account.id == id);
    saveAccounts();
  }

  List<Account> get accounts => _accounts;
}
