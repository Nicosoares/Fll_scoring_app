<%@ page import="fll.web.admin.Tournaments" %>
  
<%@ include file="/WEB-INF/jspf/init.jspf" %>
  
<html>
  <head>
    <link rel="stylesheet" type="text/css" href="<c:url value='/style/fll-sw.css'/>" />
    <title>Edit Tournaments</title>
  </head>

  <body>
    <h1>Edit Tournaments</h1>
<% Tournaments.generatePage(out, application, session, request, response); %>

</body></html>
