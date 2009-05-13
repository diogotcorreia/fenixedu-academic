/*
 * Created on 22/Abr/2004
 *  
 */
package net.sourceforge.fenixedu.presentationTier.Action.masterDegree.administrativeOffice.guide.reimbursementGuide;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sourceforge.fenixedu.applicationTier.IUserView;
import net.sourceforge.fenixedu.applicationTier.Filtro.exception.FenixFilterException;
import net.sourceforge.fenixedu.applicationTier.Servico.exceptions.FenixServiceException;
import net.sourceforge.fenixedu.dataTransferObject.InfoGuide;
import net.sourceforge.fenixedu.domain.GuideState;
import net.sourceforge.fenixedu.presentationTier.Action.base.FenixDispatchAction;
import net.sourceforge.fenixedu.presentationTier.Action.exceptions.FenixActionException;
import net.sourceforge.fenixedu.presentationTier.Action.exceptions.InvalidGuideSituationActionException;
import net.sourceforge.fenixedu.presentationTier.Action.exceptions.NonExistingActionException;
import net.sourceforge.fenixedu.presentationTier.Action.resourceAllocationManager.utils.ServiceUtils;
import net.sourceforge.fenixedu.presentationTier.Action.resourceAllocationManager.utils.PresentationConstants;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import pt.ist.fenixWebFramework.security.UserView;

/**
 * @author <a href="mailto:sana@ist.utl.pt">Shezad Anavarali </a>
 * @author <a href="mailto:naat@ist.utl.pt">Nadir Tarmahomed </a>
 * 
 */
public class ViewReimbursementGuidesDispatchAction extends FenixDispatchAction {

    public ActionForward view(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
	    throws FenixActionException, FenixFilterException {

	IUserView userView = UserView.getUser();

	Integer guideNumber = new Integer(this.getFromRequest("number", request));
	Integer guideYear = new Integer(this.getFromRequest("year", request));
	Integer guideVersion = new Integer(this.getFromRequest("version", request));

	InfoGuide infoGuide = null;

	Object args[] = { guideNumber, guideYear, guideVersion };
	try {
	    infoGuide = (InfoGuide) ServiceUtils.executeService("ChooseGuide", args);

	    request.setAttribute(PresentationConstants.REIMBURSEMENT_GUIDES_LIST, infoGuide.getInfoReimbursementGuides());
	} catch (FenixServiceException e) {
	    throw new FenixActionException(e.getMessage(), mapping.findForward("error"));
	}

	if (infoGuide.getInfoReimbursementGuides().isEmpty() == true)
	    throw new NonExistingActionException("error.exception.masterDegree.nonExistingReimbursementGuides", mapping
		    .findForward("error"));

	if (infoGuide.getInfoGuideSituation().getSituation().equals(GuideState.PAYED)) {
	    return mapping.findForward("start");
	}

	throw new InvalidGuideSituationActionException(mapping.findForward("error"));

    }

    private String getFromRequest(String parameter, HttpServletRequest request) {
	String parameterString = request.getParameter(parameter);
	if (parameterString == null) {
	    parameterString = (String) request.getAttribute(parameter);
	}
	return parameterString;
    }

}