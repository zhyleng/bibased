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
			font-size: 16px;
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
			font-size: 20px;
			font-weight: bold;
		}
		form div {
			text-indent: 2em;
		}
		ul {
			padding: 0;
			margin: 0;
			list-style-type: none;
			width: 80px;
			display: none;
		}

		li a, .nav div, button{
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
			response.sendRedirect(request.getContextPath() + "/admin/index.jsp");
		}
	
	%>
	<body>
		<div class="wraper">
			<div class="header">
				<p style="font-size: 28px;"> hi,初见 版本更新管理</p>
			</div>	
			<div  class="nav" >
				<button onmouseover="this.style.cursor='pointer';" onclick="window.location.href='refresh'" style="float:right">刷新版本信息</button>
				<div onmouseover="document.getElementById('ul1').style.display='block'"
					 onmouseout="document.getElementById('ul1').style.display='none'">
					<div onmouseover="this.style.cursor='pointer';" onclick="window.location.href='../manager.jsp'">管理</div>
					<ul id="ul1" >				
						<li><a href="../config">配置管理</a></li>
						<li><a href="../version">版本管理</a></li>
					</ul>
				</div>
			</div>	
			<br/><br/>
			<hr/><hr/>
			
			<div class="content">
				<form action="update" method="post" enctype="multipart/form-data">
					<p>1、Android客户端版本更新:</p>
					<input type="hidden" name="platform" value="Android"/>
					<div>当前版本：<%=VersionManager.getVersionInfo().getAndroid_current_version() %></div>
					<div>新版本APK文件：
						<input type="file" name="hichujian_apk"/>
					</div>
					<div>更新后的版本号:
						<input type="text" name="version" value="请输入更新后的版本"  style="color:#999999" 
							onfocus="if(this.value=='请输入更新后的版本'){this.value='';this.style.color='#333333';}" 
							onblur="if(this.value==''){this.value='请输入更新后的版本';this.style.color='#999999';}" />
					</div>
					<div>更新下载地址:
						<input type="text" name="download_url" size="80"/>
					</div>
					<div>版本说明:
						<textarea rows="5" cols="100" name="explain" style="margin-left: 2em"></textarea>
					</div>	
					<input type="submit" value="确认更新" class="right"/>
				</form>
				<br/>
				<hr/><hr/>
				
				<form action="update" method="post">
					<p>2、iOS客户端版本更新:</p>
					<input type="hidden" name="platform" value="iOS"/>
					<div>当前版本：<%=VersionManager.getVersionInfo().getIos_current_version() %><br/></div>
					<div>更新版本:
						<input type="text" name="version" value="请输入更新后的版本"  style="color:#999999" 
							onfocus="if(this.value=='请输入更新后的版本'){this.value='';this.style.color='#333333';}" 
							onblur="if(this.value==''){this.value='请输入更新后的版本';this.style.color='#999999';}" 
						/>
					</div>
					<div>更新后的版本号:
						<input type="text" name="version" />
					</div>
					<div>更新下载地址:
						<input type="text" name="download_url" size="80"/>
					</div>
					<div>版本说明:
						<textarea rows="5" cols="100" name="explain" style="margin-left: 2em"></textarea>
					</div>	
							
					<div> 
						<input type="submit" value="确认更新" class="right"/>
					</div>
				</form>
				<br/>
				<hr/><hr/>
			</div>		
			<div class="footer">
			</div>		
		</div>
	</body>
</html>