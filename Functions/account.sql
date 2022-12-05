--- THIS FUNCTION IS USED TO OPPEN BANK ACCOUNTS.
CREATE
OR REPLACE FUNCTION add_customer(
    adhare_number VARCHAR(50),
    pan_number VARCHAR(50),
    NAME VARCHAR(50),
    gender gender,
    address VARCHAR(300),
    dob DATE
) RETURNS BOOLEAN LANGUAGE plpgsql AS $$
DECLARE
BEGIN
INSERT INTO
    customer(adhare_number, pan_number, NAME, gender, address, dob)
VALUES
    (adhare_number, pan_number, NAME, gender, address, dob);

RETURN TRUE;

EXCEPTION
    WHEN OTHERS THEN RAISE INFO 'Error Name:%',
    SQLERRM;

RAISE INFO 'Error State:%',
SQLSTATE;

RETURN FALSE;

END;

$$ --- CREATE AN ACCOUNT FOR THE CUSTOMER
CREATE
OR REPLACE FUNCTION add_account(
    adhare_n VARCHAR(50),
    IFSC_code VARCHAR(50),
    account_type account_type,
    balance INTEGER
) RETURNS BOOLEAN LANGUAGE plpgsql AS $$
DECLARE
    account_n bigint;

BEGIN
    IF EXISTS(
        SELECT
            C .adhare_number
        FROM
            customer C
        WHERE
            C .adhare_number = adhare_n
    ) THEN
INSERT INTO
    account(
        IFSC_code,
        account_number,
        account_type,
        balance,
        opening_date
    )
VALUES
    (
        IFSC_code,
        NEXTVAL('account_sequence'),
        account_type,
        balance,
        (
            SELECT
                CURRENT_DATE
        )
    ) RETURNING account_number INTO account_n;

INSERT INTO
    acc_cust_relation(account_holder, account_number)
VALUES
    (adhare_n, account_n);

RETURN TRUE;

ELSE RETURN FALSE;

END IF;

END;

$$