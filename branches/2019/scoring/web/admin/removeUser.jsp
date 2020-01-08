<%@ include file="/WEB-INF/jspf/init.jspf"%>

<%
  fll.web.admin.RemoveUser.populateContext(request, application, pageContext);
%>

<html>

<head>
<title>Remove User</title>
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

			 <div class='status-message'>${message}</div>
			 <%-- clear out the message, so that we don't see it again --%>
			 <c:remove var="message" />

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
						<h3 class="panel-title">Select the user to remove. You cannot remove the user that you are logged in as.</h3>
					</div>
					<div class="panel-body">
						<div class="form-group">
							 <form name="form.remove_user" id="form.remove_user" action="RemoveUser" method="POST">
								<div class="form-group">
									<select id="remove_user" name="remove_user" size='20' class="form-control" >
										<c:forEach items="${all_users }" var="loop_user">
											<c:if test="${loop_user != fll_user }">
												<option value="${loop_user }">${loop_user }</option>
											</c:if>
										</c:forEach>
									</select> 
								</div>
								<div class="form-group">
									<input name="submit_remove_user" id="submit_remove_user" value="Remove User" type="submit" class="btn btn-primary" />
								</div>
							 </form>
						</div>
					</div>
				</c:otherwise>
			   </c:choose>

			  </c:when>
			  <c:otherwise>
				<div class="panel-heading">
					<h3 class="panel-title">You must be logged in as a user to ensure that we don't delete ALL
				users and then lock everyone out of the system. If you are connected
				from the server you should visit the <a href="<c:url value='/login.jsp'/>">login page</a>.</h3>
				</div>
			  </c:otherwise>
			 </c:choose>

		</div>  
	</div>
 </div>

</body>

</html>
