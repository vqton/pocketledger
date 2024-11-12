@echo off

REM Core application components
mkdir lib\core
mkdir lib\core\config
mkdir lib\core\constants
mkdir lib\core\themes
mkdir lib\core\utils

REM Main features of the application
mkdir lib\features
mkdir lib\features\accounts
mkdir lib\features\transactions
mkdir lib\features\budgets
mkdir lib\features\goals
mkdir lib\features\debts_loans
mkdir lib\features\notifications

REM Data models (e.g., User, Account, Transaction)
mkdir lib\models

REM Service layer for logic processing and syncing
mkdir lib\services

REM Application entry point
type nul > lib\main.dart

REM Notify user of directory structure creation
echo Project directory structure has been successfully created.
