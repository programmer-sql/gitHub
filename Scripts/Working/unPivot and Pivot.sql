CREATE OR REPLACE TABLE sampledb.testuser.attendanceCount (
        attendanceDATE DateTime,
        CLASS_1_SEC_1 BIGINT,
        CLASS_1_SEC_2 BIGINT,
        CLASS_1_SEC_3 BIGINT,
        CLASS_1_SEC_4 BIGINT,
        CLASS_2_SEC_1 BIGINT,
        CLASS_2_SEC_2 BIGINT,
        CLASS_2_SEC_3 BIGINT,
        CLASS_2_SEC_4 BIGINT,
        CLASS_3_SEC_1 BIGINT,
        CLASS_3_SEC_2 BIGINT,
        CLASS_3_SEC_3 BIGINT,
        CLASS_3_SEC_4 BIGINT,
        CLASS_4_SEC_1 BIGINT,
        CLASS_4_SEC_2 BIGINT,
        CLASS_4_SEC_3 BIGINT,
        CLASS_4_SEC_4 BIGINT,
        CLASS_5_SEC_1 BIGINT,
        CLASS_5_SEC_2 BIGINT,
        CLASS_5_SEC_3 BIGINT,
        CLASS_6_SEC_1 BIGINT,
        CLASS_6_SEC_2 BIGINT,
        CLASS_6_SEC_3 BIGINT,
        CLASS_6_SEC_4 BIGINT,
        CLASS_6_SEC_5 BIGINT,
        CLASS_6_SEC_6 BIGINT,
        CLASS_6_SEC_7 BIGINT,
        CLASS_6_SEC_8 BIGINT
    ) AS
    Select dateadd(day, (seq4() + 1) * -1, CURRENT_DATE) AS attendanceDATE,
        uniform(30, 60, RANDOM()) AS CLASS_1_SEC_1,
        uniform(30, 60, RANDOM()) AS CLASS_1_SEC_2,
        uniform(30, 60, RANDOM()) AS CLASS_1_SEC_3,
        uniform(30, 60, RANDOM()) AS CLASS_1_SEC_4,
        uniform(30, 60, RANDOM()) AS CLASS_2_SEC_1,
        uniform(30, 60, RANDOM()) AS CLASS_2_SEC_2,
        uniform(30, 60, RANDOM()) AS CLASS_2_SEC_3,
        uniform(30, 60, RANDOM()) AS CLASS_2_SEC_4,
        uniform(30, 60, RANDOM()) AS CLASS_3_SEC_1,
        uniform(30, 60, RANDOM()) AS CLASS_3_SEC_2,
        uniform(30, 60, RANDOM()) AS CLASS_3_SEC_3,
        uniform(30, 60, RANDOM()) AS CLASS_3_SEC_4,
        uniform(30, 60, RANDOM()) AS CLASS_4_SEC_1,
        uniform(30, 60, RANDOM()) AS CLASS_4_SEC_2,
        uniform(30, 60, RANDOM()) AS CLASS_4_SEC_3,
        uniform(30, 60, RANDOM()) AS CLASS_4_SEC_4,
        uniform(30, 60, RANDOM()) AS CLASS_5_SEC_1,
        uniform(30, 60, RANDOM()) AS CLASS_5_SEC_2,
        uniform(30, 60, RANDOM()) AS CLASS_5_SEC_3,
        uniform(30, 60, RANDOM()) AS CLASS_6_SEC_1,
        uniform(30, 60, RANDOM()) AS CLASS_6_SEC_2,
        uniform(30, 60, RANDOM()) AS CLASS_6_SEC_3,
        uniform(30, 60, RANDOM()) AS CLASS_6_SEC_4,
        uniform(30, 60, RANDOM()) AS CLASS_6_SEC_5,
        uniform(30, 60, RANDOM()) AS CLASS_6_SEC_6,
        uniform(30, 60, RANDOM()) AS CLASS_6_SEC_7,
        uniform(30, 60, RANDOM()) AS CLASS_6_SEC_8
    FROM TABLE(GENERATOR (rowcount => 300));
    
