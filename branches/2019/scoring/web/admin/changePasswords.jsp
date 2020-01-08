<%@ include file="/WEB-INF/jspf/init.jspf"%>

<%
  fll.web.admin.ChangePasswords.populateContext(request, application, pageContext);
%>

<html>

<head>
<title>Change Passwords</title>
<link rel="stylesheet" type="text/css" href="<c:url value='/style/fll-sw.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/style/bootstrap/bootstrap.min.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/style/bootstrap/bootstrap-theme.min.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/style/bootstrap/bootstrap-slider.min.css'/>" />

<meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
<meta content="IE=edge" http-equiv="X-UA-Compatible">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" >

<script src="<c:url value='/extlib/jquery-3.2.0.min.js'/>"></script>
</head>

<body>

 <div class="panel panel-primary">
		<div class="panel-heading">
		    <div class="col-xs-1">
			  <a href="/">
				<img src="../images/challenge-logo.jpg" alt="Home" style="width:75%">
			  </a>
		    </div>		
			<div>
				<h1>${challengeDescription.title }</h1>
			</div>
		</div>
		
<div class="panel-body">
	<div class="panel panel-info">
 <c:choose>
  <c:when test="${not empty fll_user}">

   <c:choose>
    <c:when test="${all_users.size() == 1 }">
		<div class="panel-heading">
			<h3 class="panel-title">There are no users other than the one you are logged in as. There is nothing to do here.</h3>
		</div>
    </c:when>
    <c:otherwise>	
		<div class="panel-heading">
			<h3 class="panel-title">Select the user to change his password.</h3>
		</div>
		<div class="panel-body">
			<div class="form-group">
				<form method="POST" action="ChangePasswords" name="form.change_passwords">							
					<div class="form-group">
					  <select id="selected_user" name="selected_user" class="form-control" >
					   <c:forEach items="${all_users }" var="loop_user">
						<c:if test="${loop_user != fll_user }">
						 <option value="${loop_user }">${loop_user }</option>
						</c:if>
					   </c:forEach>
					  </select>
					</div>
					<div class="form-group">
					   <input type="password" class="form-control" placeholder="New Password" size="15" name="new_pass">
					</div>
					<div class="form-group">
					   <input type="password" class="form-control" placeholder="Repeat Password" size="15" name="pass_check">
					</div>

					<div class='status-message'>${message}</div>
					<%-- clear out the message, so that we don't see it again --%>
					<c:remove var="message" />

					<div class="form-group">
					  <input name="submit_change_passwords" value="Change Password" type="submit" class="btn btn-primary"></input>
					</div>					
				</form>
			</div>
		</div>
	    </c:otherwise>
   </c:choose>

  </c:when>
  <c:otherwise>
	<div class="panel-heading">
		<h3 class="panel-title">There are no users to change their passwords.</h3>
	</div>
  </c:otherwise>
 </c:choose>
	
	</div>  
</div>
 </div>


</body>

</html>
