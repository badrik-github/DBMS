CREATE TABLE IF NOT EXISTS area(
    pin_code INTEGER PRIMARY KEY,
    state VARCHAR(50) NOT NULL,
    district VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS branch(
    pin_code INTEGER NOT NULL,
    IFSC_code VARCHAR(50) PRIMARY KEY,
    branch_name VARCHAR(50) NOT NULL,
    address VARCHAR(400) NOT NULL,
    CONSTRAINT branch_in_area FOREIGN KEY(pin_code) REFERENCES area(pin_code)
);

--ALTER TABLE
--ALTER TABLE branch ALTER COLUMN address TYPE varchar(400);
CREATE TABLE IF NOT EXISTS employee(
    IFSC_code VARCHAR(50) NOT NULL,
    employee_id serial PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL,
    address VARCHAR(400) NOT NULL,
    pan_number VARCHAR(50) UNIQUE NOT NULL CHECK (LENGTH(pan_number) = 10),
    adhare_number VARCHAR UNIQUE NOT NULL CHECK (LENGTH(adhare_number) = 12),
    salary INTEGER NOT NULL,
    dob DATE NOT NULL,
    date_of_joining DATE NOT NULL,
    gender gender NOT NULL,
    CONSTRAINT employee_of_branch FOREIGN KEY(IFSC_code) REFERENCES branch(IFSC_code)
);

CREATE TABLE IF NOT EXISTS account_type_details(
    account_type account_type PRIMARY KEY,
    interest_rate DECIMAL NOT NULL,
    account_management_charges INTEGER
);

-- Sequence is used in account number to create a 11 digit account number
CREATE SEQUENCE IF NOT EXISTS account_sequence START 10000000000 increment 1;

CREATE TABLE IF NOT EXISTS account(
    IFSC_code VARCHAR(50) NOT NULL,
    account_number bigint PRIMARY KEY,
    account_type account_type NOT NULL,
    balance DECIMAL DEFAULT 0,
    opening_date DATE NOT NULL,
    account_freezed BOOLEAN NOT NULL DEFAULT FALSE,
    bank_internal_account BOOLEAN NOT NULL DEFAULT FALSE,
    CONSTRAINT account_in_branch FOREIGN KEY(IFSC_code) REFERENCES branch(IFSC_code),
    CONSTRAINT account_type_relation FOREIGN KEY(account_type) REFERENCES account_type_details(account_type)
);

CREATE TABLE IF NOT EXISTS account_interest(
    account_number bigint NOT NULL,
    account_balance_snap DECIMAL NOT NULL,
    calculated_rate DECIMAL NOT NULL,
    interested_amount DECIMAL NOT NULL,
    is_deposited BOOLEAN DEFAULT FALSE,
    transaction_id bigint,
    calculated_date DATE NOT NULL,
    CONSTRAINT account_interest_relation FOREIGN KEY(account_number) REFERENCES account(account_number)
);

CREATE TABLE IF NOT EXISTS customer(
    adhare_number VARCHAR(50) PRIMARY KEY CHECK (LENGTH(adhare_number) = 12),
    pan_number VARCHAR(50) UNIQUE NOT NULL CHECK (LENGTH(pan_number) = 10),
    NAME VARCHAR(50) NOT NULL,
    gender gender NOT NULL,
    address VARCHAR(300) NOT NULL,
    dob DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS acc_cust_relation(
    account_holder VARCHAR(50) NOT NULL,
    account_number bigint NOT NULL,
    PRIMARY KEY(account_number, account_holder),
    CONSTRAINT account_of_customer FOREIGN KEY(account_holder) REFERENCES customer(adhare_number),
    CONSTRAINT is_owner_of FOREIGN KEY(account_number) REFERENCES account(account_number)
);

CREATE SEQUENCE IF NOT EXISTS transaction_sequence START 100000000000 increment 1;

CREATE TABLE IF NOT EXISTS transactions(
    transaction_id bigint PRIMARY KEY,
    amount_transfered DECIMAL NOT NULL,
    sender_account_number BIGINT NOT NULL,
    receiver_account_number BIGINT,
    transaction_status BOOLEAN NOT NULL,
    transaction_comments VARCHAR(500),
    transaction_time timestamptz DEFAULT NOW() NOT NULL,
    CONSTRAINT sender_transaction_link FOREIGN KEY(sender_account_number) REFERENCES account(account_number),
    CONSTRAINT receiver_transaction_link FOREIGN KEY(receiver_account_number) REFERENCES account(account_number)
);

CREATE TABLE IF NOT EXISTS loan_type_details(
    loan_type loan_type PRIMARY KEY,
    interest_rate INTEGER,
    pre_payment_charges INTEGER
);

CREATE TABLE IF NOT EXISTS loan(
    account_number INTEGER NOT NULL,
    loan_id INTEGER NOT NULL PRIMARY KEY,
    amount DECIMAL NOT NULL,
    loan_type loan_type NOT NULL,
    emi INTEGER NOT NULL,
    state_date DATE NOT NULL,
    transfer_transaction_id bigint NOT NULL,
    duration_in_years INTEGER NOT NULL,
    closed BOOLEAN NOT NULL,
    CONSTRAINT loan_account_relation FOREIGN KEY(account_number) REFERENCES account(account_number),
    CONSTRAINT loan_type_relation FOREIGN KEY(loan_type) REFERENCES loan_type_details(loan_type)
);

CREATE TABLE IF NOT EXISTS loan_payments(
    transaction_id bigint PRIMARY KEY,
    amount INTEGER NOT NULL,
    loan_id INTEGER NOT NULL,
    date_of_payment DATE NOT NULL,
    CONSTRAINT loan_payment_relation FOREIGN KEY(loan_id) REFERENCES loan(loan_id)
);

CREATE TABLE IF NOT EXISTS fixed_deposit(
    account_number INTEGER NOT NULL,
    id INTEGER PRIMARY KEY,
    amount DECIMAL NOT NULL,
    interest_rate INTEGER NOT NULL,
    period_in_years INTEGER NOT NULL,
    closed BOOLEAN NOT NULL,
    CONSTRAINT fd_account_relation FOREIGN KEY(account_number) REFERENCES account(account_number)
);

CREATE TABLE IF NOT EXISTS fd_interest(
    id INTEGER,
    interest_amount INTEGER NOT NULL,
    CONSTRAINT fd_interest_relation FOREIGN KEY(id) REFERENCES fixed_deposit(id)
);