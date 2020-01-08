<%@ include file="/WEB-INF/jspf/init.jspf" %>


<html>
  <head>
    <link rel="stylesheet" type="text/css" href="<c:url value='/style/fll-sw.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/style/bootstrap/bootstrap.min.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/style/bootstrap/bootstrap-theme.min.css'/>" />
 
  <title>Redirect Page</title>

  
<meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
<meta content="IE=edge" http-equiv="X-UA-Compatible">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=yes" >
 
<script src="<c:url value='/extlib/jquery-3.2.0.min.js'/>"></script>
<script src="<c:url value='/extlib/bootstrap/bootstrap.min.js'/>"></script>

</head>
  
<body>  
    <c:choose>
	<c:when test='${not empty param.referee}'>
		<input type="hidden" name="referee" value="<%= request.getParameter("referee") %>">
		<div class="container">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<div class="h3">${challengeDescription.title }</div>
				<div class="h5">Form Entry Completion</div>
			</div>
			<div class="panel-body">
              <div class="h4">El formulario ha sido enviado correctamente.</div>
              <div class="h5">En caso de nececesitar enviar otro, por favor escanea otro QR Code.</div>
              <div class="h5">De lo contrario por favor cierra esta página del navegador.</div>
			</div>
			<div class="panel-body">
				<img src='../images/minifigs/<%= request.getParameter("referee") %>.png' class='center-block img-fluid' style='height: 250px; width: auto;' />
			</div>
		</div>
	</div>
	</c:when>
	<c:otherwise>
		<div class="container">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<div class="h3">${challengeDescription.title }</div>
				<div class="h5">Form Entry Completion</div>
			</div>
				<div class="panel-body">
					El formulario ha sido enviado correctamente
					<script>window.location.href = "../index.jsp" ;</script>
				</div>
			</div>
		</div>
	</c:otherwise>
	</c:choose>
</body>
</html>