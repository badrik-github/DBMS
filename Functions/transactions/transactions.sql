--- THIS FUNCTION IS USED TO OPPEN BANK ACCOUNTS.
CREATE
OR REPLACE FUNCTION perform_transaction(
    sender_account_number bigint,
    receiver_account_number bigint,
    amount DECIMAL
) RETURNS BOOLEAN LANGUAGE plpgsql AS $$
DECLARE
BEGIN
EXCEPTION
    WHEN OTHERS THEN RAISE INFO 'Error Name:%',
    SQLERRM;

RAISE INFO 'Error State:%',
SQLSTATE;

END;

$$