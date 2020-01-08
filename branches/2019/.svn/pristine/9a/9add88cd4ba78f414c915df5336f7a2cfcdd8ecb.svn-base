<%@ include file="/WEB-INF/jspf/init.jspf"%>

<%@page import="fll.web.admin.GatherOrganizationData"%>

<%
  GatherOrganizationData.populateContext(request, application, pageContext);
%>


<html>

<head>
<title>Edit Organization</title>
<link rel="stylesheet" type="text/css" href="<c:url value='/style/fll-sw.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/style/bootstrap/bootstrap.min.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/style/bootstrap/bootstrap-theme.min.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/style/bootstrap/bootstrap-slider.min.css'/>" />

<meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
<meta content="IE=edge" http-equiv="X-UA-Compatible">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" >

<script src="<c:url value='/extlib/jquery-3.2.0.min.js'/>"></script>
<script src="<c:url value='/extlib/bootstrap/bootstrap.min.js'/>"></script>
</head>

<body>

 <div class='status-message'>${message}</div>
 <%-- clear out the message, so that we don't see it again --%>
 <c:remove var="message" />

 <div class="panel panel-primary">
		<div class="panel-heading">
			<div align="center">
				<h1>FIRST LEGO League</h1>
			</div>
			<div align="center">
				<h2>Dominican Republic</h2>
			</div>
		</div>
		
<div class="panel-body">
	<div class="panel panel-info">
		<div class="panel-heading">
			<h3 class="panel-title">Edit organization data.</h3>
		</div>
		<div class="panel-body">
			<div class="list-group">
				<form method="POST" action="EditOrganization" name="edit_organization">		
					<input type="hidden" name="addOrganization" value='${addOrganization}'>				
					<input type="hidden" name="organizationId" value='${organizationId}'>				
					<div class="">
						<input type="text" class="form-control" placeholder="Name" size="15" maxlength="64" name="name" value='${name}' autocorrect="off" autocapitalize="off" autocomplete="off" spellcheck="false">
					</div>
					<div class="">
						<input type="text" class="form-control" placeholder="Address" size="15" maxlength="128" name="address" value='${address}' autocorrect="off" autocapitalize="off" autocomplete="off" spellcheck="false">
					</div>
					<div>
					<input type="text" class="form-control" placeholder="Phone" size="15" name="phone" value='${phone}'>
					</div>
					<div>
					<input type="text" class="form-control" placeholder="Email" size="15" name="email" value='${email}'>
					</div>
					<div>
					<input type="text" class="form-control" placeholder="Contact" size="15" name="website" value='${website}'>
					</div>
					<input name="submit_edit_org" value="Save Changes" type="submit" class="btn btn-primary"></input>
					
				</form>
			</div>
		</div>
	</div>  
</div>
 </div>	
</body>

</html>