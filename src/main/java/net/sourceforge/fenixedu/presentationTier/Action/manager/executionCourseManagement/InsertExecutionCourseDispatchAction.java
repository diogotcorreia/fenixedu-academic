package net.sourceforge.fenixedu.presentationTier.Action.manager.executionCourseManagement;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sourceforge.fenixedu.applicationTier.Filtro.exception.FenixFilterException;
import net.sourceforge.fenixedu.applicationTier.Servico.commons.ReadExecutionPeriods;
import net.sourceforge.fenixedu.applicationTier.Servico.exceptions.FenixServiceException;
import net.sourceforge.fenixedu.applicationTier.Servico.manager.InsertExecutionCourseAtExecutionPeriod;
import net.sourceforge.fenixedu.dataTransferObject.InfoExecutionCourseEditor;
import net.sourceforge.fenixedu.dataTransferObject.InfoExecutionPeriod;
import net.sourceforge.fenixedu.domain.EntryPhase;
import net.sourceforge.fenixedu.domain.exceptions.DomainException;
import net.sourceforge.fenixedu.presentationTier.Action.base.FenixDispatchAction;
import net.sourceforge.fenixedu.presentationTier.Action.exceptions.FenixActionException;
import net.sourceforge.fenixedu.presentationTier.Action.resourceAllocationManager.utils.PresentationConstants;
import net.sourceforge.fenixedu.util.PeriodState;

import org.apache.commons.beanutils.BeanComparator;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.Predicate;
import org.apache.commons.collections.Transformer;
import org.apache.commons.collections.comparators.ComparatorChain;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.DynaActionForm;
import org.apache.struts.util.LabelValueBean;
import org.apache.struts.validator.DynaValidatorForm;

import pt.ist.fenixWebFramework.struts.annotations.Forward;
import pt.ist.fenixWebFramework.struts.annotations.Forwards;
import pt.ist.fenixWebFramework.struts.annotations.Mapping;

/**
 * @author Fernanda Quitério 17/Dez/2003
 * 
 */
@Mapping(module = "manager", path = "/insertExecutionCourse", attribute = "insertExecutionCourseForm",
        formBean = "insertExecutionCourseForm", scope = "request", parameter = "method")
@Forwards({ @Forward(name = "firstPage", path = "df.executionCourseManagement.page.firstPage"),
        @Forward(name = "insertExecutionCourse", path = "df.executionCourseManagement.page.insertExecutionCourse") })
public class InsertExecutionCourseDispatchAction extends FenixDispatchAction {

    public ActionForward prepare(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
        return prepareInsertExecutionCourse(mapping, form, request, response);
    }

    public ActionForward prepareInsertExecutionCourse(ActionMapping mapping, ActionForm form, HttpServletRequest request,
            HttpServletResponse response) {

        List infoExecutionPeriods = null;
        infoExecutionPeriods = ReadExecutionPeriods.run();

        if (infoExecutionPeriods != null && !infoExecutionPeriods.isEmpty()) {
            // exclude closed execution periods
            infoExecutionPeriods = (List) CollectionUtils.select(infoExecutionPeriods, new Predicate() {
                @Override
                public boolean evaluate(Object input) {
                    InfoExecutionPeriod infoExecutionPeriod = (InfoExecutionPeriod) input;
                    if (!infoExecutionPeriod.getState().equals(PeriodState.CLOSED)) {
                        return true;
                    }
                    return false;
                }
            });

            ComparatorChain comparator = new ComparatorChain();
            comparator.addComparator(new BeanComparator("infoExecutionYear.year"), true);
            comparator.addComparator(new BeanComparator("name"), true);
            Collections.sort(infoExecutionPeriods, comparator);

            List<LabelValueBean> executionPeriodLabels = new ArrayList<LabelValueBean>();
            CollectionUtils.collect(infoExecutionPeriods, new Transformer() {
                @Override
                public Object transform(Object arg0) {
                    InfoExecutionPeriod infoExecutionPeriod = (InfoExecutionPeriod) arg0;

                    LabelValueBean executionPeriod =
                            new LabelValueBean(infoExecutionPeriod.getName() + " - "
                                    + infoExecutionPeriod.getInfoExecutionYear().getYear(), infoExecutionPeriod.getIdInternal()
                                    .toString());
                    return executionPeriod;
                }
            }, executionPeriodLabels);

            request.setAttribute(PresentationConstants.LIST_EXECUTION_PERIODS, executionPeriodLabels);

            List<LabelValueBean> entryPhases = new ArrayList<LabelValueBean>();
            for (EntryPhase entryPhase : EntryPhase.values()) {
                LabelValueBean labelValueBean = new LabelValueBean(entryPhase.getLocalizedName(), entryPhase.getName());
                entryPhases.add(labelValueBean);
            }
            request.setAttribute("entryPhases", entryPhases);

        }

        return mapping.findForward("insertExecutionCourse");
    }

    public ActionForward insertExecutionCourse(ActionMapping mapping, ActionForm form, HttpServletRequest request,
            HttpServletResponse response) throws FenixActionException, FenixFilterException {

        InfoExecutionCourseEditor infoExecutionCourse = fillInfoExecutionCourse(form, request);

        try {
            InsertExecutionCourseAtExecutionPeriod.run(infoExecutionCourse);
            addActionMessage("success", request, "message.manager.executionCourseManagement.insert.success",
                    infoExecutionCourse.getNome(), infoExecutionCourse.getSigla(), infoExecutionCourse.getInfoExecutionPeriod()
                            .getExecutionPeriod().getName(), infoExecutionCourse.getInfoExecutionPeriod().getExecutionPeriod()
                            .getExecutionYear().getYear());
        } catch (DomainException ex) {
            addActionMessage("error", request, ex.getMessage(), ex.getArgs());
            return prepareInsertExecutionCourse(mapping, form, request, response);
        } catch (FenixServiceException ex) {
            addActionMessage("error", request, ex.getMessage());
        }
        return mapping.findForward("firstPage");
    }

    private InfoExecutionCourseEditor fillInfoExecutionCourse(ActionForm form, HttpServletRequest request) {

        DynaActionForm dynaForm = (DynaValidatorForm) form;

        InfoExecutionCourseEditor infoExecutionCourse = new InfoExecutionCourseEditor();

        String name = (String) dynaForm.get("name");
        infoExecutionCourse.setNome(name);

        String code = (String) dynaForm.get("code");
        infoExecutionCourse.setSigla(code);

        String executionPeriodId = (String) dynaForm.get("executionPeriodId");

        InfoExecutionPeriod infoExecutionPeriod =
                new InfoExecutionPeriod(rootDomainObject.readExecutionSemesterByOID(new Integer(executionPeriodId)));
        infoExecutionCourse.setInfoExecutionPeriod(infoExecutionPeriod);

        String comment = "";
        if ((String) dynaForm.get("comment") != null) {
            comment = (String) dynaForm.get("comment");
        }
        infoExecutionCourse.setComment(comment);

        String entryPhaseString = dynaForm.getString("entryPhase");
        EntryPhase entryPhase = null;
        if (entryPhaseString != null && entryPhaseString.length() > 0) {
            entryPhase = EntryPhase.valueOf(entryPhaseString);
        }
        infoExecutionCourse.setEntryPhase(entryPhase);

        return infoExecutionCourse;
    }
}