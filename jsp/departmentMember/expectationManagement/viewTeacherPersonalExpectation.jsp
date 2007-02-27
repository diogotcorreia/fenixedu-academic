<%@ page language="java" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/fenix-renderers.tld" prefix="fr" %>
<html:xhtml/>

<em><bean:message key="label.departmentMember" bundle="DEPARTMENT_MEMBER_RESOURCES"/></em>
<h2><bean:message key="link.personalExpectationsManagement" bundle="DEPARTMENT_MEMBER_RESOURCES"/></h2>

<logic:present role="DEPARTMENT_MEMBER">
	
	<logic:messagesPresent message="true">
		<p>
			<span class="error0"><!-- Error messages go here -->
				<html:messages id="message" message="true" bundle="DEPARTMENT_MEMBER_RESOURCES">
					<bean:write name="message"/>
				</html:messages>
			</span>
		<p>
	</logic:messagesPresent>

	<logic:notEmpty name="teacherPersonalExpectationBean">

		<fr:form>
			<fr:edit id="teacherPersonalExpectationInSelectedExecutionYear" name="teacherPersonalExpectationBean" schema="ChooseExecutionYearToViewTeacherPersonalExpectations">
				<fr:destination name="postBack" path="/personalExpectationManagement.do?method=viewTeacherPersonalExpectationInSelectedExecutionYear"/>
				<fr:layout name="tabular">
					<fr:property name="classes" value="" />
					<fr:property name="columnClasses" value="" />
				</fr:layout>				
			</fr:edit>	
		</fr:form>

		<logic:empty name="teacherPersonalExpectation">		
			<p><bean:message key="label.personalExpectationsManagement.noExpectationsDefined" bundle="DEPARTMENT_MEMBER_RESOURCES"/></p>				
		</logic:empty>		

		<logic:empty name="teacherPersonalExpectation">
			<logic:notEmpty name="periodOpen">
				<logic:equal name="periodOpen" value="true">
					<p><html:link page="/personalExpectationManagement.do?method=prepareDefineTeacherPersonalExpection" paramId="executionYearID" paramName="teacherPersonalExpectationBean" paramProperty="executionYear.idInternal">
						<bean:message key="link.personalExpectationsManagement.definePersonalExpectation" bundle="DEPARTMENT_MEMBER_RESOURCES"/>										
					</html:link></p>		
				</logic:equal>
			</logic:notEmpty>
		</logic:empty>		
		
		<jsp:include page="seeTeacherPersonalExpectationsByYear.jsp"/>
			
	</logic:notEmpty>
	
</logic:present>
