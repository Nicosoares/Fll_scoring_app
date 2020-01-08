<%@ include file="/WEB-INF/jspf/init.jspf" %>

<%@ page import="fll.web.ApplicationAttributes"%>


<%@ page import="java.sql.Connection"%>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="fll.xml.ChallengeDescription"%>
<%@ page import="fll.db.Queries"%>

<%
final ChallengeDescription challengeDescription = ApplicationAttributes.getChallengeDescription(application);

final DataSource datasource = ApplicationAttributes.getDataSource(application);
final Connection connection = datasource.getConnection();
%>


<html>
  <head>
    <title>Submit Scores</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/style/fll-sw.css'/>" />
  </head>

  <body>

    <%-- save to database --%>
    <c:choose>
      <c:when test="${not empty param.delete}">
        <%Queries.deletePerformanceScore(connection, request);%>
      </c:when>
      <c:otherwise>
        <%Queries.insertOrUpdatePerformanceScore(challengeDescription, connection, request);%>
      </c:otherwise>
    </c:choose>
    <%--  <c:redirect url="select_team.jsp"/> --%>                   
	
	<c:choose>
		<c:when test='${not empty param.Referee}'>
			<c:set var="referee" value="${param.Referee}"/>
			<c:redirect url="scoreEntry_redirect.jsp?referee=${referee}"/>
		</c:when>
		<c:otherwise>
			<c:redirect url="select_team.jsp"/>
		</c:otherwise>
	</c:choose>		
			

  </body>
</html>
