Select GET_DDL('table', 'sampledb.testuser.attendanceCount');
Select * 
from sampledb.testuser.attendanceCount 
WHERE 1 = 1
AND attendancedate = to_date('2024-09-06 00:00:00.000')
Fetch 10;

Select 
Pvt.VALUE: CLASS::VARCHAR AS CALSS,
Pvt.VALUE: SEC_1::INT AS SEC_1, 
Pvt.VALUE: SEC_2::INT AS SEC_2, 
Pvt.VALUE: SEC_3::INT AS SEC_3, 
Pvt.VALUE: SEC_4::INT AS SEC_4, 
Pvt.VALUE: SEC_5::INT AS SEC_5, 
Pvt.VALUE: SEC_6::INT AS SEC_6, 
Pvt.VALUE: SEC_7::INT AS SEC_7, 
Pvt.VALUE: SEC_8::INT AS SEC_8 
from sampledb.testuser.attendanceCount hrd cross join
TABLE(FLATTEN(INPUT => ARRAY_CONSTRUCT(
    OBJECT_CONSTRUCT_KEEP_NULL(
    'CLASS', 'Class 1',
    'SEC_1', hrd.CLASS_1_SEC_1,
    'SEC_2', hrd.CLASS_1_SEC_2,
    'SEC_3', hrd.CLASS_1_SEC_3,
    'SEC_4', hrd.CLASS_1_SEC_4,
    'SEC_5', NULL,
    'SEC_6', NULL,
    'SEC_7', NULL,
    'SEC_8', NULL
    ),
    OBJECT_CONSTRUCT_KEEP_NULL(
    'CLASS', 'Class 2',
    'SEC_1', hrd.CLASS_2_SEC_1,
    'SEC_2', hrd.CLASS_2_SEC_2,
    'SEC_3', hrd.CLASS_2_SEC_3,
    'SEC_4', hrd.CLASS_2_SEC_4,
    'SEC_5', NULL,
    'SEC_6', NULL,
    'SEC_7', NULL,
    'SEC_8', NULL
    ),
    OBJECT_CONSTRUCT_KEEP_NULL(
    'CLASS', 'Class 3',
    'SEC_1', hrd.CLASS_3_SEC_1,
    'SEC_2', hrd.CLASS_3_SEC_2,
    'SEC_3', hrd.CLASS_3_SEC_3,
    'SEC_4', hrd.CLASS_3_SEC_4,
    'SEC_5', NULL,
    'SEC_6', NULL,
    'SEC_7', NULL,
    'SEC_8', NULL
    ),
    OBJECT_CONSTRUCT_KEEP_NULL(
    'CLASS', 'Class 4',
    'SEC_1', hrd.CLASS_4_SEC_1,
    'SEC_2', hrd.CLASS_4_SEC_2,
    'SEC_3', hrd.CLASS_4_SEC_3,
    'SEC_4', hrd.CLASS_4_SEC_4,
    'SEC_5', NULL,
    'SEC_6', NULL,
    'SEC_7', NULL,
    'SEC_8', NULL
    ),
    OBJECT_CONSTRUCT_KEEP_NULL(
    'CLASS', 'Class 5',
    'SEC_1', hrd.CLASS_5_SEC_1,
    'SEC_2', hrd.CLASS_5_SEC_2,
    'SEC_3', hrd.CLASS_5_SEC_3,
    'SEC_4', NULL,
    'SEC_5', NULL,
    'SEC_6', NULL,
    'SEC_7', NULL,
    'SEC_8', NULL
    ),
    OBJECT_CONSTRUCT_KEEP_NULL(
    'CLASS', 'Class 6',
    'SEC_1', CLASS_6_SEC_1,
    'SEC_2', CLASS_6_SEC_2,
    'SEC_3', CLASS_6_SEC_3,
    'SEC_4', CLASS_6_SEC_4,
    'SEC_5', CLASS_6_SEC_5,
    'SEC_6', CLASS_6_SEC_6,
    'SEC_7', CLASS_6_SEC_7,
    'SEC_8', CLASS_6_SEC_8
    )
    ))) AS Pvt
WHERE 1 = 1
AND attendancedate = to_date('2024-09-05 00:00:00.000');