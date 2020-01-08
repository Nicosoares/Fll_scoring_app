<%@ include file="/WEB-INF/jspf/init.jspf" %>

<% fll.web.scoreEntry.SelectTeam.populateContext(application, pageContext);%>

<html>
  <head>
    <link rel="stylesheet" type="text/css" href="<c:url value='/style/fll-sw.css'/>" />
  <title>Score Entry [Selected Team]</title>

 <link rel="stylesheet" type="text/css" href="<c:url value='/style/bootstrap/bootstrap.min.css'/>" />
 <link rel="stylesheet" type="text/css" href="<c:url value='/style/bootstrap/bootstrap-theme.min.css'/>" />

 <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
 <meta content="IE=edge" http-equiv="X-UA-Compatible">
 <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" >
 
 <script src="<c:url value='/extlib/jquery-3.2.0.min.js'/>"></script>
 <script src="<c:url value='/extlib/bootstrap/bootstrap.min.js'/>"></script>
  
<script type="text/javascript" src="<c:url value='/playoff/code.icepush'/>"></script>
<script type="text/javascript" src="<c:url value='/extlib/jquery-1.11.1.min.js'/>"></script>


  </head>
  <body>
  
      <!-- top info bar -->
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td align="center" valign="middle" bgcolor="#e0e0e0" colspan='3'>
            <table border="1" cellpadding="0" cellspacing="0" width="100%">
            <tr align="center" valign="middle"><td>

            <table border="0" cellpadding="5" cellspacing="0" width="90%">
              <tr>
                <td valign="middle" align="center">
                  <font face="Arial" size="4">${challengeDescription.title }</font><br>
									<font face="Arial" size="2">Score Card Entry Page</font>
                </td>
              </tr>
            </table>

              </td></tr>
              </table>
          </td>
        </tr>
      </table>
      
      <div class='status-message'>${message}</div>
      <%-- clear out the message, so that we don't see it again --%>
      <c:remove var="message" />
      

      <table> <!-- outer table -->        
        <tr>
        <td>
        <form action="GatherScoreEntryData" method="POST" name="selectTeam">
        <table> <!-- left table -->
        
        <tr align='center' valign='top'>
          <!-- pick team from a list -->
          <td>
          <div class="well well-lg">
            <br>
            <font face='arial' size='4'>Please confirm team data and press Ok:</font><br>
            <br>
              <c:set var="referee" value="${ param.referee }"/>
              <input type="hidden" id='Referee' name='Referee' value="${referee }" />
              <c:set var="tNumber" value="${ param.team }"/>
              <input type="hidden" id='TeamNumber' name='TeamNumber' value="${tNumber }" />
              <c:forEach items="${tournamentTeams }" var="team">
                <c:if test="${team.teamNumber == tNumber}">
                <div class="panel panel-primary">
                  <div class="panel-heading">${team.teamNumber } - ${team.trimmedTeamName } [${team.organization }]</div>
                  <div class="panel-body">            
                        <input type="submit" class='btn btn-success' value="Ok" id='enter_submit'/>
                        <!--button type="button" class='btn btn-danger' onclick="window.open('','_parent',''); window.close();">Close</button-->
                  </div>
                </div>
                </c:if>
              </c:forEach>
          </div>              
          </td>
        </tr>
        <tr style='display:none;'><td>
        <table border='1'>
        <tr>
           <!-- check to edit -->
          <td align='left' valign='bottom'>
            <input type="hidden"
                   name='EditFlag'
                   id='EditFlag'
                   value="0" />
          </td>
        </tr>
        <tr>
           <!-- pick run number -->
          <td align='left'>
            <select name='RunNumber' disabled='disabled'>
			  <option value='0'>Last Run</option>
	          <c:forEach var="index" begin="1" end="${maxRunNumber}">
			    <option value='${index }'>${index }</option>
			  </c:forEach>			
            </select>
            <b><span id='select_number_text'>Select Run Number for editing</span></b>
          </td>
        </tr>
        </table></td></tr>
        
      </table>
      </form>
      </td> <!-- left table -->
      
      </tr> 

</table> <!-- outer table -->
    
  </body>
</html>
