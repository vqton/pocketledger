import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/add_edit_transaction_screen.dart';
import 'screens/transaction_details_screen.dart';
import 'screens/add_edit_account_screen.dart';
import 'services/auth_service.dart';
import 'services/transaction_service.dart';
import 'services/account_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final AccountService accountService = AccountService();
  await accountService.loadAccounts();

  runApp(MyApp(accountService: accountService));
}

class MyApp extends StatelessWidget {
  final AuthService authService = AuthService();
  final TransactionService transactionService = TransactionService();
  final AccountService accountService;

  MyApp({super.key, required this.accountService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PocketLedger',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(authService: authService),
        '/register': (context) => RegisterScreen(authService: authService),
        '/dashboard': (context) => DashboardScreen(),
        '/add_transaction': (context) => AddEditTransactionScreen(
          transactionService: transactionService,
          accountService: accountService,
        ),
        '/edit_transaction': (context) => AddEditTransactionScreen(
          transactionService: transactionService,
          accountService: accountService,
          isEdit: true,
        ),
        '/add_account': (context) => AddEditAccountScreen(
          accountService: accountService,
        ),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/transaction_details') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return TransactionDetailsScreen(
                transaction: args['transaction'],
                transactionService: transactionService,
                accountService: accountService,
              );
            },
          );
        }
        return null;
      },
    );
  }
}
