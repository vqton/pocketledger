import 'account_type.dart';

class Account {
  final String id;
  final String name;
  final double balance;
  final AccountType type;

  Account({required this.id, required this.name, required this.balance, required this.type});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'balance': balance,
      'type': type.toString().split('.').last, // Store the enum as a string
    };
  }

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      name: json['name'],
      balance: json['balance'],
      type: AccountType.values.firstWhere((e) => e.toString().split('.').last == json['type']),
    );
  }
}
