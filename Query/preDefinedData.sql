INSERT INTO
    area (pin_code, state, district)
VALUES
    (380058, 'Gujarat', 'Ahmedabad'),
    (382160, 'Gujarat', 'Ahmedabad');

INSERT INTO
    branch(pin_code, IFSC_code, branch_name, address)
VALUES
    (
        380058,
        'BOBBOPAL67',
        'BankOfBarodaBopal',
        'Plot No. 5, Vruj Vihar Society, Shri Hari House, Ahmedabad, Gujarat 380058'
    );

INSERT INTO
    employee(
        IFSC_code,
        NAME,
        address,
        pan_number,
        adhare_number,
        salary,
        bob,
        date_of_joining,
        gender
    )
VALUES
    (
        'BOBBOPAL67',
        'devdutt',
        '73 dev darshan tenament, Near JB park, Opp sterling city, Bopal Ahmedabad',
        'BNZPF2501F',
        '000032418907',
        50000,
        '1995-08-13',
        '2015-01-01',
        'male'
    ),
    (
        'BOBBOPAL67',
        'devanshu',
        '89 shyamal villa, Opp garden pelace, sindhu bhavan road,Ahmedabad',
        'KCRI345OZ9',
        '123459903323',
        90000,
        '1990-08-13',
        '2011-12-01',
        'male'
    );

INSERT INTO
    account_type_details(
        account_type,
        interest_rate,
        account_management_charges
    )
VALUES
    ('saving', 2.5, 0),
    ('current', 0, 1500);

-- Creating Bank account with 1cr defualt.
INSERT INTO
    account(
        IFSC_code,
        account_number,
        account_type,
        balance,
        opening_date,
        bank_internal_account
    )
VALUES
    (
        'BOBBOPAL67',
        NEXTVAL('account_sequence'),
        'saving',
        10000000,
        (
            SELECT
                CURRENT_DATE
        ),
        TRUE
    );