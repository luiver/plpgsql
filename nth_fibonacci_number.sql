CREATE OR REPLACE FUNCTION nth_fib(n int)
    returns bigint AS
$$
BEGIN
    IF n < 0 THEN
        raise exception 'number must be greater or equal 0';
    END IF;
    IF n <= 1 THEN
        return n;
    END IF;
    return nth_fib(n - 1) + nth_fib(n - 2);
END
$$
    LANGUAGE plpgsql;
SELECT * from nth_fib(11);