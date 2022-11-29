CREATE TABLE IF NOT EXISTS area(
    pin_code integer PRIMARY KEY,
    state varchar(50) NOT NULL,
    district varchar(50) NOT NULL
)

CREATE TABLE IF NOT EXISTS branch(
    pin_code integer NOT NULL,
    IFSC_code varchar(50) PRIMARY KEY,
    branch_name varchar(50) NOT NULL,
    address varchar(50) NOT NULL,

    CONSTRAINT branch_in_area
    FOREIGN KEY(pin_code) 
    REFERENCES area(pin_code)
)

CREATE TABLE IF NOT EXISTS employee(
    IFSC_code varchar(50) NOT NULL,
    employee_id serial PRIMARY KEY,
    name varchar(50) NOT NULL,
    address varchar(50) NOT NULL,
    pan_number varchar(50) UNIQUE NOT NULL,
    adhare_number integer UNIQUE NOT NULL,
    salary integer NOT NULL,
    dob date NOT NULL,
    date_of_joining date NOT NULL,
    gender gender NOT NULL,

    CONSTRAINT employee_of_branch
    FOREIGN KEY(IFSC_code) 
    REFERENCES branch(IFSC_code)
)

CREATE TABLE IF NOT EXISTS account_type_details(
    account_type account_type PRIMARY KEY,
    interest_rate integer NOT NULL,
    account_management_charges integer   
)

CREATE SEQUENCE account_sequence
  start 10000000000
  increment 1;

CREATE TABLE IF NOT EXISTS account(
    IFSC_code varchar(50) NOT NULL,
    account_number integer PRIMARY KEY,
    account_type account_type NOT NULL,
    balance integer DEFAULT 0,
    opening_date date NOT NULL,
    account_freezed boolean NOT NULL DEFAULT false,

    CONSTRAINT account_in_branch
    FOREIGN KEY(IFSC_code) 
    REFERENCES branch(IFSC_code),

    CONSTRAINT account_type_relation
    FOREIGN KEY(account_type) 
    REFERENCES account_type_details(account_type),
)

CREATE TABLE IF NOT EXISTS account_interest(
    account_number integer NOT NULL,
    account_balance_snap integer NOT NULL,
    calculated_rate integer NOT NULL,
    interested_amount integer NOT NULL,
    is_deposited boolean DEFAULT false,
    transaction_id integer NOT NULL,
    calculated_date date NOT NULL,

    CONSTRAINT account_interest_relation
    FOREIGN KEY(account_number) 
    REFERENCES account(account_number),

)

CREATE TABLE IF NOT EXISTS customer(
    adhare_number integer PRIMARY KEY,
    pan_number varchar(50) UNIQUE NOT NULL,
    name varchar(50) NOT NULL,
    gender gender NOT NULL,
    address varchar(50) NOT NULL,
    dob date NOT NULL
)

CREATE TABLE IF NOT EXISTS acc_cust_relation(
    account_holder integer NOT NULL,
    account_number integer NOT NULL,

    PRIMARY KEY(account_number,account_holder),

    CONSTRAINT account_of_customer
    FOREIGN KEY(account_holder) 
    REFERENCES customer(adhare_number),

    CONSTRAINT is_owner_of
    FOREIGN KEY(account_number) 
    REFERENCES account(account_number)
)

CREATE SEQUENCE transaction_sequence
  start 100000000000
  increment 1;

CREATE TABLE IF NOT EXISTS transactions(
    transaction_id integer PRIMARY KEY,
    amount_transfered integer NOT NULL,
    sender_account_number integer NOT NULL,
    receiver_account_number integer,
    transaction_type transaction_type NOT NULL,
    transaction_status boolean NOT NULL,
    transaction_time timestamptz DEFAULT NOW() NOT NULL,

    CONSTRAINT sender_transaction_link
    FOREIGN KEY(sender_account_number) 
    REFERENCES account(account_number),

    CONSTRAINT receiver_transaction_link
    FOREIGN KEY(receiver_account_number) 
    REFERENCES account(account_number)
)

CREATE TABLE IF NOT EXISTS loan(
    account_number integer NOT NULL,
    loan_id integer NOT NULL PRIMARY KEY,
    amount integer NOT NULL, 
    loan_type loan_type NOT NULL,
    emi integer NOT NULL,
    state_date date NOT NULL,
    transfer_transaction_id integer NOT NULL,
    duration_in_years integer NOT NULL,
    closed boolean NOT NULL,

    CONSTRAINT loan_account_relation
    FOREIGN KEY(account_number) 
    REFERENCES account(account_number),

    CONSTRAINT loan_type_relation
    FOREIGN KEY(loan_type) 
    REFERENCES loan_type_details(loan_type)
)

CREATE TABLE IF NOT EXISTS loan_type_details(
    loan_type loan_type PRIMARY KEY,
    interest_rate integer,
    pre_payment_charges integer
)

CREATE TABLE IF NOT EXISTS loan_payments(
    transaction_id integer PRIMARY KEY,
    amount integer NOT NULL,
    loan_id integer NOT NULL,
    date_of_payment date NOT NULL,

    CONSTRAINT loan_payment_relation
    FOREIGN KEY(loan_id) 
    REFERENCES laon(loan_id)
)


CREATE TABLE IF NOT EXISTS fixed_deposit(
    account_number integer NOT NULL,
    id integer PRIMARY KEY,
    amount integer NOT NULL,
    interest_rate integer NOT NULL,
    period_in_years integer NOT NULL,
    closed boolean NOT NULL

    CONSTRAINT fd_account_relation
    FOREIGN KEY(account_number) 
    REFERENCES account(account_number)
)

CREATE TABLE IF NOT EXISTS fd_interest(
    id integer,
    interest_amount integer NOT NULL,

    CONSTRAINT fd_interest_relation
    FOREIGN KEY(id) 
    REFERENCES fixed_deposit(id)
)