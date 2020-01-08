<%@ include file="/WEB-INF/jspf/init.jspf"%>

<%
  fll.web.report.ReportIndex.populateContext(application, session, pageContext);
%>

<html>
	<head>
        <link rel="stylesheet" type="text/css" href="<c:url value='/style/fll-sw.css'/>" />
		<link rel="stylesheet" type="text/css" href="<c:url value='/style/bootstrap/bootstrap.min.css'/>" />
		<link rel="stylesheet" type="text/css" href="<c:url value='/style/bootstrap/bootstrap-theme.min.css'/>" />
		<link rel="stylesheet" type="text/css" href="<c:url value='/style/bootstrap/bootstrap-slider.min.css'/>" />

		<meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
		<meta content="IE=edge" http-equiv="X-UA-Compatible">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" >
 
		<script src="<c:url value='/extlib/jquery-3.2.0.min.js'/>"></script>
		<script src="<c:url value='/extlib/bootstrap/bootstrap.min.js'/>"></script>
		<script src="<c:url value='/extlib/bootstrap/bootstrap-slider.min.js'/>"></script>
		<script src="<c:url value='/extlib/bootstrap/bootstrap-confirmation.min.js'/>"></script>
		
		<title>FLL-SW</title>	
	</head>
  
<body>
    <div class="panel panel-primary">
		<div class="panel-heading">
			<div>
				<h1>${challengeDescription.title }</h1>
			</div>
		</div>
		<div class="panel-body">
			<div class="panel panel-info">
				<div class="panel-heading">
					<h3 class="panel-title">All Tournaments</h3>
				</div>
				<div class="panel-body">
					<div class="list-group">
						<a href="summarizePhase1.jsp" class="list-group-item">Compute summarized scores: This needs to be executed before any reports can be generated. You will be returned to this page if there are no errors summarizing scores.</a>
						<a href='FinalComputedScores' target="_blank" class="list-group-item">Final Computed Scores: This is the report that the head judge will want to determine which teams advance to the next tournament.</a>
						<a href="CategoryScoresByScoreGroup" target="_blank" class="list-group-item">Categorized Scores by Judging Group: This displays the scaled scores for each category by judging group. This is useful for checking the winners of each category.</a>
						<a href="RankingReport" target="_blank" class="list-group-item">Ranking Report for teams: This is printed at the end of the day and each team gets their page.</a>
						<a href="PerformanceScoreReport" target="_blank" class="list-group-item">Performance Score Report: This displays the details of the performance runs for each team.</a>
						<!-- <a href="PlayoffReport" target="_blank" class="list-group-item">Winners of each head to head bracket: This is useful for the awards ceremony.</a> -->
					</div>
				</div>
			</div>
			
			<!--
				**Commented for the sake of mantaining it, in case if ever needed in a future tournament**
			
				<h2>Finalist scheduling</h2>
				<p>This is used at tournaments where there is more than 1 judging
				group in an award group. This is typically the case at a state
				tournament where all teams are competing for first place in each
				category, but there are too many teams for one judge to see.</p>

				<ul>

				<li><a
				  href="non-numeric-nominees.jsp"
				  target="_blank">Enter non-numeric nominees</a>. This is used to
				  enter the teams that are up for consideration for the non-scored
				  subjective categories. This information transfers over to the
				  finalist scheduling web application. This is also used in the
				  awards scripts report.</li>

				<li><a
				  href="finalist/load.jsp"
				  target="_blank">Schedule Finalists</a>. Before visiting this page,
				  all subjective scores need to be uploaded and any head to head
				  brackets that will occur during the finalist judging should be
				  created to avoid scheduling conflicts.</li>

				<li>
				  <form
					ACTION='finalist/PrivateFinalistSchedule'
					METHOD='POST'
					target="_blank">
					<select name='division'>
					  <c:forEach
						var="division"
						items="${finalistDivisions }">
						<option value='${division }'>${division }</option>
					  </c:forEach>
					</select> <input
					  type='submit'
					  value='Private Finalist Schedule (PDF)' /> This displays the
					finalist schedule for all categories.
				  </form>
				</li>

				<li>
				  <form
					ACTION='finalist/PublicFinalistSchedule'
					METHOD='POST'
					target="_blank">
					<select name='division'>
					  <c:forEach
						var="division"
						items="${finalistDivisions }">
						<option value='${division }'>${division }</option>
					  </c:forEach>
					</select> <input
					  type='submit'
					  value='Public Finalist Schedule (PDF)' /> This displays the
					finalist schedule for public categories.
				  </form>
				</li>

				<li>
				  <form
					ACTION='finalist/PublicFinalistDisplaySchedule.jsp'
					METHOD='POST'
					target="_blank">
					<select name='division'>
					  <c:forEach
						var="division"
						items="${finalistDivisions }">
						<option value='${division }'>${division }</option>
					  </c:forEach>
					</select> <input
					  type='submit'
					  value='Public Finalist Schedule (HTML)' /> This displays the
					finalist schedule for public categories.
				  </form>
				</li>

				<li><a
				  href="finalist/TeamFinalistSchedule"
				  target="_blank">Finalist Schedule for each team</a></li>


				</ul>
			-->			
			
			<div class="panel panel-info">
				<div class="panel-heading">
					<h3 class="panel-title">Other useful reports</h3>
					<h5 class="panel-info">Some reports that are handy for intermediate reporting and checking of the current tournament state.</h5>
				</div>
				<div class="panel-body">
				<!-- 
					**Probably will be useful in the future, comenting for the sake of mantaining it in the code**
					<ul>
						<li>
						  <form
							ACTION='performanceRunReport.jsp'
							METHOD='POST'>
							Show scores for performance run <select name='RunNumber'>
							  <c:forEach
								var="index"
								begin="1"
								end="${maxRunNumber}">
								<option value='${index }'>${index }</option>
							  </c:forEach>
							</select> <input
							  type='submit'
							  value='Show Scores' />
						  </form>
						</li>

						<li>
						  <form
							action='teamPerformanceReport.jsp'
							method='post'>
							Show performance scores for team <select name='TeamNumber'>
							  <c:forEach
								items="${tournamentTeams}"
								var="team">
								<option value='<c:out value="${team.teamNumber}"/>'>
								  <c:out value="${team.teamNumber}" /> -
								  <c:out value="${team.teamName}" />
								</option>
							  </c:forEach>
							</select> <input
							  type='submit'
							  value='Show Scores' />
						  </form>
						</li>
					</ul>
				-->

					<div class="list-group">
						<a href="unverifiedRuns.jsp" class="list-group-item">Unverified runs: Unverfied performance runs.</a>
						<a href='CategorizedScores' target="_blank" class="list-group-item">Categorized Scores: This shows the top teams in each category after standardization.</a>
						<a href="CategoryScoresByJudge" target="_blank" class="list-group-item">Categorized Scores by Judge: This shows the top teams for each judge. This is useful for checking the winners of each category when there is only 1 judge for each team in a category.</a>
						<a href="PerformanceScoreDump" target="_blank" class="list-group-item">CSV file containing all performance scores, excluding byes: This is useful to manually determine awards for most consistent or most improved robot performance.</a>
					</div>
				</div>
			</div>
			
		</div>
	</div>
</body>
</html>
