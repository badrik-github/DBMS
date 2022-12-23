CREATE OR REPLACE FUNCTION add_loan(
    request_account_number BIGINT,
    amount DECIMAL,
    period_in_years INTEGER,
    loan_type_selected loan_type
) RETURNS BOOLEAN LANGUAGE plpgsql AS $$
DECLARE
    month INTEGER;
    emi DECIMAL;
    temp_account_number BIGINT;
    per_month_interest DECIMAL;
    _interest_rate DECIMAL;
    transfer_transaction_id BIGINT;
BEGIN

    -- Find the the internal bank account
    SELECT
        account_number
    FROM
        account
    WHERE
        bank_internal_account = TRUE INTO temp_account_number;

    SELECT interest_rate FROM loan_type_details WHERE loan_type = loan_type_selected INTO _interest_rate;

    per_month_interest = (_interest_rate / 100) / 12;  

    month = period_in_years * 12;

    emi = amount *  (per_month_interest * (( 1 + per_month_interest)^month))/ ((( 1 + per_month_interest)^month) - 1);
    
    emi = ROUND(emi,2);

    UPDATE account SET balance = balance - amount WHERE account_number = temp_account_number;

    UPDATE account SET balance = balance + amount WHERE account_number = request_account_number;

    INSERT INTO 
        transactions(
            transaction_id,
            amount_transfered,
            sender_account_number,
            receiver_account_number,
            transaction_status,
            transaction_comments
        ) 
    VALUES
        (   
            NEXTVAL('transaction_sequence'),
            amount,
            temp_account_number,
            request_account_number,
            true,
            'Loan approved and transfered to account'
        ) RETURNING transaction_id INTO transfer_transaction_id;

    INSERT INTO 
        loan(
            account_number,
            loan_id,
            amount,
            remaining_amount,
            loan_type,
            emi,
            start_date,
            transfer_transaction_id,
            duration_in_years,
            closed
        )
    VALUES
        (
            request_account_number,
            NEXTVAL('loan_sequence'),
            amount,
            amount,
            loan_type_selected,
            emi,
            (
                SELECT
                    CURRENT_DATE
            ),
            transfer_transaction_id,
            period_in_years,
            FALSE
        );
    
    RETURN TRUE;

EXCEPTION
    WHEN OTHERS THEN RAISE INFO 'Error Name:%',
    SQLERRM;

RAISE INFO 'Error State:%',
SQLSTATE;

END;
$$