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

$$