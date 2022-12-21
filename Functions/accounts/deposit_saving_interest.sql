--- THIS FUNCTION IS USED TO DEPOSIT THE COLLECTED SAVING ACCOUNT INTEREST.
CREATE
OR REPLACE FUNCTION deposit_saving_interest() RETURNS VOID LANGUAGE plpgsql AS $$

DECLARE
    -- Declare t_row variable to iterate over table
    t_row RECORD;
    temp_account_number bigint;
    temp_transaction_id bigint;
    
-- Start the function 
BEGIN
    -- Find the the internal bank account
    SELECT
        account_number
    FROM
        account
    WHERE
        bank_internal_account = TRUE INTO temp_account_number;

    --Sum up total interest based ont he account number
    FOR t_row IN
        SELECT
            SUM(interested_amount) AS interested_amount,
            account_number
        FROM
            account_interest
        WHERE
            is_deposited = FALSE
        GROUP BY
            account_number
    -- Loop through the entry
    LOOP

        --Deduct the balance from internal account
        UPDATE
            account  
        SET
            balance = balance - t_row.interested_amount
        WHERE
            bank_internal_account = TRUE;

        -- Update the balance into reciver account
        UPDATE
            account  
        SET
            balance = balance + t_row.interested_amount
        WHERE
            account_number = t_row.account_number;

        -- Create a transaction
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
                t_row.interested_amount,
                temp_account_number,
                t_row.account_number,
                TRUE,
                'Saving account interest'
            ) RETURNING transaction_id INTO temp_transaction_id;

        --Update the account_interest table and mark all entries deposited
        UPDATE
            account_interest
        SET
            transaction_id = temp_transaction_id,
            is_deposited = TRUE
        WHERE
            account_number = t_row.account_number
            AND is_deposited = FALSE;

    --END for loop
    END LOOP;

EXCEPTION
    WHEN OTHERS THEN RAISE INFO 'Error Name:%',
    SQLERRM;

RAISE INFO 'Error State:%',
SQLSTATE;

END;
$$