CREATE OR REPLACE FUNCTION nth_prime(n int)
    returns bigint AS
$$
DECLARE
    candidate int := 2;
    count     int := 0;

BEGIN
    IF n < 1 THEN
        raise exception 'number must be greater than 0';
    END IF;
    WHILE count < n
        LOOP
            if is_prime(candidate) then
                count := count + 1;
            end if;
            candidate := candidate + 1;
        end loop;
    raise notice 'The %-th prime is: %', n,(candidate - 1);
    return candidate - 1;
END
$$
    LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION is_prime(n int)
    returns boolean AS
$$
DECLARE
    i int := 2;
BEGIN
    while i < n
        loop
            if n % i = 0 then
                return false;
            end if;
            i := i + 1;
        end loop;
    return true;
END
$$
    LANGUAGE plpgsql;

SELECT *
FROM nth_prime(5);