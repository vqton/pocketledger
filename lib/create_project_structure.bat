@echo off
REM Creating core directories under lib

mkdir features models services

REM Creating feature directories for each main screen functionality
cd features
mkdir onboarding auth home accounts transactions budgets goals debts notifications

REM Creating dart files in each feature directory with necessary folder structure
mkdir onboarding
echo // Onboarding screen file > onboarding\onboarding_screen.dart

mkdir auth
echo // Auth manager file > auth\auth_manager.dart
echo // Token manager file > auth\token_manager.dart
echo // Login screen file > auth\login_screen.dart

mkdir home
echo // Home screen file > home\home_screen.dart

mkdir accounts
echo // Accounts screen file > accounts\accounts_screen.dart

mkdir transactions
echo // Transactions screen file > transactions\transactions_screen.dart

mkdir budgets
echo // Budgets screen file > budgets\budgets_screen.dart

mkdir goals
echo // Goals screen file > goals\goals_screen.dart

mkdir debts
echo // Debts screen file > debts\debts_screen.dart

mkdir notifications
echo // Notifications screen file > notifications\notifications_screen.dart

REM Navigating back to lib for models and services setup
cd ..
cd models
echo // User model file > user.dart
echo // Transaction model file > transaction.dart
echo // Social account model file > social_account.dart
echo // Budget model file > budget.dart

cd ..
cd services
mkdir api database
echo // API service file > api\api_service.dart
echo // Database service file > database\database_service.dart

REM Creating assets folder structure
cd ../..
mkdir assets
cd assets
mkdir images icons

echo Project structure created successfully.
pause
