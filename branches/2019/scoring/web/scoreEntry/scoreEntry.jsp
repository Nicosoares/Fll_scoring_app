<%@ include file="/WEB-INF/jspf/init.jspf" %>

<%@ page import="fll.web.scoreEntry.ScoreEntry" %>

<html>
  <head>
  <c:choose>
    <c:when test="${1 == EditFlag}">
      <title id='pageTitle'>Performance for Team ${team.teamNumber} - Run Number ${lRunNumber}</title>
    </c:when>
    <c:otherwise>
      <title>Score Entry</title>
    </c:otherwise>
    </c:choose>

        <link rel="stylesheet" type="text/css" href="<c:url value='/style/fll-sw.css'/>" />
		<link rel="stylesheet" type="text/css" href="<c:url value='/style/bootstrap/bootstrap.min.css'/>" />
		<link rel="stylesheet" type="text/css" href="<c:url value='/style/bootstrap/bootstrap-theme.min.css'/>" />
		<link rel="stylesheet" type="text/css" href="<c:url value='/style/bootstrap/bootstrap-slider.min.css'/>" />

<link
  rel="stylesheet"
  type="text/css"
  href="scoreEntry.css" />

<style>        
 @media print {
    .printcolumn-left {width: 50%; float: left;}
    .printcolumn-right {width: 50%; float: right;}
 }
</style>
 <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
 <meta content="IE=edge" http-equiv="X-UA-Compatible">
 <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" >
 
 <script src="<c:url value='/extlib/jquery-3.2.0.min.js'/>"></script>
 <script src="<c:url value='/extlib/bootstrap/bootstrap.min.js'/>"></script>
 <script src="<c:url value='/extlib/bootstrap/bootstrap-slider.min.js'/>"></script>
 <script src="<c:url value='/extlib/bootstrap/bootstrap-confirmation.min.js'/>"></script>
 
<script type="text/javascript">
$(function(){
	$("[data-slider-id]").slider();
});
$(function(){
    $('[data-toggle="confirmation"]').confirmation();
});

    <c:if test="${not isBye}">


<!-- No Show -->
function submit_NoShow() {
 retval = confirm("Are you sure this is a 'No Show'?") 
 if(retval) {
  document.scoreEntry.NoShow.value = true;
  Verified = 1;
  refresh();
 }
 return retval;
}

function init() {
  $("#verification-warning").hide();

  // disable text selection
  document.onselectstart=new Function ("return false")

  <c:choose>
  <c:when test="${1 == EditFlag}">
  $('#score_verification').show();
  <%ScoreEntry.generateInitForScoreEdit(out, application, session);%>
  </c:when>
  <c:otherwise>
  $('#score_verification').hide();
  <%ScoreEntry.generateInitForNewScore(out, application);%>

  </c:otherwise>
  </c:choose>

  // fix for slider ticks labels not displaying correctly:
    $("[collapse-id]").on('shown.bs.collapse', function(){
        $('[data-slider-id]').slider('refresh');
    });

  refresh();
  
  /* Saves total score for smarter notification popups */
  savedTotalScore = parseInt($('#totalScore').text());
}

function refresh() { 
  var score = 0;

  <%ScoreEntry.generateRefreshBody(out, application);%>

  //check for minimum total score
  if(score < ${minimumAllowedScore}) {
    score = ${minimumAllowedScore};
  }

  $('#totalScore').text(score);

  check_restrictions();
}

function check_restrictions() {
  var error_found = false;
  $("#score-errors").empty();

<%ScoreEntry.generateCheckRestrictionsBody(out, application);%>

  if(error_found) {
    $("#submit").attr('disabled', true);
    $("#score-errors").show();
  } else {
    $("#submit").attr('disabled', false);
    $("#score-errors").hide();
  }
}

<%ScoreEntry.generateIsConsistent(out, application);%>


<%ScoreEntry.generateIncrementMethods(out, application);%>
</c:if> <!-- end check for bye -->

/**
 * Used to change style in a panel element by ID.
 */
function changePanelStyle(panelId, goalValue, hasError) {
   if(hasError) {
      $( panelId ).removeClass( 'panel panel-success' ).removeClass( 'panel panel-default' ).addClass( 'panel panel-danger' );
   }
   else {
      if(goalValue == 0 || goalValue == "none") {
         $( panelId ).removeClass( 'panel panel-success' ).removeClass( 'panel panel-danger' ).addClass( 'panel panel-default' );
      }
      else {
         $( panelId ).removeClass( 'panel panel-default' ).removeClass( 'panel panel-danger' ).addClass( 'panel panel-success' ); 
      }
   }
}   
       
/**
 * Called when the cancel button is clicked.
 */
