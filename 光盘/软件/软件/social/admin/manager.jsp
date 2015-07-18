<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.regex.*" %>
<%@ page import="com.hichujian.service.impl.VersionManager" %>
<%@ page import="com.hichujian.web.controller.user.UserController" %>
<html>
	<head>
		<title>客户端更新管理</title>
	</head>
	<style type="text/css">
		*{
			font-size: 15px;
			margin: 0;
			padding: 0;
			color: #333333;
		}	
		.wraper{
			width: 970px;
			margin: 30px auto;
		}
		.header{
			line-height: 100px;
			text-align: center;
		}
		.content{
			width: 100%;
			line-height: 30px;
		}
		.right{float: right;}
		form p {
			font-family: 楷体;
			font-size: 18px;
		}
		form div {
			text-indent: 2em;
		}
		button {
			width: 48%;
			height: 80px;
			line-height: 80px;
			text-align: center;
			background: #888888;
			color: #ffffff;
			font-size: 28px;
		}
		ul {
			padding: 0;
			margin: 0;
			list-style-type: none;
			width: 80px;
			display: none;
		}

		li a, .nav div{
			display: block;
			width: 80px;
			height: 30px;
			line-height: 30px;
			text-align: center;
			border-bottom: 1px #bbbbbb solid;
			background: #eeeeee;
			text-decoration: none;
		}

		li a:hover {
			background: #f6cc00;
			color: blue;
			cursor: pointer;
		}

		.nav {
			width: 100%;
			height: 30px;
			line-height: 30px;
			position: relative;
		}
	</style>
	<%
		if(session == null || !"管理员".equals(session.getAttribute("username"))) {
			response.sendRedirect("index.jsp");
		}
	
	%>
	<body>
		<div class="wraper">
			<div class="header">
				<p style="font-size: 24px;">hi,初见管理</p>
			</div>		
			<div  class="nav" >
				<div onmouseover="document.getElementById('ul1').style.display='block'"
					 onmouseout="document.getElementById('ul1').style.display='none'">
					<div onmouseover="this.style.cursor='pointer';" onclick="window.location.href='/admin/manager.jsp'">管理</div>
					<ul id="ul1" >				
						<li><a href="config">配置管理</a></li>
						<li><a href="version">版本管理</a></li>
					</ul>
				</div>
			</div>
			
			<div class="content">
				
			</div>		
			<div class="footer">
			</div>		
		</div>
	</body>
</html>