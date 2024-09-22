CREATE TABLE payments
(
    pymtDate            date,
    paymentCompany      varchar,
    paymentHead         varchar,
    paymentSubHead      varchar,
    paymentAmt          decimal(30, 4)
);
CREATE TABLE date_dimension
(
    valuekey             integer,
    datekey              Date
);

INSERT INTO date_dimension
SELECT seq4() + 1 valueKey, dateadd(day, -1 * valueKey, to_date('2025-12-31'))
FROM TABLE(GENERATOR(ROWCOUNT => 3000));
INSERT INTO payments
SELECT pymtDate , paymentCompany, paymentHead, paymentSubHead, UNIFORM(10, 155, RANDOM())
FROM
(
    SELECT dateadd(day, -1 * (seq4() + 1), current_date()) pymtDate
    FROM TABLE(GENERATOR(ROWCOUNT => 55))
)
Cross JOIN values ('Digtal Co'), ('Navigator LLC'), ('Somaya INC.') PC(paymentCompany)
Cross JOIN values ('Digtal'), ('Cash'), ('Cheque') PH(paymentHead)
Cross JOIN values ('Full'), ('Partial') PS(paymentSubHead);

TRUNCATE TABLE payments;