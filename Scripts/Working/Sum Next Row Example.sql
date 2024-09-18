USE ROLE ACCOUNTADMIN;
USE DATABASE sampledb;
USE SCHEMA TESTUSER;
USE WAREHOUSE COMPUTE_WH;
CREATE TABLE tblMultilineSum (
    actionDates DATE,
    columnHead VARCHAR,
    columnValues INT
);

INSERT INTO tblMultilineSum
SELECT dates, colTypes, UNIFORM(50, 351, RANDOM())
FROM
(
    SELECT DATEADD(DAY, -1 * (seq4() + 1), CURRENT_DATE()) dates
    FROM TABLE(GENERATOR (rowcount => 10))
) T CROSS JOIN
VALUES ('Type - 1'), 
        ('Type - 2'),
        ('Type - 3'),
        ('Type - 4'),
        ('Type - 5')
tblTypes(colTypes)
        ;

SET myDates = to_date('2024-09-15');
SELECT 
actionDates,
SUM(IFF(columnHead = 'Type - 1', columnvalues, 0)) type_1,
SUM(IFF(columnHead = 'Type - 2', columnvalues, 0)) type_2,
SUM(IFF(columnHead = 'Type - 3', columnvalues, 0)) type_3,
SUM(IFF(columnHead = 'Type - 4', columnvalues, 0)) type_4,
SUM(IFF(columnHead = 'Type - 5', columnvalues, 0)) type_5,
SUM(columnvalues) type_all,
FROM tblmultilinesum
WHERE actiondates = $myDates
GROUP By actionDates
ORDER BY actiondates desc;