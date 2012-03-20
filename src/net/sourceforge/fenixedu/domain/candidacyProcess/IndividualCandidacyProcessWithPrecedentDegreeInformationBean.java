package net.sourceforge.fenixedu.domain.candidacyProcess;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Locale;
import java.util.ResourceBundle;

import net.sourceforge.fenixedu.dataTransferObject.candidacy.PrecedentDegreeInformationBean;
import net.sourceforge.fenixedu.domain.StudentCurricularPlan;
import net.sourceforge.fenixedu.domain.degreeStructure.CycleType;
import net.sourceforge.fenixedu.domain.student.PrecedentDegreeInformation;
import net.sourceforge.fenixedu.domain.student.Registration;
import net.sourceforge.fenixedu.domain.student.Student;
import net.sourceforge.fenixedu.domain.studentCurriculum.CycleCurriculumGroup;
import pt.utl.ist.fenix.tools.util.i18n.Language;

abstract public class IndividualCandidacyProcessWithPrecedentDegreeInformationBean extends IndividualCandidacyProcessBean {

    private PrecedentDegreeType precedentDegreeType;

    private PrecedentDegreeInformationBean precedentDegreeInformation;

    private StudentCurricularPlan precedentStudentCurricularPlan;

    public PrecedentDegreeType getPrecedentDegreeType() {
	return precedentDegreeType;
    }

    public void setPrecedentDegreeType(PrecedentDegreeType precedentDegreeType) {
	this.precedentDegreeType = precedentDegreeType;
    }

    public boolean hasPrecedentDegreeType() {
	return precedentDegreeType != null;
    }

    public boolean isExternalPrecedentDegreeType() {
	return precedentDegreeType == PrecedentDegreeType.EXTERNAL_DEGREE;
    }

    public PrecedentDegreeInformationBean getPrecedentDegreeInformation() {
	return precedentDegreeInformation;
    }

    public void setPrecedentDegreeInformation(PrecedentDegreeInformationBean precedentDegreeInformation) {
	this.precedentDegreeInformation = precedentDegreeInformation;
    }

    public List<StudentCurricularPlan> getPrecedentStudentCurricularPlans() {
	final Student student = getStudent();
	if (student == null) {
	    return Collections.emptyList();
	}

	final List<StudentCurricularPlan> studentCurricularPlans = new ArrayList<StudentCurricularPlan>();
	for (final Registration registration : student.getRegistrations()) {
	    if (registration.isBolonha()) {
		final StudentCurricularPlan studentCurricularPlan = registration.getLastStudentCurricularPlan();

		for (final CycleType cycleType : getValidPrecedentCycleTypes()) {

		    if (studentCurricularPlan.hasCycleCurriculumGroup(cycleType)) {
			final CycleCurriculumGroup cycle = studentCurricularPlan.getCycle(cycleType);

			// not concluded cycles count if respect minimum ects
			if (cycle.isConclusionProcessed() || cycle.isConcluded()
				|| cycle.getCreditsConcluded().doubleValue() >= getMinimumEcts(cycleType)) {
			    studentCurricularPlans.add(registration.getLastStudentCurricularPlan());
			    break;
			}
		    }
		}

	    } else if (isPreBolonhaPrecedentDegreeAllowed()) {
		if (registration.isRegistrationConclusionProcessed()) {
		    studentCurricularPlans.add(registration.getLastStudentCurricularPlan());
		}
	    }
	}

	return studentCurricularPlans;
    }

    public StudentCurricularPlan getLastPrecedentStudentCurricularPlan() {
	List<StudentCurricularPlan> studentCurricularPlanList = getPrecedentStudentCurricularPlans();
	return studentCurricularPlanList.isEmpty() ? null : Collections.max(studentCurricularPlanList,
		StudentCurricularPlan.DATE_COMPARATOR);
    }

    /**
     * If cycle is not concluded, this represents the minimum number of ects
     * that student must have to candidate in order to conclude the degree with
     * current semester
     */
    protected double getMinimumEcts(final CycleType cycleType) {
	return 180d;
    }

    abstract protected List<CycleType> getValidPrecedentCycleTypes();

    abstract protected boolean isPreBolonhaPrecedentDegreeAllowed();

    protected Student getStudent() {
	return getPersonBean().hasStudent() ? getPersonBean().getPerson().getStudent() : null;
    }

    public boolean isValidPrecedentDegreeInformation() {
	return hasPrecedentDegreeType() && (isExternalPrecedentDegreeType() || hasPrecedentStudentCurricularPlan());
    }

    public StudentCurricularPlan getPrecedentStudentCurricularPlan() {
	return this.precedentStudentCurricularPlan;
    }

    public boolean hasPrecedentStudentCurricularPlan() {
	return getPrecedentStudentCurricularPlan() != null;
    }

    public void setPrecedentStudentCurricularPlan(StudentCurricularPlan precedentStudentCurricularPlan) {
	this.precedentStudentCurricularPlan = precedentStudentCurricularPlan;
    }

    // static information

    static public enum PrecedentDegreeType {
	INSTITUTION_DEGREE, EXTERNAL_DEGREE;

	public String getName() {
	    return name();
	}

	public static PrecedentDegreeType valueOf(final PrecedentDegreeInformation precedentDegreeInformation) {
	    return precedentDegreeInformation.isCandidacyExternal() ? EXTERNAL_DEGREE : INSTITUTION_DEGREE;
	}

	public String getLocalizedName() {
	    return getLocalizedName(Language.getLocale());
	}

	public String getLocalizedName(final Locale locale) {
	    return ResourceBundle.getBundle("resources.EnumerationResources", locale).getString(
		    this.getClass().getSimpleName() + "." + name());
	}

    }
}
