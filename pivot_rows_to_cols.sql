-- Pivot row to columns
/*
-- Step 1. Select columns of interest in the desired result, hostid provides the y-values
and item_name provides the x-values.

*/
USE basketball;

CREATE TABLE rows_to_cols(hostid int, item_name CHAR, item_value int);

INSERT INTO rows_to_cols(hostid , item_name, item_value)
VALUES
    (1, 'A', 10),
    (1, 'B', 3),
    (2, 'A', 9),
    (2, 'C', 40);
   
-- DROP TABLE IF EXIST rows_to_cols;

ALTER TABLE rows_to_cols RENAME COLUMN hostid TO host_id;

select * from basketball.rows_to_cols;

-- Step 2. Extend teh base table with extra columns. Creating a view
-- we typically need one column per x-VALUES. Below code will extend 3 columns

CREATE VIEW rows_to_cols_pivot AS
select *,
case when item_name = 'A' then item_value end as A,
case when item_name = 'B' then item_value end as B,
case when item_name = 'C' then item_value end as C
from basketball.rows_to_cols;

DROP VIEW rows_to_cols_pivot;
DROP VIEW transpose;

select * from rows_to_cols_pivot;


-- Step 3. Group and aggregate the extended value. Need to group by hostid, since
-- it provides the y-values
-- Rename the column hostid
select host_id,
sum(A) as A,
sum(B) as B,
sum(C) as C
from rows_to_cols_pivot
group by host_id;


-- Step 4. Going to replace any null values with zeroes so the 
-- results set is nicer than NULL

CREATE VIEW rows_to_cols_pivot_prettify AS
SELECT host_id,
coalesce(A, 0) AS A,
coalesce(B, 0) AS B,
coalesce(C, 0) AS C
FROM rows_to_cols_pivot;

select * from rows_to_cols_pivot_prettify;



