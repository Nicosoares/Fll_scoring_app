<%@ include file="/WEB-INF/jspf/init.jspf" %>

<% fll.web.scoreEntry.SelectTeam.populateContext(application, pageContext);%>

<html>
  <head>
    <link rel="stylesheet" type="text/css" href="<c:url value='/style/fll-sw.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/style/bootstrap/bootstrap.min.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/style/bootstrap/bootstrap-theme.min.css'/>" />
 
  <title>Score Entry [Select Team]</title>

  
<meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
<meta content="IE=edge" http-equiv="X-UA-Compatible">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" >
 
<script src="<c:url value='/extlib/jquery-3.2.0.min.js'/>"></script>
<script src="<c:url value='/extlib/bootstrap/bootstrap.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/extlib/jquery-1.11.1.min.js'/>"></script>
<script type='text/javascript'>

function editFlagBoxClicked() {
  if (document.selectTeam.EditFlag.checked) {
    document.selectTeam.RunNumber.disabled=false;
  } else {
    document.selectTeam.RunNumber.disabled=true;
  }
}

function reloadRuns() {
  document.body.removeChild(document.getElementById('reloadruns'));
  document.verify.TeamNumber.length = 0;
  var s = document.createElement('script');
  s.type='text/javascript';
  s.id = 'reloadruns';
  s.src='unverifiedRunsObject.jsp?' + Math.random();
  document.body.appendChild(s);
}


function messageReceived(event) {
  console.log("received: " + event.data);
  
  // data doesn't matter, just reload runs on any message
  reloadRuns();
}

function socketOpened(event) {
  console.log("Socket opened");
}

function socketClosed(event) {
  console.log("Socket closed");

  // open the socket a second later
  setTimeout(openSocket, 1000);
}

function openSocket() {
  console.log("opening socket");

  var url = window.location.pathname;
  var directory = url.substring(0, url.lastIndexOf('/'));
  var webSocketAddress = "ws://" + window.location.host + directory
      + "/UnverifiedRunsWebSocket";

  var socket = new WebSocket(webSocketAddress);
  socket.onmessage = messageReceived;
  socket.onopen = socketOpened;
  socket.onclose = socketClosed;
}

$(document).ready(function() {
  editFlagBoxClicked();
  reloadRuns();
  
  openSocket();
});
</script>
  </head>
  <body>

      <div class='status-message'>${message}</div>
      <%-- clear out the message, so that we don't see it again --%>
      <c:remove var="message" />
      
	<div class="container">
			<div class="form-group">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<div class="h3">${challengeDescription.title }</div>
						<div class="h5">Score Card Entry and Review Page</div>
					</div>
					
					
						
							<div class="panel-body">
								<div class="col-lg-6 col-md-6 col-sm-6">
									<form action="GatherScoreEntryData" method="POST" name="selectTeam">	
										<div class="panel panel-default">
											<div class="panel-heading">Score Card Entry</div>
											<div class="panel-body">
												<label for="select-teamnumber">Select team for this scorecard:</label>
													<select class="form-control" size='20' id='select-teamnumber' name='TeamNumber' ondblclick='selectTeam.submit()'>
													  <c:forEach items="${tournamentTeams }" var="team">
														<c:if test="${not team.internal }">
														  <option value="${team.teamNumber }">${team.teamNumber }&nbsp;&nbsp;&nbsp;[${team.trimmedTeamName }]</option>
														</c:if>
													  </c:forEach>
													</select>
													<div>&nbsp;</div>
													<div class="well">
														<div>
															<label for="select-run-number">
																<input type="checkbox" name='EditFlag' id='EditFlagLeft' value="1" onclick="editFlagBoxClicked()">
																Correct or double-check this score
															</label>
															<select name="RunNumber" id="select-run-number">
																<option selected value='0'>Last Run</option>
																	<c:forEach var="index" begin="1" end="${maxRunNumber}">
																<option value='${index }'>Run ${index }</option>
																	</c:forEach>
															</select>
														</div>
														<div>
															<button class='btn btn-primary' type="submit" value="Submit" id='enter_submit'>Submit</button>
														</div>
													</div>
											</div>
										</div>
									</form>	
								</div>
								<div class="col-lg-6 col-md-6 col-sm-6">
									<form action="GatherScoreEntryData" method="POST" name="verify">
										<input type="hidden" name='EditFlag' value="1" />
										<div class="panel panel-default">
											<div class="panel-heading">Score Card Verification</div>
											<div class="panel-body">
												<label for="select-verify-teamnumber">Unverified runs:</label>
													<select class="form-control" size='20' id='select-verify-teamnumber' name='TeamNumber' ondblclick='verify.submit()'></select>
													<div>&nbsp;</div>
													<div class="well">
														<button class='btn btn-primary' type="submit" value="Verify Score" id='verify_submit'>Verify Score</button>
													</div>
											</div>
										
										</div>
									</form>
								</div>
							</div>
				</div>
			</div>

	</div>
  <script type="text/javascript" id="reloadruns" src="unverifiedRunsObject.jsp"></script>
  </body>
</html>