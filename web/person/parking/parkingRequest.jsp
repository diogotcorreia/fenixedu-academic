<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<html:xhtml />
<%@ taglib uri="/WEB-INF/fenix-renderers.tld" prefix="fr"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ page
	import="net.sourceforge.fenixedu.presentationTier.Action.resourceAllocationManager.utils.PresentationConstants"%>

<em><bean:message key="label.person.main.title" /></em>
<h2><bean:message key="label.parking" bundle="PARKING_RESOURCES" /></h2>


<logic:present name="parkingParty">

	<p class="mtop15 mbottom025"><strong><bean:message	key="label.person.title.personal.info" /></strong></p>

	<fr:view name="parkingParty" property="party" schema="viewPersonInfo">
		<fr:layout name="tabular">
			<fr:property name="classes" value="tstyle1 thright thlight mtop025" />
		</fr:layout>
	</fr:view>
	<logic:empty name="parkingParty" property="parkingRequests">
		<logic:equal name="parkingParty" property="hasAllNecessaryPersonalInfo" value="false">
			<p class="infoop2">
				<bean:message key="message.personalDataCondition" bundle="PARKING_RESOURCES" /><br/>
				<bean:message key="message.no.necessaryPersonalInfo" bundle="PARKING_RESOURCES" />
			</p>
		</logic:equal>
		<logic:notEqual name="parkingParty"	property="hasAllNecessaryPersonalInfo" value="false">
			<p>
				<bean:message key="label.read.parkingRegulation" bundle="PARKING_RESOURCES" />: 
				<html:link page="/parking.do?method=downloadParkingRegulamentation">
					<bean:message key="label.parkingRegulation" bundle="PARKING_RESOURCES" />
					<bean:message key="label.parkingRegulation.pdf" bundle="PARKING_RESOURCES" />
				</html:link>
			</p>


			<logic:equal name="parkingParty" property="acceptedRegulation" value="false">				
				<div class="mvert1 infoop2">
					<p class="mvert05"><bean:message key="message.acceptRegulationCondition" bundle="PARKING_RESOURCES" /></p>
					<p class="mvert05"><bean:message key="message.acceptRegulation" bundle="PARKING_RESOURCES" /></p>
					<p class="mvert05">
						<strong>
							<html:link page="/parking.do?method=acceptRegulation">
								<bean:message key="button.acceptRegulation" bundle="PARKING_RESOURCES" /> &raquo;
							</html:link>
						</strong>
					</p>
				</div>
			</logic:equal>

			<logic:notEqual name="parkingParty" property="acceptedRegulation" value="false">
				
				<div class="infoop2 mtop15"> <%-- message.acceptedRegulation --%>
					<div style="padding-bottom: 0.25em;"><bean:write name="parkingParty" property="parkingAcceptedRegulationMessage" filter="false"/></div>
					<p>
						<strong>
							<html:link page="/parking.do?method=prepareEditParking">
								<bean:message key="label.insertParkingDocuments" bundle="PARKING_RESOURCES" /> &raquo;
							</html:link>
						</strong>
					</p>
				</div>
				

				
			</logic:notEqual>
		</logic:notEqual>
	</logic:empty>
	<logic:notEmpty name="parkingParty" property="parkingRequests">
		<p>
			<bean:message key="label.read.parkingRegulation" bundle="PARKING_RESOURCES" />: 
			<html:link page="/parking.do?method=downloadParkingRegulamentation">
				<bean:message key="label.parkingRegulation" bundle="PARKING_RESOURCES" />
				<bean:message key="label.parkingRegulation.pdf" bundle="PARKING_RESOURCES" />
			</html:link>
		</p>
			
		
		<logic:equal name="parkingParty" property="canRequestUnlimitedCardAndIsInAnyRequestPeriod" value="true">
			<div class="mvert15">
				<div class="infoop2">
					<bean:message key="message.canRenewToUnlimitedCard" bundle="PARKING_RESOURCES"/>
				</div>
				<ul class="mvert05">
					<li>
						<html:link page="/parking.do?method=renewUnlimitedParkingRequest">
							<bean:message key="label.renewToUnlimitedCard" bundle="PARKING_RESOURCES" />
						</html:link>
					</li>
				</ul>
			</div>
		</logic:equal>
		<logig:present name="renewUnlimitedParkingRequest.sucess">
			<logic:equal name="renewUnlimitedParkingRequest.sucess" value="true">
			<p class="mtop15"><strong class="success0"><bean:message key="message.renewUnlimitedParkingRequest.sucess" bundle="PARKING_RESOURCES"/></strong></p>
			</logic:equal>
		</logig:present
		
		<%-- editar --%>
		<logic:equal name="canEdit" value="true">
			<p>
				<div class="infoop2"><bean:message key="message.pendingParkingRequestState" bundle="PARKING_RESOURCES" /></div>
			</p>
			<p>
				<html:link page="/parking.do?method=prepareEditParking">
					<bean:message key="label.editParkingDocuments"
						bundle="PARKING_RESOURCES" />
				</html:link>
			</p>
		</logic:equal>
		
		<bean:define id="parkingPartyOrRequest" name="parkingParty"/>
		<logic:notEmpty name="parkingParty" property="vehicles">
			<h3 class="separator2 mtop2"><bean:message key="label.actualState" bundle="PARKING_RESOURCES"/></h3>
			<fr:view name="parkingParty" schema="show.parkingParty.cardValidPeriod">
				<fr:layout name="tabular">
					<fr:property name="classes" value="tstyle1 thright thlight mtop025 mbottom1" />
					<fr:property name="headerClasses" value="acenter" />
				</fr:layout>
			</fr:view>
		</logic:notEmpty>
		<logic:empty name="parkingParty" property="vehicles">
			<h3 class="separator2 mtop2"><bean:message key="label.request" bundle="PARKING_RESOURCES"/></h3>
			<bean:define id="parkingPartyOrRequest" name="parkingParty" property="lastRequest"/>
		</logic:empty>
		
		<p class="mtop15 mbottom025"><strong><bean:message key="label.driverLicense" bundle="PARKING_RESOURCES" /></strong></p>		
		<table class="tstyle1 thright thlight mtop025 mbottom1">
			<tr>
				<th><bean:message key="label.driverLicense" bundle="PARKING_RESOURCES"/></th>
				<td><bean:write name="parkingPartyOrRequest" property="driverLicenseFileNameToDisplay"/></td>
				<td class="noborder">
				<bean:define id="partyDriverLicenselink" name="parkingPartyOrRequest" property="declarationDocumentLink" type="java.lang.String"/>
				<logic:notEqual name="partyDriverLicenselink" value="">							
					<html:link href="<%= partyDriverLicenselink %>" target="_blank">
						<bean:message key="link.viewDocument" bundle="PARKING_RESOURCES" />
					</html:link>		
				</logic:notEqual>		
				</td>
			</tr>
		</table>
		
		<p class="mtop1 mbottom025"><strong><bean:message key="label.vehicles" bundle="PARKING_RESOURCES" /></strong></p>
		<table class="tstyle1 thright thlight mtop025 mbottom1">
		<logic:iterate id="vehicle" name="parkingPartyOrRequest" property="vehicles">
			<tr>
				<th><bean:message key="label.vehicleMake" bundle="PARKING_RESOURCES"/>:</th>
				<td><bean:write name="vehicle" property="vehicleMake"/></td>
				<td class="noborder"></td>
			</tr>
			<tr>
				<th><bean:message key="label.vehiclePlateNumber" bundle="PARKING_RESOURCES"/>:</th>
				<td><bean:write name="vehicle" property="plateNumber"/></td>
				<td class="noborder"></td>
			</tr>
			<tr>
				<th><bean:message key="label.vehiclePropertyRegistry" bundle="PARKING_RESOURCES"/>:</th>
				<td><bean:write name="vehicle" property="propertyRegistryFileNameToDisplay"/></td>
				<td class="noborder">
				<bean:define id="vehiclePropertyRegisterLink" name="vehicle" property="propertyRegistryDocumentLink" type="java.lang.String"/>
				<logic:notEqual name="vehiclePropertyRegisterLink" value="">							
					<html:link href="<%= vehiclePropertyRegisterLink %>" target="_blank">
						<bean:message key="link.viewDocument" bundle="PARKING_RESOURCES" />
					</html:link>		
				</logic:notEqual>		
				</td>
			</tr>	
			<tr>
				<th><bean:message key="label.vehicleInsurance" bundle="PARKING_RESOURCES"/>:</th>
				<td><bean:write name="vehicle" property="insuranceFileNameToDisplay"/></td>
				<td class="noborder">
				<bean:define id="vehicleInsuranceLink" name="vehicle" property="insuranceDocumentLink" type="java.lang.String"/>
				<logic:notEqual name="vehicleInsuranceLink" value="">							
					<html:link href="<%= vehicleInsuranceLink %>" target="_blank">
						<bean:message key="link.viewDocument" bundle="PARKING_RESOURCES" />
					</html:link>		
				</logic:notEqual>		
				</td>
			</tr>
			<tr>
				<th><bean:message key="label.vehicleOwnerID" bundle="PARKING_RESOURCES"/>:</th>
				<td><bean:write name="vehicle" property="ownerIdFileNameToDisplay"/></td>
				<td class="noborder">
				<bean:define id="vehicleOwnerIDLink" name="vehicle" property="ownerIdDocumentLink" type="java.lang.String"/>
				<logic:notEqual name="vehicleOwnerIDLink" value="">							
					<html:link href="<%= vehicleOwnerIDLink %>" target="_blank">
						<bean:message key="link.viewDocument" bundle="PARKING_RESOURCES" />
					</html:link>		
				</logic:notEqual>		
				</td>
			</tr>
			<tr>
				<th><bean:message key="label.vehicleAuthorizationDeclaration" bundle="PARKING_RESOURCES"/>:</th>
				<td><bean:write name="vehicle" property="authorizationDeclarationFileNameToDisplay"/></td>
				<td class="noborder">
				<bean:define id="vehicleAuthorizationDeclarationLink" name="vehicle" property="declarationDocumentLink" type="java.lang.String"/>
				<logic:notEqual name="vehicleAuthorizationDeclarationLink" value="">							
					<html:link href="<%= vehicleAuthorizationDeclarationLink %>" target="_blank">
						<bean:message key="link.viewDocument" bundle="PARKING_RESOURCES" />
					</html:link>		
				</logic:notEqual>		
				</td>
			</tr>
			<tr>
				<td class="noborder"> </td>
				<td class="noborder"> </td>
				<td class="noborder"> </td>
		</logic:iterate>
		</table>


		<h3 class="separator2 mtop2"><bean:message key="label.requests" bundle="PARKING_RESOURCES"/></h3>

		<fr:view name="parkingParty" property="orderedParkingRequests" schema="show.parkingRequestToUser">
			<fr:layout name="tabular">
				<fr:property name="classes" value="tstyle1 mtop05 printborder" />
				<fr:property name="headerClasses" value="acenter" />
			</fr:layout>
		</fr:view>
	</logic:notEmpty>
</logic:present>
