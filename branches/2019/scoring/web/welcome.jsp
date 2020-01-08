<%@ include file="/WEB-INF/jspf/init.jspf"%>

<%@page import="fll.web.Welcome"%>

<html>
<head>

<link
  rel="stylesheet"
  type="text/css"
  href="<c:url value='/style/base.css'/>" />

<link rel="shortcut icon" type="image/x-icon" href="<c:url value='/images/favicon-first-lego-league-fll-en.ico'/>" />
<link rel="apple-touch-icon" href="<c:url value='/images/favicon-apple-touch-icon-first-lego-league-fll-en.png'/>" />

<meta
  http-equiv='refresh'
  content='90' />

<title>Welcome</title>
<style type='text/css'>
html {
	margin-top: 5px;
	margin-bottom: 5px;
	margin-left: 5px;
	margin-right: 5px;
}

body {
	margin-top: 4;
}

.title {
	font-weight: bold;
	font-size: 200%;
	padding: 20px;
}
</style>

</head>

<body>

  <div class='center'>
    <h1>${challengeDescription.title }</h1>

    <table align="center" width="60%">
      <tr>
        <td align="center">
          <img src='<c:url value="/images/banda superior.png"/>' width="100%" align="middle"/>
        </td>
    </table>

        <%
          Welcome.outputLogos(application, out);
        %>

    <table align="center" width="50%">
      <tr>
        <td align="center">
          <img src='images/fll_logo.gif' width="60%"/>          
        </td>
</tr>
    </table>

    <h2>${ScorePageText }</h2>

  </div>

</body>
</html>
