<%@ include file="/WEB-INF/jspf/init.jspf" %>

<% fll.web.scoreEntry.SelectTeam.populateContext(application, pageContext);%>

<html>
  <head>
    <link rel="stylesheet" type="text/css" href="<c:url value='/style/fll-sw.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/style/bootstrap/bootstrap.min.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/style/bootstrap/bootstrap-theme.min.css'/>" />
 
  <title>Teams QR Codes</title>

  
<meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
<meta content="IE=edge" http-equiv="X-UA-Compatible">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" >
 
<script src="<c:url value='/extlib/jquery-3.2.0.min.js'/>"></script>
<script src="<c:url value='/extlib/bootstrap/bootstrap.min.js'/>"></script>
<script type='text/javascript'>



function refreshImage(){
	var teamNumber = $('#select-teamnumber').val();
	var teamName = $('#select-teamnumber :selected').text();
	if(teamNumber != null){
		$('#QR-Code-label').text(teamName);
		$('#team-QR-Code').attr('src', "https://api.qrserver.com/v1/create-qr-code/?size=150x150&qzone=4&data=http://fllrdsk.com/fll-sw/login.jsp?tNumber=" + teamNumber);
	}
	else{
		$('#team-QR-Code').attr('src', "../images/Team QR Codes/Error_Message.png");	
	}
	};
	
function ImgError(source){
	source.src = "../images/Team QR Codes/Error_Message.png";
	return true;
}
	
$(document).ready(function() {
  refreshImage();
});
</script>
  </head>
  <body>

      
	<div class="panel panel-primary">
		<div class="panel-heading">
			<div class="col-xs-1">
				<a href="/">
					<img src="../images/challenge-logo.jpg" alt="Home" style="width:75%">
				</a>
			</div>		
			<div class="h1">${challengeDescription.title }</div>
		</div>
					
		<div class="panel-body">
			<div class="panel panel-info">					
				<div class="panel-heading">
					<h3 class="panel-title">Teams QR Code Selection Page</h3>
				</div>
				<div class='status-message'>${message}</div>
				<%-- clear out the message, so that we don't see it again --%>
				<c:remove var="message" />
				<div class="panel-body">
					<div class="col-lg-6 col-md-6 col-sm-6">	
							<div class="panel panel-default">
								<div class="panel-heading">Team Selection</div>
								<div class="panel-body">
									<label for="select-teamnumber">Select a team to see according QR Code:</label>
										<select class="form-control" size='20' id='select-teamnumber' name='TeamNumber' onclick='refreshImage()'>
										  <c:forEach items="${tournamentTeams }" var="team">
											<c:if test="${not team.internal }">
											  <option value="${team.teamNumber }">${team.teamNumber }&nbsp;&nbsp;&nbsp;[${team.trimmedTeamName }]</option>
											</c:if>
										  </c:forEach>
										</select>
								</div>
							</div>	
					</div>
					<div class="col-lg-6 col-md-6 col-sm-6">
							<div class="panel panel-default">
								<div class="panel-heading">Team QR Code</div>
								<div class="panel-body">
									<label id="QR-Code-label" for="qr-code-image"></label>
									<div class="well">
										<img id="team-QR-Code" class="img-responsive" src="../images/Team QR Codes/QRCode-Team-1701.png" alt=$('#select-teamnumber :selected').text(); onerror="ImgError(this)">
									</div>
								</div>
							</div>
					</div>
				</div>
				<div class="panel-body">
					<a href="../images/Team QR Codes/Team QR Codes Compressed.zip" class="btn btn-primary">Download all Team QR Codes</a>
				</div>
			</div>
		</div>
	</div>

  </body>
</html>