--- THIS FUNCTION IS USED TO calculate saving account interest.
CREATE
OR REPLACE FUNCTION calculate_saving_account_interest() RETURNS VOID LANGUAGE plpgsql AS $$
DECLARE
    t_row account % ROWTYPE;

interest_of_day INTEGER;

number_of_days INTEGER;

current_date DATE;

last_day_of_month DATE;

BEGIN
SELECT
    now() INTO current_date;

SELECT
    date_part(
        'days',
        (
            date_trunc('month', current_date) + INTERVAL '1 month - 1 day'
        )
    ) INTO number_of_days;

SELECT
    date_trunc('month', now()) + INTERVAL '1 month - 1 day' INTO last_day_of_month;

FOR t_row IN
SELECT
    *
FROM
    account
WHERE
    bank_internal_account = FALSE
    AND account_type = 'saving'
LOOP
    interest_of_day = (t_row.balance * 2.5) / (100 * number_of_days);

INSERT INTO
    account_interest (
        account_number,
        account_balance_snap,
        calculated_rate,
        interested_amount,
        is_deposited,
        calculated_date
    )
VALUES
    (
        t_row.account_number,
        t_row.balance,
        2.5,
        interest_of_day,
        FALSE,
        now()
    );

END
LOOP
;

EXCEPTION
    WHEN OTHERS THEN RAISE INFO 'Error Name:%',
    SQLERRM;

RAISE INFO 'Error State:%',
SQLSTATE;

END;

$$