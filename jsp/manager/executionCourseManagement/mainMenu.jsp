<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %><%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%><center>	<img alt=""  src="<%= request.getContextPath() %>/images/logo-fenix.gif" width="100" height="100"/></center><p><strong>&raquo; 	<html:link page="/executionCourseManagement.do?method=mainPage">		<bean:message key="label.manager.mainPage" />	</html:link></strong></p><h2><bean:message key="label.manager.executionCourseManagement"/></h2><p><strong>&raquo; 	<html:link page="<%="/insertExecutionCourse.do?method=prepareInsertExecutionCourse"%>">		<bean:message key="label.manager.executionCourseManagement.insert.executionCourse" />	</html:link></strong></p><p><strong>&raquo; 	<html:link page="<%="/editExecutionCourseChooseExPeriod.do?method=prepareEditECChooseExecutionPeriod"%>">		<bean:message key="label.manager.executionCourseManagement.edit.executionCourse" />	</html:link></strong></p><%--<p><strong>&raquo; 	<html:link page="/readExecutionPeriods.do">		<bean:message key="label.manager.insert.executionCourse" />	</html:link></strong></p>--%><p><strong>&raquo; 	<html:link page="/chooseDegreesForExecutionCourseMerge.do?method=prepareChooseDegreesAndExecutionPeriod">		<bean:message key="label.manager.executionCourseManagement.join.executionCourse" />	</html:link></strong></p><p><strong>&raquo; 
	<html:link page="/executionCourseManagement/createCourseReportsForExecutionPeriod.faces">
		<bean:message key="link.manager.createCourseReports" />
	</html:link>
</strong></p>

<p><strong>&raquo; 
	<html:link page="/createExecutionCourses.do?method=chooseDegreeType">
		<bean:message key="link.manager.createExecutionCourses" />
	</html:link>
</strong></p>