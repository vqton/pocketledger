-- User table for storing user account details
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password_hash VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for linking users with social accounts (Google, Facebook)
CREATE TABLE SocialAccounts (
    social_account_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    provider ENUM('Google', 'Facebook'),
    provider_user_id VARCHAR(255), -- ID from Google/Facebook
    email VARCHAR(100),
    access_token VARCHAR(255),
    refresh_token VARCHAR(255),
    token_expiry TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Token table for managing user login sessions
CREATE TABLE Tokens (
    token_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    access_token VARCHAR(255),
    refresh_token VARCHAR(255),
    token_expiry TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);


CREATE TABLE Accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    name VARCHAR(100),
    type ENUM('Cash', 'Bank', 'Credit'),
    balance DECIMAL(15, 2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT,
    type ENUM('Income', 'Expense'),
    category VARCHAR(50),
    amount DECIMAL(15, 2),
    date DATE,
    description TEXT,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

CREATE TABLE Budgets (
    budget_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    category VARCHAR(50),
    limit_amount DECIMAL(15, 2),
    spent_amount DECIMAL(15, 2) DEFAULT 0,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Goals (
    goal_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    name VARCHAR(100),
    target_amount DECIMAL(15, 2),
    saved_amount DECIMAL(15, 2) DEFAULT 0,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE DebtsLoans (
    debt_loan_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    type ENUM('Debt', 'Loan'),
    amount DECIMAL(15, 2),
    remaining_amount DECIMAL(15, 2),
    start_date DATE,
    due_date DATE,
    description TEXT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Notifications (
    notification_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    type VARCHAR(50),
    content TEXT,
    sent_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
