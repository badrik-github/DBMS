CREATE OR REPLACE FUNCTION deduct_emi() RETURNS BOOLEAN LANGUAGE plpgsql AS $$
DECLARE
    t_row RECORD;
    temp_base_amount DECIMALS;
    temp_interest_amount DECIMALS;
    bank_account_number BIGINT;
    transfer_transaction_id BIGINT;
BEGIN

    SELECT account_number FROM account WHERE bank_internal_account=TRUE INTO bank_account_number;

    FOR t_row in (SELECT * FROM loan as L LEFT JOIN loan_type_details as D ON L.loan_type = D.loan_type WHERE L.closed = FALSE)
    LOOP

        temp_interest_amount = (t_row.remaining_amount * ((t_row.interest_rate/12)/100))        
        temp_interest_amount = ROUND(temp_interest_amount,2);

        temp_base_amount = t_row.emi - interest_amount;
        temp_base_amount = ROUND(temp_base_amount,2);

        UPDATE account SET balance = balance - t_row.emi WHERE account_number = t_row.account_number;      

        UPDATE account SET balance = balance + t_row.emi WHERE account_number = bank_account_number;

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
                t_row.emi,
                t_row.account_number,
                bank_account_number,
                true,
                'Laon EMI'
            ) RETURNING transaction_id INTO transfer_transaction_id;

        
        INSERT INTO 
            loan_payments(
                transaction_id,
                base_amount,
                interest_amount,
                loan_id,
                date_of_payment
            )
        VALUES
            (
                transfer_transaction_id,
                temp_base_amount,
                temp_interest_amount,
                t_row.loan_id,
                SELECT(
                    CURRENT_DATE
                )
            );
    END LOOP;

END;
$$