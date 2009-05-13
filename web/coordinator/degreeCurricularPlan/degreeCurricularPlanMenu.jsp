<%@ page language="java" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %><html:xhtml/>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ page import="net.sourceforge.fenixedu.presentationTier.Action.resourceAllocationManager.utils.PresentationConstants" %>
<%@ page import="net.sourceforge.fenixedu.dataTransferObject.InfoExecutionDegree" %>

<%
Integer degreeCurricularPlanID = null;
if(request.getAttribute("degreeCurricularPlanID") instanceof String){
    degreeCurricularPlanID = Integer.valueOf((String) request.getAttribute("degreeCurricularPlanID"));
} else if(request.getAttribute("degreeCurricularPlanID") instanceof Integer){
    degreeCurricularPlanID = (Integer) request.getAttribute("degreeCurricularPlanID");   
}
if (degreeCurricularPlanID == null) {
    degreeCurricularPlanID = Integer.valueOf(request.getParameter("degreeCurricularPlanID"));
}
%>

<logic:present name="<%= PresentationConstants.MASTER_DEGREE %>"  >
	<bean:define id="infoExecutionDegree" name="<%= PresentationConstants.MASTER_DEGREE %>" scope="session" type="InfoExecutionDegree" />
	<br/>
	<ul>
		<li class="navheader">
			<bean:message key="link.coordinator.degreeCurricularPlan.management"/>
		</li>
		<logic:equal name="infoExecutionDegree" property="bolonhaDegree" value="false">
			<li>
				<html:link page="<%= "/degreeCurricularPlanManagement.do?method=showActiveCurricularCourses&amp;degreeCurricularPlanID=" + degreeCurricularPlanID%>">
				    <bean:message key="link.coordinator.degreeCurricular.viewActive" />
				</html:link>
			</li>
			<li>
				<html:link page="<%= "/degreeCurricularPlanManagement.do?method=showCurricularCoursesHistory&amp;degreeCurricularPlanID=" + degreeCurricularPlanID%>">
				    <bean:message key="link.coordinator.degreeCurricular.viewHistory" />
				</html:link>
			</li>
		</logic:equal>
		<logic:equal name="infoExecutionDegree" property="bolonhaDegree" value="true">
			<li>
				<html:link page="<%= "/degreeCurricularPlan/showAllCompetenceCourses.faces?degreeCurricularPlanID=" + degreeCurricularPlanID%>">
				    <bean:message key="list.competence.courses" />
				</html:link>

				<html:link page="<%= "/degreeCurricularPlan/equivalencyPlan.do?method=showPlan&amp;degreeCurricularPlanID=" + degreeCurricularPlanID %>">
				    <bean:message key="link.equivalency.plan" />
				</html:link>

			</li>
		</logic:equal>
	</ul>
</logic:present>
