/* Using MySQL Workbench. */

USE customer_contacts;

-- Create a column for numbers
DROP TABLE IF EXISTS fizzBuzzNUm;
CREATE TABLE fizzBuzzNum(num INT);

-- Insert numbers from 1 to 20
INSERT INTO fizzBuzzNum(num)
VALUES
    (1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11), (12), (13), (14), (15),
    (16), (17), (18), (19), (20);

SELECT * FROM fizzBuzzNum
order by num;

SELECT num,
CASE
WHEN num % 3 = 0 AND num % 5 = 0 THEN 'FizzBuzz'
WHEN num % 3 = 0 THEN 'Fizz'

-- Can use the MOD function. Note in MicroSoft SQL Server Management Studio "MOD" is not recognized!
WHEN MOD(num, 5) = 0 THEN 'Buzz'
ELSE num
END AS fizzbuzz_col
FROM fizzBuzzNum;



