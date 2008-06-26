package net.sourceforge.fenixedu.domain.accounting;

public enum EventType {

    PAST_SCHOOL_REGISTRATION_CERTIFICATE_REQUEST,

    PAST_ENROLMENT_CERTIFICATE_REQUEST,

    PAST_APPROVEMENT_CERTIFICATE_REQUEST,

    PAST_DEGREE_FINALIZATION_CERTIFICATE_REQUEST,

    PAST_DEGREE_DIPLOMA_REQUEST,

    PAST_COURSE_LOAD_REQUEST,

    PAST_EXAM_DATE_CERTIFICATE_REQUEST,

    PAST_PROGRAM_CERTIFICATE_REQUEST,

    PAST_PHOTOCOPY_REQUEST,

    PAST_STUDENT_REINGRESSION_REQUEST,

    PAST_EQUIVALENCE_PLAN_REQUEST,

    PAST_REVISION_EQUIVALENCE_PLAN_REQUEST,

    PAST_COURSE_GROUP_CHANGE_REQUEST,

    PAST_EXTRA_EXAM_REQUEST,

    PAST_FREE_SOLICITATION_ACADEMIC_REQUEST,

    SCHOOL_REGISTRATION_CERTIFICATE_REQUEST,

    ENROLMENT_CERTIFICATE_REQUEST,

    APPROVEMENT_CERTIFICATE_REQUEST,

    DEGREE_FINALIZATION_CERTIFICATE_REQUEST,

    SCHOOL_REGISTRATION_DECLARATION_REQUEST,

    ENROLMENT_DECLARATION_REQUEST,

    BOLONHA_DEGREE_DIPLOMA_REQUEST,

    BOLONHA_MASTER_DEGREE_DIPLOMA_REQUEST,

    BOLONHA_ADVANCED_FORMATION_DIPLOMA_REQUEST,

    BOLONHA_PHD_PROGRAM_DIPLOMA_REQUEST,

    COURSE_LOAD_REQUEST,

    EXAM_DATE_CERTIFICATE_REQUEST,

    PROGRAM_CERTIFICATE_REQUEST,

    PHOTOCOPY_REQUEST,

    STUDENT_REINGRESSION_REQUEST,

    EQUIVALENCE_PLAN_REQUEST,

    CANDIDACY_ENROLMENT,

    GRATUITY,

    INSURANCE,

    DFA_REGISTRATION,

    PHD_REGISTRATION,

    ADMINISTRATIVE_OFFICE_FEE,

    ADMINISTRATIVE_OFFICE_FEE_INSURANCE,

    IMPROVEMENT_OF_APPROVED_ENROLMENT,

    ENROLMENT_OUT_OF_PERIOD,

    OVER23_INDIVIDUAL_CANDIDACY,

    SECOND_CYCLE_INDIVIDUAL_CANDIDACY,
    
    DEGREE_CANDIDACY_FOR_GRADUATED_PERSON;

    public String getName() {
	return name();
    }

    public String getQualifiedName() {
	return EventType.class.getSimpleName() + "." + name();
    }

    public String getFullyQualifiedName() {
	return EventType.class.getName() + "." + name();
    }

}