/* Way 1 */
Select attendancedate,
    COALESCE(
        CASE
            WHEN classes1 = 'CLASS_1_SEC_1' THEN 'CLASS_1'
            WHEN classes1 = 'CLASS_2_SEC_1' THEN 'CLASS_2'
            WHEN classes1 = 'CLASS_3_SEC_1' THEN 'CLASS_3'
            WHEN classes1 = 'CLASS_4_SEC_1' THEN 'CLASS_4'
            WHEN classes1 = 'CLASS_5_SEC_1' THEN 'CLASS_5'
            WHEN classes1 = 'CLASS_6_SEC_1' THEN 'CLASS_6'
        END,
        ''
    ) classes,
    sec_1,
    sec_2,
    sec_3,
    sec_4,
    sec_5,
    sec_6,
    sec_7,
    sec_8
from (
        SELECT attendancedate,
            CLASS_1_SEC_1,
            CLASS_1_SEC_2,
            CLASS_1_SEC_3,
            CLASS_1_SEC_4,
            CAST(NULL AS BIGINT) CLASS_1_SEC_5,
            CAST(NULL AS BIGINT) CLASS_1_SEC_6,
            CAST(NULL AS BIGINT) CLASS_1_SEC_7,
            CAST(NULL AS BIGINT) CLASS_1_SEC_8,
            CLASS_2_SEC_1,
            CLASS_2_SEC_2,
            CLASS_2_SEC_3,
            CLASS_2_SEC_4,
            CAST(NULL AS BIGINT) CLASS_2_SEC_5,
            CAST(NULL AS BIGINT) CLASS_2_SEC_6,
            CAST(NULL AS BIGINT) CLASS_2_SEC_7,
            CAST(NULL AS BIGINT) CLASS_2_SEC_8,
            CLASS_3_SEC_1,
            CLASS_3_SEC_2,
            CLASS_3_SEC_3,
            CLASS_3_SEC_4,
            CAST(NULL AS BIGINT) CLASS_3_SEC_5,
            CAST(NULL AS BIGINT) CLASS_3_SEC_6,
            CAST(NULL AS BIGINT) CLASS_3_SEC_7,
            CAST(NULL AS BIGINT) CLASS_3_SEC_8,
            CLASS_4_SEC_1,
            CLASS_4_SEC_2,
            CLASS_4_SEC_3,
            CLASS_4_SEC_4,
            CAST(NULL AS BIGINT) CLASS_4_SEC_5,
            CAST(NULL AS BIGINT) CLASS_4_SEC_6,
            CAST(NULL AS BIGINT) CLASS_4_SEC_7,
            CAST(NULL AS BIGINT) CLASS_4_SEC_8,
            CLASS_5_SEC_1,
            CLASS_5_SEC_2,
            CLASS_5_SEC_3,
            CAST(NULL AS BIGINT) CLASS_5_SEC_4,
            CAST(NULL AS BIGINT) CLASS_5_SEC_5,
            CAST(NULL AS BIGINT) CLASS_5_SEC_6,
            CAST(NULL AS BIGINT) CLASS_5_SEC_7,
            CAST(NULL AS BIGINT) CLASS_5_SEC_8,
            CLASS_6_SEC_1,
            CLASS_6_SEC_2,
            CLASS_6_SEC_3,
            CLASS_6_SEC_4,
            CLASS_6_SEC_5,
            CLASS_6_SEC_6,
            CLASS_6_SEC_7,
            CLASS_6_SEC_8
        FROM sampledb.testuser.attendanceCount
        where 1 = 1
    ) UNPIVOT INCLUDE NULLS (
        sec_1 FOR classes1 IN (
            CLASS_1_SEC_1,
            CLASS_2_SEC_1,
            CLASS_3_SEC_1,
            CLASS_4_SEC_1,
            CLASS_5_SEC_1,
            CLASS_6_SEC_1
        )
    ) UNPIVOT INCLUDE NULLS (
        sec_2 FOR classes2 IN (
            CLASS_1_SEC_2,
            CLASS_2_SEC_2,
            CLASS_3_SEC_2,
            CLASS_4_SEC_2,
            CLASS_5_SEC_2,
            CLASS_6_SEC_2
        )
    ) UNPIVOT INCLUDE NULLS (
        sec_3 FOR classes3 IN (
            CLASS_1_SEC_3,
            CLASS_2_SEC_3,
            CLASS_3_SEC_3,
            CLASS_4_SEC_3,
            CLASS_5_SEC_3,
            CLASS_6_SEC_3
        )
    ) UNPIVOT INCLUDE NULLS (
        sec_4 FOR classes4 IN (
            CLASS_1_SEC_4,
            CLASS_2_SEC_4,
            CLASS_3_SEC_4,
            CLASS_4_SEC_4,
            CLASS_5_SEC_4,
            CLASS_6_SEC_4
        )
    ) UNPIVOT INCLUDE NULLS (
        sec_5 FOR classes5 IN (
            CLASS_1_SEC_5,
            CLASS_2_SEC_5,
            CLASS_3_SEC_5,
            CLASS_4_SEC_5,
            CLASS_5_SEC_5,
            CLASS_6_SEC_5
        )
    ) UNPIVOT INCLUDE NULLS (
        sec_6 FOR classes6 IN (
            CLASS_1_SEC_6,
            CLASS_2_SEC_6,
            CLASS_3_SEC_6,
            CLASS_4_SEC_6,
            CLASS_5_SEC_6,
            CLASS_6_SEC_6
        )
    ) UNPIVOT INCLUDE NULLS (
        sec_7 FOR classes7 IN (
            CLASS_1_SEC_7,
            CLASS_2_SEC_7,
            CLASS_3_SEC_7,
            CLASS_4_SEC_7,
            CLASS_5_SEC_7,
            CLASS_6_SEC_7
        )
    ) UNPIVOT INCLUDE NULLS (
        sec_8 FOR classes8 IN (
            CLASS_1_SEC_8,
            CLASS_2_SEC_8,
            CLASS_3_SEC_8,
            CLASS_4_SEC_8,
            CLASS_5_SEC_8,
            CLASS_6_SEC_8
        )
    )
