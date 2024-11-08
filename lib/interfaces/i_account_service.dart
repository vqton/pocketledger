import '../models/account.dart';

abstract class IAccountService {
  Future<void> loadAccounts();
  Future<void> saveAccounts();
  List<Account> getAccounts();
  void addAccount(Account account);
  void updateAccount(String id, Account updatedAccount);
  void deleteAccount(String id);
}
