/*
 * Created on Dec 21, 2004
 *
 */
package DataBeans;

import Dominio.IEnrollment;

/**
 * @author Andr� Fernandes / Jo�o Brito
 */
public class InfoEnrolmentWithExecutionPeriodAndYearAndEvaluationType extends
        InfoEnrolmentWithExecutionPeriodAndYear
{
    public void copyFromDomain(IEnrollment enrolment) {
        super.copyFromDomain(enrolment);
    }

    public static InfoEnrolment newInfoFromDomain(IEnrollment enrolment) {
        InfoEnrolmentWithExecutionPeriodAndYearAndEvaluationType infoEnrolment = null;
        if (enrolment != null) {
            infoEnrolment = new InfoEnrolmentWithExecutionPeriodAndYearAndEvaluationType();
            infoEnrolment.copyFromDomain(enrolment);
        }

        return infoEnrolment;
    }
}
