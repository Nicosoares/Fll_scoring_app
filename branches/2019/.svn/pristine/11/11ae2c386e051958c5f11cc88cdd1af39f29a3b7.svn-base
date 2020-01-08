<%@ include file="/WEB-INF/jspf/init.jspf"%>

<html>

<head>
<title>User Creation</title>
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
			<div>
				<h1>${challengeDescription.title }</h1>
			</div>
		</div>
		
<div class="panel-body">
	<div class="panel panel-info">
		<div class="panel-heading">
			<h3 class="panel-title">Specify a username and password that is used to be able to edit information in the database.</h3>
		</div>
		<div class="panel-body">
			<div class="list-group">
				<form method="POST" action="CreateUser" name="create_user">							
					<div class="">
						<input type="text" class="form-control" placeholder="Username" size="15" maxlength="64" name="user" autocorrect="off" autocapitalize="off" autocomplete="off" spellcheck="false">
					</div>
					<div class="">
						<input type="text" class="form-control" placeholder="Full Name" size="15" maxlength="64" name="user_name" autocorrect="off" autocapitalize="off" autocomplete="off" spellcheck="false">
					</div>
					<div>
					<input type="password" class="form-control" placeholder="Password" size="15" name="pass">
					</div>
					<div>
					<input type="password" class="form-control" placeholder="Repeat Password" size="15" name="pass_check">
					</div>
					<input name="submit_create_user" value="Create User" type="submit" class="btn btn-primary"></input>
					
				</form>
			</div>
		</div>
		<div class="panel-footer" align="center">
		<img src="../images/User-Creation-QR-Code.png" alt="Create user" style="width:15%">
		</div>
	</div>  
</div>
 </div>	
</body>

</html>