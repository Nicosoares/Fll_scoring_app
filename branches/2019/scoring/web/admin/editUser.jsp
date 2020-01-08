<%@ include file="/WEB-INF/jspf/init.jspf"%>

<%
  fll.web.admin.EditUser.populateContext(request, application, pageContext);
%>

<html>

<head>
<title>Edit User</title>
<link rel="stylesheet" type="text/css" href="<c:url value='/style/fll-sw.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/style/bootstrap/bootstrap.min.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/style/bootstrap/bootstrap-theme.min.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/style/bootstrap/bootstrap-slider.min.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/style/file-upload.css'/>" />

<meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
<meta content="IE=edge" http-equiv="X-UA-Compatible">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" >

<script src="<c:url value='/extlib/jquery-3.2.0.min.js'/>"></script>

<script src="<c:url value='/extlib/file-upload.js'/>"></script>

<script type='text/javascript'>
function refreshImage(){
	var teamNumber = $('#select-teamnumber').val();
	var teamName = $('#select-teamnumber :selected').text();
	if(teamNumber != null){
		$('#User-label').text(teamName);
		$('#user-avatar-image').attr('src', "../images/minifigs/" + teamNumber + ".png");
	}
	else{
		$('#user-avatar-image').attr('src', "../images/minifigs/default.png");	
	}
	};
	
function ImgError(source){
	source.src = "../images/minifigs/default.png";
	return true;
}
	
$(document).ready(function() {
  refreshImage();
  $('.file-upload').file_upload();
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
								<div class="panel-heading">User Selection</div>
								<div class="panel-body">
									<label for="select-teamnumber">Select a user to see or edit his profile:</label>
										<select class="form-control" size='20' id='select-teamnumber' name='TeamNumber' onclick='refreshImage()'>
										  <c:forEach items="${all_users }" var="loop_user">
											  <option value="${loop_user.user }">${loop_user.user }&nbsp;-&nbsp;${loop_user.userName }&nbsp;&nbsp;&nbsp;[${loop_user.userRole }]</option>
										  </c:forEach>
										</select>
								</div>
							</div>	
					</div>
					<div class="col-lg-6 col-md-6 col-sm-6">
							<div class="panel panel-default">
								<div class="panel-heading">User Profile</div>
								<div class="panel-body">
<form class="form-horizontal">
									<label id="User-label" for="user-image"></label>
									<div class="container">
										<img id="user-avatar-image" class="img-responsive" src="../images/minifigs/default.png" alt=$('#select-teamnumber :selected').text(); onerror="ImgError(this)">
									</div>
    <div class="form-group">
        <div class="col-sm-offset-2 col-sm-10">
            <label class="file-upload btn btn-primary">
                Upload user avatar <input type="file" />
            </label>
        </div>
    </div>
									<div class="col-lg-4 col-md-4 col-sm-4">
										<select class="form-control" size='1' id='select-role' name='Role' >
										  <c:forEach items="${all_roles }" var="loop_role">
											  <option value="${loop_role.role }">${loop_role.role }&nbsp;&nbsp;&nbsp;[${loop_role.roleName }]</option>
										  </c:forEach>
										</select>
									</div>
								    <div class="col-lg-4 col-md-4 col-sm-4">
										<input name="submit_update_user_role" value="Update user role" type="submit"  class="btn btn-primary"></input>
									</div>
</form>
									
								</div>

							</div>
					</div>
				</div>
			</div>
		</div>
	</div>

  </body>

</html>
