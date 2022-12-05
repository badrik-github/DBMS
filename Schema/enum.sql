DO $$
BEGIN
    CREATE TYPE gender AS ENUM('male', 'female', 'other');

EXCEPTION
    WHEN duplicate_object THEN NULL;

END $$;

DO $$
BEGIN
    CREATE TYPE account_type AS ENUM('saving', 'current');

EXCEPTION
    WHEN duplicate_object THEN NULL;

END $$;

DO $$
BEGIN
    CREATE TYPE loan_type AS ENUM('fixed', 'variable');

EXCEPTION
    WHEN duplicate_object THEN NULL;

END $$;

DO $$
BEGIN
    CREATE TYPE transaction_type AS ENUM('debit', 'credit');

EXCEPTION
    WHEN duplicate_object THEN NULL;

END $$;