where 1 = 1
    AND COALESCE(
        CASE
            WHEN classes1 = 'CLASS_1_SEC_1' THEN 'CLASS_1'
            WHEN classes1 = 'CLASS_2_SEC_1' THEN 'CLASS_2'
            WHEN classes1 = 'CLASS_3_SEC_1' THEN 'CLASS_3'
            WHEN classes1 = 'CLASS_4_SEC_1' THEN 'CLASS_4'
            WHEN classes1 = 'CLASS_5_SEC_1' THEN 'CLASS_5'
            WHEN classes1 = 'CLASS_6_SEC_1' THEN 'CLASS_6'
        END,
        ''
    ) = COALESCE(
        CASE
            WHEN classes2 = 'CLASS_1_SEC_2' THEN 'CLASS_1'
            WHEN classes2 = 'CLASS_2_SEC_2' THEN 'CLASS_2'
            WHEN classes2 = 'CLASS_3_SEC_2' THEN 'CLASS_3'
            WHEN classes2 = 'CLASS_4_SEC_2' THEN 'CLASS_4'
            WHEN classes2 = 'CLASS_5_SEC_2' THEN 'CLASS_5'
            WHEN classes2 = 'CLASS_6_SEC_2' THEN 'CLASS_6'
        END,
        ''
    )
    AND COALESCE(
        CASE
            WHEN classes1 = 'CLASS_1_SEC_1' THEN 'CLASS_1'
            WHEN classes1 = 'CLASS_2_SEC_1' THEN 'CLASS_2'
            WHEN classes1 = 'CLASS_3_SEC_1' THEN 'CLASS_3'
            WHEN classes1 = 'CLASS_4_SEC_1' THEN 'CLASS_4'
            WHEN classes1 = 'CLASS_5_SEC_1' THEN 'CLASS_5'
            WHEN classes1 = 'CLASS_6_SEC_1' THEN 'CLASS_6'
        END,
        ''
    ) = COALESCE(
        CASE
            WHEN classes3 = 'CLASS_1_SEC_3' THEN 'CLASS_1'
            WHEN classes3 = 'CLASS_2_SEC_3' THEN 'CLASS_2'
            WHEN classes3 = 'CLASS_3_SEC_3' THEN 'CLASS_3'
            WHEN classes3 = 'CLASS_4_SEC_3' THEN 'CLASS_4'
            WHEN classes3 = 'CLASS_5_SEC_3' THEN 'CLASS_5'
            WHEN classes3 = 'CLASS_6_SEC_3' THEN 'CLASS_6'
        END,
        ''
    )
    AND COALESCE(
        CASE
            WHEN classes1 = 'CLASS_1_SEC_1' THEN 'CLASS_1'
            WHEN classes1 = 'CLASS_2_SEC_1' THEN 'CLASS_2'
            WHEN classes1 = 'CLASS_3_SEC_1' THEN 'CLASS_3'
            WHEN classes1 = 'CLASS_4_SEC_1' THEN 'CLASS_4'
            WHEN classes1 = 'CLASS_5_SEC_1' THEN 'CLASS_5'
            WHEN classes1 = 'CLASS_6_SEC_1' THEN 'CLASS_6'
        END,
        ''
    ) = COALESCE(
        CASE
            WHEN classes4 = 'CLASS_1_SEC_4' THEN 'CLASS_1'
            WHEN classes4 = 'CLASS_2_SEC_4' THEN 'CLASS_2'
            WHEN classes4 = 'CLASS_3_SEC_4' THEN 'CLASS_3'
            WHEN classes4 = 'CLASS_4_SEC_4' THEN 'CLASS_4'
            WHEN classes4 = 'CLASS_5_SEC_4' THEN 'CLASS_5'
            WHEN classes4 = 'CLASS_6_SEC_4' THEN 'CLASS_6'
        END,
        ''
    )
    AND COALESCE(
        CASE
            WHEN classes1 = 'CLASS_1_SEC_1' THEN 'CLASS_1'
            WHEN classes1 = 'CLASS_2_SEC_1' THEN 'CLASS_2'
            WHEN classes1 = 'CLASS_3_SEC_1' THEN 'CLASS_3'
            WHEN classes1 = 'CLASS_4_SEC_1' THEN 'CLASS_4'
            WHEN classes1 = 'CLASS_5_SEC_1' THEN 'CLASS_5'
            WHEN classes1 = 'CLASS_6_SEC_1' THEN 'CLASS_6'
        END,
        ''
    ) = COALESCE(
        CASE
            WHEN classes5 = 'CLASS_1_SEC_5' THEN 'CLASS_1'
            WHEN classes5 = 'CLASS_2_SEC_5' THEN 'CLASS_2'
            WHEN classes5 = 'CLASS_3_SEC_5' THEN 'CLASS_3'
            WHEN classes5 = 'CLASS_4_SEC_5' THEN 'CLASS_4'
            WHEN classes5 = 'CLASS_5_SEC_5' THEN 'CLASS_5'
            WHEN classes5 = 'CLASS_6_SEC_5' THEN 'CLASS_6'
        END,
        ''
    )
    AND COALESCE(
        CASE
            WHEN classes1 = 'CLASS_1_SEC_1' THEN 'CLASS_1'
            WHEN classes1 = 'CLASS_2_SEC_1' THEN 'CLASS_2'
            WHEN classes1 = 'CLASS_3_SEC_1' THEN 'CLASS_3'
            WHEN classes1 = 'CLASS_4_SEC_1' THEN 'CLASS_4'
            WHEN classes1 = 'CLASS_5_SEC_1' THEN 'CLASS_5'
            WHEN classes1 = 'CLASS_6_SEC_1' THEN 'CLASS_6'
        END,
        ''
    ) = COALESCE(
        CASE
            WHEN classes6 = 'CLASS_1_SEC_6' THEN 'CLASS_1'
            WHEN classes6 = 'CLASS_2_SEC_6' THEN 'CLASS_2'
            WHEN classes6 = 'CLASS_3_SEC_6' THEN 'CLASS_3'
            WHEN classes6 = 'CLASS_4_SEC_6' THEN 'CLASS_4'
            WHEN classes6 = 'CLASS_5_SEC_6' THEN 'CLASS_5'
            WHEN classes6 = 'CLASS_6_SEC_6' THEN 'CLASS_6'
        END,
        ''
    )
    AND COALESCE(
        CASE
            WHEN classes1 = 'CLASS_1_SEC_1' THEN 'CLASS_1'
            WHEN classes1 = 'CLASS_2_SEC_1' THEN 'CLASS_2'
            WHEN classes1 = 'CLASS_3_SEC_1' THEN 'CLASS_3'
            WHEN classes1 = 'CLASS_4_SEC_1' THEN 'CLASS_4'
            WHEN classes1 = 'CLASS_5_SEC_1' THEN 'CLASS_5'
            WHEN classes1 = 'CLASS_6_SEC_1' THEN 'CLASS_6'
        END,
        ''
    ) = COALESCE(
        CASE
            WHEN classes7 = 'CLASS_1_SEC_7' THEN 'CLASS_1'
            WHEN classes7 = 'CLASS_2_SEC_7' THEN 'CLASS_2'
            WHEN classes7 = 'CLASS_3_SEC_7' THEN 'CLASS_3'
            WHEN classes7 = 'CLASS_4_SEC_7' THEN 'CLASS_4'
            WHEN classes7 = 'CLASS_5_SEC_7' THEN 'CLASS_5'
            WHEN classes7 = 'CLASS_6_SEC_7' THEN 'CLASS_6'
        END,
        ''
    )
    AND COALESCE(
        CASE
            WHEN classes1 = 'CLASS_1_SEC_1' THEN 'CLASS_1'
            WHEN classes1 = 'CLASS_2_SEC_1' THEN 'CLASS_2'
            WHEN classes1 = 'CLASS_3_SEC_1' THEN 'CLASS_3'
            WHEN classes1 = 'CLASS_4_SEC_1' THEN 'CLASS_4'
            WHEN classes1 = 'CLASS_5_SEC_1' THEN 'CLASS_5'
            WHEN classes1 = 'CLASS_6_SEC_1' THEN 'CLASS_6'
        END,
        ''
    ) = COALESCE(
        CASE
            WHEN classes8 = 'CLASS_1_SEC_8' THEN 'CLASS_1'
            WHEN classes8 = 'CLASS_2_SEC_8' THEN 'CLASS_2'
            WHEN classes8 = 'CLASS_3_SEC_8' THEN 'CLASS_3'
            WHEN classes8 = 'CLASS_4_SEC_8' THEN 'CLASS_4'
            WHEN classes8 = 'CLASS_5_SEC_8' THEN 'CLASS_5'
            WHEN classes8 = 'CLASS_6_SEC_8' THEN 'CLASS_6'
        END,
        ''
    );
