update COMPETENCE_COURSE_INFORMATION_CHANGE_REQUEST set BIBLIOGRAPHIC_REFERENCES=REPLACE(BIBLIOGRAPHIC_REFERENCES,"null||null||null||null||||null||", "REMOVE") WHERE BIBLIOGRAPHIC_REFERENCES like '%||null||%';
update COMPETENCE_COURSE_INFORMATION_CHANGE_REQUEST set BIBLIOGRAPHIC_REFERENCES=concat(SUBSTRING(BIBLIOGRAPHIC_REFERENCES,1,LOCATE("REMOVE",BIBLIOGRAPHIC_REFERENCES)-1), SUBSTRING(BIBLIOGRAPHIC_REFERENCES,LOCATE("REMOVE",BIBLIOGRAPHIC_REFERENCES)+7,LENGTH(BIBLIOGRAPHIC_REFERENCES))) WHERE BIBLIOGRAPHIC_REFERENCES like '%REMOVE%';
