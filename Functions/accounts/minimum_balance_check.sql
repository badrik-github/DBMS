CREATE OR REPLACE FUNCTION minimum_account_charges() RETURNS BOOLEAN LANGUAGE plpgsql AS $$
DECLARE
    t_row RECORD;
    bank_account_number BIGINT;
BEGIN

    SELECT account_number FROM account WHERE bank_internal_account=TRUE INTO bank_account_number;

    FOR t_row in (SELECT * FROM account WHERE account_type='saving' AND balance < 1000)
    LOOP

        UPDATE account SET balance = balance - 25 WHERE account_number = t_row.account_number;      

        UPDATE account SET balance = balance + 25 WHERE account_number = bank_account_number;

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
                25,
                t_row.account_number,
                bank_account_number,
                true,
                'Saving account balance below limit'
            );

    END LOOP;

END;
$$