function CancelClicked() {
  <c:choose>	
  <c:when test="${1 == EditFlag}">
  if (confirm("Cancel and lose changes?") == true) {
  </c:when>
  <c:otherwise>
  if (confirm("Cancel and lose data?") == true) {
  </c:otherwise>
  </c:choose>
    window.location.href= "select_team.jsp";
  }
}

/**
 * Called after window.print() to collapse all panels.
 */
function collapseAllPanels() {
  $("[class='panel-collapse collapse in']").removeClass( 'panel-collapse collapse in' ).addClass( 'panel-collapse collapse' );
}


/**
 * Called when the print button is clicked.
 */
function PrintClicked() {
  $("[class='panel-collapse collapse']").removeClass( 'panel-collapse collapse' ).addClass( 'panel-collapse collapse in' );
  window.print();
  setTimeout(collapseAllPanels, 1000);
}

/**
 * Called to check verified flag
 */
function verification() {
if (Verified == 1)
{
	// Smarter Score Popups
	if (savedTotalScore!=parseInt($('#totalScore').text()))
	 {
		 m = "You are changing and verifying a score -- are you sure?";
	 }
	 else
	 {
		 m = "You are verifying a score -- are you sure?";
	 }
return m;
}
else 
{
m = "You are submitting a score without verification -- are you sure?";
return m;
}
}

$(document).ready(function() {
init();
});

</script>

  </head>

<body>

  <div id="floating-messages">
    <div id="score-errors"  class="alert alert-danger"></div>
    <div id="verification-warning">Are you sure this score has
      been Verified? Normally scores are not verified on the initial
      entry.</div>
  </div>

  <form
    action="submit.jsp"
    method="POST"
    name="scoreEntry">
    <input
      type='hidden'
      name='NoShow'
      value="false" />

      <c:if test="${1 == EditFlag}">
      <input
        type='hidden'
        name='EditFlag'
        value='1'
        readonly>
      </c:if>
    <input
      type='hidden'
      name='RunNumber'
      value='${lRunNumber}'
      readonly> <input
      type='hidden'
      name='TeamNumber'
      value='${team.teamNumber}'
      readonly>
    <input
      type='hidden'
      name='Referee'
      value='${Referee}'
      readonly>

<c:choose>
                        <c:when test="${1 == EditFlag}">
		  <div class="panel panel-info">
                        </c:when>
                        <c:otherwise>
		  <div class="panel panel-primary">
                        </c:otherwise>
	</c:choose>
		<div class="panel-heading">
			<div>
            <c:choose>
					<c:when test="${1 == EditFlag}">
					  <h4 class="panel-title hidden-print">Score Edit</h4>
					  <h4 class="panel-title visible-print-inline">Performance for Team</h4>
					</c:when>
					<c:otherwise>
					  <h4 class="panel-title">Score Entry - Referee ${Referee}</h4>
					</c:otherwise>
				</c:choose>
			</div>
			<h5>
				#${team.teamNumber}&nbsp;${team.teamName}&nbsp;(${team.organization})&nbsp;--&nbsp;${roundText}
			</h5>
		</div>
		<div class="panel-body">
			<c:if test="${not previousVerified }">
                 <!--  warning -->
                 <div class="alert alert-warning">Warning: Previous run for this team has not been verified!</div>                  
            </c:if>
			<c:choose>
            <c:when test="${isBye}">
				  <div class="alert alert-info">
					<strong>Bye Run</strong>
				  </div>
            </c:when>
            <c:otherwise>
            <c:if test="${isNoShow}">
					<div class="alert alert-warning">
					<strong>Editing a No Show</strong> - submitting score will change to a real run
					</div>
            </c:if>
                <%
                  ScoreEntry.generateScoreEntry(out, application);
                %>

            <c:if test="${1 == EditFlag}">
              <!-- Total Score -->
                        <div class="well hidden-print">
                  <h1>
                      <span class="label label-default">Total Score:
                          <span id="totalScore" name="totalScore" >0</span>
                          </span>
                  </h1>
					</div>
            </c:if>
                <%
                  ScoreEntry.generateVerificationInput(out);
                %>
            </c:otherwise>
            </c:choose>
            <!-- end check for bye -->
			<div class="well hidden-print">
                <c:if test="${not isBye}">
                  <c:choose>
                  <c:when test="${1 == EditFlag}">
                      <input
                        type='submit'
                        class='btn btn-success'
                        id='submit'
                        name='submit'
                        value='Submit Score'
                        onclick='return confirm(verification())'>
                      <input
                        type='button'
                        class='btn btn-primary'
                        id='print'
                        value='Print'
                        onclick='PrintClicked()'>
                  </c:when>
                  <c:otherwise>
                      <input
                        type='submit'
                        class='btn btn-success'
                        id='submit'
                        name='submit'
                        value='Submit Score'
                        data-toggle='confirmation' data-title='Submit Data -- Are you sure?'>
                  </c:otherwise>
                  </c:choose>
                </c:if> <input
                type='button'
                class='btn btn-warning'
                id='cancel'
                value='Cancel'
                onclick='CancelClicked()'> <c:if
                  test="${1 == EditFlag and isLastRun}">
                  <input
                    type='submit'
                    class='btn btn-danger'
                    id='delete'
                    name='delete'
                    value='Delete Score'
                    data-toggle='confirmation' data-title='Are you sure you want to delete this score?'>
                </c:if>
				<c:if test="${not isBye}">
                <input
                  type='submit'
                  class='btn btn-info'
                  id='no_show'
                  name='submit'
                  value='No Show'
                  onclick='return submit_NoShow()'>
              </c:if>
	     </div>
		</div>
	</div>
  </form>
  <!-- end score entry form -->
  </body>
</html>
