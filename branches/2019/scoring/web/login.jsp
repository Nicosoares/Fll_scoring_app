<%@ include file="/WEB-INF/jspf/init.jspf"%>

<!DOCTYPE HTML>
<html>
<head>
<title>Login Page</title>
<link rel="stylesheet" type="text/css"
 href="<c:url value='/style/fll-sw.css'/>" />
 
 <link
  rel="stylesheet"
  href="extlib/jquery.mobile-1.4.5.min.css" />

 <link rel="stylesheet" type="text/css" href="<c:url value='/style/bootstrap/bootstrap.min.css'/>" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/style/bootstrap/bootstrap-theme.min.css'/>" />

 <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
 <meta content="IE=edge" http-equiv="X-UA-Compatible">
 <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" >
 
 <script src="<c:url value='/extlib/jquery-3.2.0.min.js'/>"></script>
 <script src="<c:url value='/extlib/bootstrap/bootstrap.min.js'/>"></script>
 
<script
  type='text/javascript'
  src='extlib/jquery-1.11.1.min.js'></script>
<script
  type='text/javascript'
  src='extlib/jquery.mobile-1.4.5.min.js'></script>
 
</head>
<body>

<div class="container-fluid">
   <div class="modal-dialog">
        <div class="loginmodal-container">     
     <h1>Welcome to FLL Dominican Republic</h1>

     <div class='status-message'>${message}</div>
     <%-- clear out the message, so that we don't see it again --%>
     <c:remove var="message" />
     
         <form class="form-horizontal" method="POST" action="DoLogin" name="login" data-ajax="false">
			  <c:if test='${not empty param.tNumber}'>
				<input type="hidden" name="tNumber" value="<%= request.getParameter("tNumber") %>">
			  </c:if>              
			  <input type="text" class="form-control" id="inputUsername" placeholder="Username" size="15" maxlength="64" name="user" autocorrect="off" autocapitalize="off" autocomplete="off" spellcheck="false">
              <input type="password" class="form-control" id="inputPassword" placeholder="Password" size="15" name="pass">
              <button type="submit" class="btn btn-default">Sign in</button>
         </form>
        </div>
   </div>
</div>     
</body>
</html>
