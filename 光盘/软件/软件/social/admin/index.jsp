<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>初见</title>
<meta
	content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'
	name='viewport' />
<meta property="qc:admins" content="274310307260130521166375" />

<!--[if lt IE 9]>
    <script src='assets/javascripts/html5shiv.js' type='text/javascript'></script>
    <![endif]-->
<link href='assets/stylesheets/bootstrap/bootstrap.css' media='all'
	rel='stylesheet' type='text/css' />
<link href='assets/stylesheets/bootstrap/bootstrap-responsive.css'
	media='all' rel='stylesheet' type='text/css' />

<!-- / flatty theme -->
<link href='assets/stylesheets/light-theme.css'
	id='color-settings-body-color' media='all' rel='stylesheet'
	type='text/css' />

<script type="text/javascript">
	function getcsrfToken() {
		$.ajax({
			type:"GET",
			url:"getcsrfToken",
			dataType : "text",
			success : function(result) {
				$('#csrfToken').attr("value", result);
			}
		});
	}

	function signin() {
		$.ajax({
			type : "post",
			url : "sign",
			data : {
				username : $("#username").val(),
				password : hex_md5($("#password").val()),
				CSRFToken : $("#csrfToken").val(),
				Login :$("#Login").val()
			},
			dataType : "text",
			success : function(data) {
				if (data == "ok") {
					window.location.href = 'index';
				} else {
					$('#signmsg').html(data);
				}
			}
		});
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<%
if(session != null && "管理员".equals(session.getAttribute("username"))) {
	response.sendRedirect("manager.jsp");
}
%>

<body class='contrast-red sign-in contrast-background'>
	<div id='wrapper'>
		<div class='application'>
			<div class='application-content'>
				<a href="#">
					<div class='icon-heart'></div> <span>初见</span>
				</a>
			</div>
		</div>
		<div class='controls'>
			<div class='caret'></div>
			<div class='form-wrapper'>
				<h1 class='text-center'>登录</h1>
				<form accept-charset="UTF-8" name="login" action="login" method="post">
					<div style="margin: 0; padding: 0; display: inline">
						<input name="utf8" type="hidden" value="&#x2713;" />
					</div>
					<div class='row-fluid'>
						<div class='span12 icon-over-input'>
							<label id="signmsg"></label>
						</div>
					</div>
					<div class='row-fluid'>
						<div class='span12 icon-over-input'>
							<input class="span12" id="username" name="username"
								placeholder="username" type="text" value="" /> <i
								class='icon-user muted'></i>
						</div>
					</div>
					<div class='row-fluid'>
						<div class='span12 icon-over-input'>
							<input class="span12" id="password" name="password"
								placeholder="Password" type="password" value="" /> <i
								class='icon-lock muted'></i>
						</div>
					</div>
					<label class="checkbox" for="remember_me"> <input
						id="remember_me" name="remember_me" type="checkbox" value="1" />
						记住密码
					</label>
					<button class="btn btn-block" id="btnsign" name="button"
						onclick="document.login.submit()" type="button">登录</button>
				</form>

			</div>
		</div>
	</div>
	<!-- / jquery -->
	<script src='assets/javascripts/jquery/jquery.min.js'
		type='text/javascript'></script>
	<script type="text/javascript" src="assets/javascripts/md5-min.js"></script>
</body>
</html>
