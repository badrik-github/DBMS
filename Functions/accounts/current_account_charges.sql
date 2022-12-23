CREATE OR REPLACE FUNCTION current_account_charges() RETURNS BOOLEAN LANGUAGE plpgsql AS $$
DECLARE
    t_row RECORD;
    bank_account_number BIGINT;
BEGIN

    SELECT account_number FROM account WHERE bank_internal_account=TRUE INTO bank_account_number;

    FOR t_row in (SELECT * FROM account WHERE account_type='current')
    LOOP

        UPDATE account SET balance = balance - 1500 WHERE account_number = t_row.account_number;      

        UPDATE account SET balance = balance + 1500 WHERE account_number = bank_account_number;

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
                1500,
                t_row.account_number,
                bank_account_number,
                true,
                'Current Account Charges'
            );

    END LOOP;

END;
$$