CREATE OR REPLACE FUNCTION is_pesel_valid(pesel NUMERIC)
    returns boolean AS
$$
DECLARE
    p              varchar := pesel::varchar;
    control_number int     := substr(p, length(p), 1)::int;
    checksum       int     := 0;
    weight         int[]   := array [1,3,7,9,1,3,7,9,1,3];

BEGIN
    IF length(p) != 11 THEN
        return false;
    END IF;
    FOR n in 1..array_length(weight, 1)
        LOOP
            checksum := checksum + substr(p, n, 1)::int * weight[n];
        END LOOP;
    RETURN (10 - checksum % 10) % 10 = control_number;
END
$$
    LANGUAGE plpgsql;
