DELETE FROM mw_CURRICULAR_COURSE_OUTSIDE_STUDENT_DEGREE WHERE idInternal IN (219,241,242,235,236,237,238);

ALTER TABLE ENROLMENT ADD COLUMN FNL_TMP_STATE varchar(4) NOT NULL AFTER STATE;

UPDATE ENROLMENT SET FNL_TMP_STATE = "FNL";

DROP TABLE IF EXISTS NOT_NEED_TO_ENROLL_IN_CURRICULAR_COURSE;
CREATE TABLE NOT_NEED_TO_ENROLL_IN_CURRICULAR_COURSE (
   ID_INTERNAL INT(11) NOT NULL AUTO_INCREMENT,
   ACK_OPT_LOCK INT(11),
   KEY_CURRICULAR_COURSE INT(11) NOT NULL,
   KEY_STUDENT_CURRICULAR_PLAN INT(11) NOT NULL,
   PRIMARY KEY (ID_INTERNAL),
   UNIQUE U1 (KEY_CURRICULAR_COURSE, KEY_STUDENT_CURRICULAR_PLAN)
)TYPE=INNODB;

-- END
