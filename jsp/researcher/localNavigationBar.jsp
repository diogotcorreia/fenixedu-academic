<%@ page language="java" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/fenix-renderers.tld" prefix="fr"%>

<html:xhtml/>

<logic:present role="RESEARCHER">
	<ul>
		<li><html:link page="/viewCurriculum.do"> <bean:message bundle="RESEARCHER_RESOURCES" key="link.viewCurriculum"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</html:link> </li>
		<li><html:link page="/publications/search.do?method=prepareSearchPublication"> <bean:message bundle="RESEARCHER_RESOURCES" key="label.search"/> </html:link>
	</ul>

	<ul style="margin-top: 0.75em;">
		<li><html:link page="/interests/interestsManagement.do?method=prepare"><bean:message bundle="RESEARCHER_RESOURCES" key="link.interestsManagement"/></html:link></li>
		<li><html:link page="/resultPublications/listPublications.do"><bean:message bundle="RESEARCHER_RESOURCES" key="link.Publications"/></html:link></li>
		<li><html:link page="/resultPatents/management.do"><bean:message bundle="RESEARCHER_RESOURCES" key="link.patentsManagement"/></html:link></li>			
		 
  	    <li><html:link page="/activities/activitiesManagement.do?method=listActivities"><bean:message bundle="RESEARCHER_RESOURCES" key="link.activitiesManagement"/></html:link></li>
		
		<%--
		<li class="navheader"><bean:message bundle="RESEARCHER_RESOURCES" key="link.participationsTitle"/></li>
		--%>
		<%-- 
		<li><html:link page="/resultPublications/listPublications.do"><bean:message bundle="RESEARCHER_RESOURCES" key="link.Publications"/></html:link></li>
		<li><html:link page="/projects/projectsManagement.do?method=listProjects"><bean:message bundle="RESEARCHER_RESOURCES" key="link.projectsManagement"/></html:link></li>
		--%>
	</ul>

	<bean:define id="workingResearchUnits" name="UserView" property="person.workingResearchUnits" type="java.util.List"/>

	<logic:notEmpty name="workingResearchUnits">
	<ul>
		<li class="navheader"><bean:message key="label.researchUnits" bundle="RESEARCHER_RESOURCES"/></li>
		<logic:iterate id="unit" name="workingResearchUnits">
			<bean:define id="unitID" name="unit" property="idInternal"/>
			<li> 
				<html:link page="<%= "/researchUnitFunctionalities.do?method=prepare&unitId=" + unitID %>">
							<fr:view name="unit" property="name"/>
				</html:link>
			</li>
		</logic:iterate>
	</ul>
	</logic:notEmpty>	
	
</logic:present>
