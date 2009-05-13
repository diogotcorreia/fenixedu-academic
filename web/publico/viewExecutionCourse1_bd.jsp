<%@ page language="java" %><%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %><html:xhtml/><%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %><%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %><%@ taglib uri="/WEB-INF/taglibs-datetime.tld" prefix="dt" %><%@ page import="net.sourceforge.fenixedu.presentationTier.Action.resourceAllocationManager.utils.PresentationConstants" %><%@ page import="java.lang.Integer" %><%@ page import="java.lang.String" %><%@ page import="net.sourceforge.fenixedu.domain.degree.DegreeType" %><logic:notPresent name="siteView"><table align="center" cellpadding='0' cellspacing='0'>
    <tr align="center">
        <td>
            <span class="error"><!-- Error messages go here -->
                <bean:message key="errors.invalidSiteExecutionCourse"/>
            </span>
        </td>
    </tr>
</table></logic:notPresent><logic:present name="siteView">    <logic:notPresent name="siteView" property="component">        <table align="center"  cellpadding='0' cellspacing='0'>			<tr align="center">				<td>					<span class="error"><!-- Error messages go here -->					     <bean:message key="message.public.notfound.executionCourse"/> 					 </span>				</td>			</tr>		</table>    </logic:notPresent><logic:present name="siteView" property="component">    <br/><bean:define id="component" name="siteView" property="commonComponent" /><bean:define id="curricularCourses" name="component" property="associatedDegrees" /><div id="associated-degrees">		<logic:iterate id="curricularCourse" name="curricularCourses" >			<bean:define id="infoDegreeCurricularPlan" name="curricularCourse" property="infoDegreeCurricularPlan"/>			<bean:define id="degreeCurricularPlanID" name="infoDegreeCurricularPlan" property="idInternal" />			<bean:define id="shift" name="shift"/>	   		<logic:equal name="degreeCurricularPlanID" value="<%= request.getAttribute("degreeCurricularPlanID").toString() %>" >			<br/>			<bean:define id="institutionUrl" type="java.lang.String"><bean:message key="institution.url" bundle="GLOBAL_RESOURCES"/></bean:define>			<div class="breadcumbs mvert0"><a href="<%= institutionUrl %>"><bean:message key="institution.name.abbreviation" bundle="GLOBAL_RESOURCES"/></a>			<bean:define id="degreeType" name="infoDegreeCurricularPlan" property="infoDegree.tipoCurso.name" />				<logic:equal name="degreeType" value="MASTER_DEGREE">				 <html:link page="<%= "/showDegrees.do?method=master&executionPeriodOID=" + request.getAttribute(PresentationConstants.EXECUTION_PERIOD_OID) %>" >Ensino Mestrados</html:link>			</logic:equal>			<logic:equal name="degreeType" value="DEGREE">				<html:link page="<%= "/showDegrees.do?method=nonMaster&executionPeriodOID=" + request.getAttribute(PresentationConstants.EXECUTION_PERIOD_OID) %>" >Ensino Licenciaturas</html:link>					</logic:equal>			&gt;&nbsp;			<html:link page="<%= "/showDegreeSite.do?method=showDescription&amp;degreeID=" + request.getAttribute("degreeID").toString()%>">				<bean:write name="infoDegreeCurricularPlan" property="infoDegree.sigla" />			</html:link>&gt;&nbsp;			<html:link page="<%= "/showDegreeSite.do?method=showCurricularPlan&amp;degreeID=" + request.getAttribute("degreeID") + "&amp;degreeCurricularPlanID=" + pageContext.findAttribute("degreeCurricularPlanID").toString() + "&amp;executionPeriodOID=" + request.getAttribute(PresentationConstants.EXECUTION_PERIOD_OID) + "&amp;executionDegreeID="  + "&amp;index=" + request.getAttribute("index")  %>" >				<bean:write name="infoDegreeCurricularPlan" property="name" />			</html:link>&gt;&nbsp; 			<logic:equal name="shift" value="false"> 				<html:link page="<%= "/chooseExamsMapContextDANew.do?executionPeriodOID=" +  request.getAttribute(PresentationConstants.EXECUTION_PERIOD_OID) + "&amp;degreeID="+ request.getAttribute("degreeID") + "&amp;degreeCurricularPlanID="+ pageContext.findAttribute("degreeCurricularPlanID").toString() + "&amp;page=1&method=choose&selectAllCurricularYears=on" + "&amp;index=" + request.getAttribute("index") %>" >					<bean:message  key="public.degree.information.label.exams"  bundle="PUBLIC_DEGREE_INFORMATION" /> 				</html:link>&gt;&nbsp; 			</logic:equal>			<logic:equal name="shift" value="true"> 					<html:link page="<%= "/chooseContextDANew.do?method=nextPagePublic&nextPage=classSearch&inputPage=chooseContext&executionPeriodOID=" + request.getAttribute(PresentationConstants.EXECUTION_PERIOD_OID)+ "&amp;degreeID=" + request.getAttribute("degreeID")+ "&amp;degreeCurricularPlanID=" + pageContext.findAttribute("degreeCurricularPlanID").toString() %>" >					<bean:message  key="public.degree.information.label.classes"  bundle="PUBLIC_DEGREE_INFORMATION" />				</html:link>&gt;&nbsp; 			</logic:equal>			<%= request.getAttribute("sigla").toString() %></div>	<%--<!-- P�GINA EM INGL�S -->	<div class="version">		<span class="px10">			<html:link page="<%= "/showDegreeSite.do?method=showCurricularPlan&amp;inEnglish=true&amp;executionPeriodOID=" + request.getAttribute(PresentationConstants.EXECUTION_PERIOD_OID) + "&amp;degreeID=" +  request.getAttribute("degreeID") + "&amp;executionDegreeID="  +  request.getAttribute("executionDegreeID") + "&amp;index=" + request.getAttribute("index") %>" >english version</html:link> <img src="<%= request.getContextPath() %>/images/icon_uk.gif" alt="<bean:message key="icon_uk" bundle="IMAGE_RESOURCES" />" width="16" height="12" />	</span>		</div>--%>	<div class="clear"></div> <h1><bean:write name="infoDegreeCurricularPlan" property="infoDegree.tipoCurso" />&nbsp;<bean:write name="infoDegreeCurricularPlan" property="infoDegree.nome" /></h1><h2><span class="greytxt">	<bean:message key="public.degree.information.label.curricularPlan"  bundle="PUBLIC_DEGREE_INFORMATION" />	<bean:message key="label.of" />	<bean:define id="initialDate" name="infoDegreeCurricularPlan" property="initialDate" />			<%= initialDate.toString().substring(initialDate.toString().lastIndexOf(" ")+1) %>	<logic:notEmpty name="infoDegreeCurricularPlan" property="endDate">		<bean:define id="endDate" name="infoDegreeCurricularPlan" property="endDate" />			-<%= endDate.toString().substring(endDate.toString().lastIndexOf(" ")) %>	</logic:notEmpty></span></h2><br /></logic:equal>	</logic:iterate>	</div>            <bean:define id="component" name="siteView" property="component" />	        <logic:notEmpty name="component" property="initialStatement">            <table align="center" cellspacing="0" width="90%">             <tr>               <td class="citation">                 <p><bean:write name="component" property="initialStatement" filter="false"/></p>               </td>            </tr>            </table>		         <br/>         <br/>        </logic:notEmpty>		        <logic:notEmpty name="component" property="lastAnnouncement" >		            <bean:define id="announcement" name="component" property="lastAnnouncement"/>            <table id="anuncios" cellspacing="0" width="90%">            	<tr>                    <td  class="ultAnuncioAviso">             		<img border="0"  src="<%= request.getContextPath() %>/images/icon_warning.gif" alt="<bean:message key="icon_warning" bundle="IMAGE_RESOURCES" />" />            		<bean:message key="message.lastAnnouncement"/>                     </td>                      </tr>                 <tr>                    <td class="ultAnuncio">                    	<img alt="" border="0"  src="<%= request.getContextPath() %>/images/icon_anuncio.gif" alt="<bean:message key="icon_anuncio" bundle="IMAGE_RESOURCES" />"  />                    	<html:link  page="<%="/viewSite.do"+"?method=announcements&amp;objectCode=" + pageContext.findAttribute("objectCode") %>">                    	<bean:write name="announcement" property="title"/>:                    	</html:link>	                    	<br/>                        <bean:write name="announcement" property="information" filter="false"/>                    </td>                 </tr>                 <tr>		           		<td class="ultAnuncio-date">	           			<bean:message key="message.modifiedOn"/>           			<dt:format pattern="dd-MM-yyyy HH:mm">           			    <bean:write name="announcement" property="lastModifiedDate.time"/>           			  </dt:format>                </td>                </tr>                        </table>        </logic:notEmpty><br/><br/><br/><br/><br/>         <logic:notEmpty 	name="component" property="alternativeSite" >	            <h2><bean:message key="message.siteAddress" /></h2>            <bean:define id="alternativeSite" name="component" property="alternativeSite"/>            <html:link href="<%=(String)pageContext.findAttribute("alternativeSite") %>" target="_blank">			<bean:write name="alternativeSite" />            </html:link>			<br/>			<br/>			</logic:notEmpty>			        <logic:notEmpty name="component" property="introduction">     	        <h2><bean:message key="message.introduction" /></h2>          <p><bean:write name="component" property="introduction" filter="false" /></p>         <br/>        <br/>      </logic:notEmpty>		        <table>                    <logic:notEmpty name="component" property="responsibleTeachers">		                           <tr>            	<td>            		<h2><bean:message key="label.lecturingTeachers"/></h2>	            	</td>                </tr>	            <logic:iterate id="infoResponsableTeacher" name="component" property="responsibleTeachers">            	<tr>            	<td>				<bean:write name="infoResponsableTeacher" property="infoPerson.nome" /> <bean:message key="label.responsible"/>                </td>                </tr>            </logic:iterate>	        </logic:notEmpty>        <logic:notEmpty name="component" property="lecturingTeachers" >	                         <logic:empty name="component" property="responsibleTeachers">		                                           <tr>                <td>                <h2><bean:message key="label.lecturingTeachers"/></h2>	                </td>                </tr>	             </logic:empty>            <logic:iterate id="infoTeacher" name="component" property="lecturingTeachers">                <tr>                <td>				<bean:write name="infoTeacher" property="infoPerson.nome" />                 </td>                </tr>            </logic:iterate>	        </logic:notEmpty>              </table>          </logic:present></logic:present>