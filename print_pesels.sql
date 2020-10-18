DROP FUNCTION printpesels(OUT pesel_num NUMERIC, OUT is_valid BOOLEAN);
create or replace function printPesels(OUT pesel_num NUMERIC, OUT is_valid BOOLEAN)
as
$$
DECLARE
    pesel_row record;
BEGIN
    FOR pesel_row in SELECT name, pesel_number FROM people
        LOOP
            pesel_num := pesel_row.pesel_number;
            is_valid := is_pesel_valid(pesel_num);
            raise notice '%: % - is_valid: %',pesel_row.name, pesel_num, is_valid;
        end loop;
    return;
end;
$$
    language plpgsql;
select *
from printPesels();