/* 2nd way */
SELECT *
FROM (
        SELECT ATTENDANCEDATE,
            CONCAT(
                split(CLASSES, '_') [0],
                ' ',
                split(CLASSES, '_') [1]
            ) CLASS_NAME,
            CONCAT(
                split(CLASSES, '_') [2],
                ' ',
                split(CLASSES, '_') [3]
            ) SEC_NAME,
            attendance
        FROM sampledb.testuser.attendanceCount UNPIVOT INCLUDE NULLS (
                attendance FOR CLASSES IN (
                    CLASS_1_SEC_1,
                    CLASS_1_SEC_2,
                    CLASS_1_SEC_3,
                    CLASS_1_SEC_4,
                    CLASS_2_SEC_1,
                    CLASS_2_SEC_2,
                    CLASS_2_SEC_3,
                    CLASS_2_SEC_4,
                    CLASS_3_SEC_1,
                    CLASS_3_SEC_2,
                    CLASS_3_SEC_3,
                    CLASS_3_SEC_4,
                    CLASS_4_SEC_1,
                    CLASS_4_SEC_2,
                    CLASS_4_SEC_3,
                    CLASS_4_SEC_4,
                    CLASS_5_SEC_1,
                    CLASS_5_SEC_2,
                    CLASS_5_SEC_3,
                    CLASS_6_SEC_1,
                    CLASS_6_SEC_2,
                    CLASS_6_SEC_3,
                    CLASS_6_SEC_4,
                    CLASS_6_SEC_5,
                    CLASS_6_SEC_6,
                    CLASS_6_SEC_7,
                    CLASS_6_SEC_8
                )
            )
    ) PIVOT(
        SUM(attendance) FOR SEC_NAME IN (
            Select SEC_NAME
            FROM sampledb.testuser.attendance_dtl_brk
        )
    )
where 1 = 1
ORDER BY ATTENDANCEDATE;