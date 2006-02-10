/*
 * Created on Dec 9, 2005
 */
package net.sourceforge.fenixedu.applicationTier.Servico.bolonhaManager;

import net.sourceforge.fenixedu.applicationTier.Service;
import net.sourceforge.fenixedu.applicationTier.Servico.exceptions.FenixServiceException;
import net.sourceforge.fenixedu.dataTransferObject.CurricularPeriodInfoDTO;
import net.sourceforge.fenixedu.domain.CompetenceCourse;
import net.sourceforge.fenixedu.domain.DegreeCurricularPlan;
import net.sourceforge.fenixedu.domain.ExecutionPeriod;
import net.sourceforge.fenixedu.domain.ExecutionYear;
import net.sourceforge.fenixedu.domain.curricularPeriod.CurricularPeriod;
import net.sourceforge.fenixedu.domain.curricularPeriod.CurricularPeriodType;
import net.sourceforge.fenixedu.domain.degreeStructure.CourseGroup;
import net.sourceforge.fenixedu.domain.degreeStructure.CurricularStage;
import net.sourceforge.fenixedu.persistenceTier.ExcepcaoPersistencia;

public class CreateCurricularCourse extends Service {

    public void run(Double weight, String prerequisites, String prerequisitesEn,
            Integer competenceCourseID, Integer parentCourseGroupID, Integer year, Integer semester,
            Integer degreeCurricularPlanID) throws ExcepcaoPersistencia, FenixServiceException {

        CompetenceCourse competenceCourse = (CompetenceCourse) persistentObject.
        		readByOID(CompetenceCourse.class, competenceCourseID);
        if (competenceCourse == null) {
            throw new FenixServiceException("error.noCompetenceCourse");
        }
        CourseGroup parentCourseGroup = (CourseGroup) persistentObject.readByOID(
                CourseGroup.class, parentCourseGroupID);
        if (parentCourseGroup == null) {
            throw new FenixServiceException("error.noCourseGroup");
        }

        DegreeCurricularPlan degreeCurricularPlan = (DegreeCurricularPlan) persistentObject.
        		readByOID(DegreeCurricularPlan.class, degreeCurricularPlanID);

        CurricularPeriod degreeCurricularPeriod = (CurricularPeriod) degreeCurricularPlan
                .getDegreeStructure();
        CurricularPeriod curricularPeriod = degreeCurricularPeriod.getCurricularPeriod(
                new CurricularPeriodInfoDTO(year, CurricularPeriodType.YEAR),
                new CurricularPeriodInfoDTO(semester, CurricularPeriodType.SEMESTER));

        if (curricularPeriod == null) {
            curricularPeriod = degreeCurricularPeriod.addCurricularPeriod(new CurricularPeriodInfoDTO(
                    year, CurricularPeriodType.YEAR), new CurricularPeriodInfoDTO(semester,
                    CurricularPeriodType.SEMESTER));
        }

        // TODO: this should be modified to receive ExecutionYear, but for now
        // we just read the '2006/2007'
        ExecutionYear executionYear = persistentSupport.getIPersistentExecutionYear()
                .readExecutionYearByName("2006/2007");
        ExecutionPeriod executionPeriod = executionYear
                .getExecutionPeriodForSemester(Integer.valueOf(1));

        degreeCurricularPlan.createCurricularCourse(weight, prerequisites, prerequisitesEn, CurricularStage.DRAFT,
                competenceCourse, parentCourseGroup, curricularPeriod, executionPeriod);
    }
}
