SELECT CONCAT('INSERT INTO ENROLMENT_EVALUATION VALUES (NULL, NULL, 1, NULL, NULL, NULL, 2, ', E.ID_INTERNAL, ', NULL, NULL, NULL, NULL, 1);') AS ""
FROM ENROLMENT E
INNER JOIN CURRICULAR_COURSE CC ON E.KEY_CURRICULAR_COURSE = CC.ID_INTERNAL
INNER JOIN DEGREE_CURRICULAR_PLAN DCP ON CC.KEY_DEGREE_CURRICULAR_PLAN = DCP.ID_INTERNAL
INNER JOIN STUDENT_CURRICULAR_PLAN SCP ON E. KEY_STUDENT_CURRICULAR_PLAN = SCP.ID_INTERNAL
INNER JOIN STUDENT S ON SCP.KEY_STUDENT = S.ID_INTERNAL
LEFT JOIN ENROLMENT_EVALUATION EE ON EE.KEY_ENROLMENT = E.ID_INTERNAL
WHERE EE.ID_INTERNAL IS NULL AND E.KEY_EXECUTION_PERIOD = 80;


SELECT CONCAT('UPDATE ENROLMENT_EVALUATION SET STATE = 1 WHERE ID_INTERNAL = ', ID_INTERNAL, ';') AS ""
FROM ENROLMENT_EVALUATION WHERE GRADE IS NOT NULL AND STATE = 2;

ALTER TABLE ENROLMENT_EVALUATION CHANGE ACK_OPT_LOCK ACK_OPT_LOCK INT(11)  DEFAULT "1" NOT NULL;

UPDATE ENROLMENT SET KEY_CURRICULAR_COURSE = 3014 WHERE ID_INTERNAL = 456718;

