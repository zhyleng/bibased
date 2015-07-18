<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.regex.*" %>
<%@ page import="com.hichujian.service.impl.ConfigManager" %>
<%@ page import="com.hichujian.model.Config" %>
<%@ page import="com.alibaba.fastjson.*" %>
<%@ page import="com.hichujian.web.controller.user.UserController" %>
<html>
	<head>
		<title>配置更新管理</title>
		<meta name="Content-Type" value="text/html:charset=utf-8"/>
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
		table {
			border-collapse:collapse;
			width: 100%;
			text-align: center;
		}
		table table {
			width: 95%;
			margin: 0 auto;
			text-align: center;
		}
		table th,table td {
		 border:1px solid #ccc;
		 padding:0 0px;
		 height: 30px;
		 line-height: 30px;
		}
		table table th, table table td {
		 border:1px solid #ccc;
		 padding:0 0px;
		 height: 30px;
		 line-height: 30px;
		}
		table input {
			margin: 0;
			border: 0;
			width: 100%;
			height: 100%;
			text-align: center;
		}
		caption {
			font-family: 楷体;
			font-size: 20px;
			font-weight: bold;
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
	<script src="/script/json.js" type="text/javascript"></script>
	<script type="text/javascript">
		var b_pic = new Object();
		var b_link = new Object();
		var b_title = new Object();
		var b_target = new Object();
		function submit_f() {
			document.business.business_pictures.value =  b_pic.toJSONString();
			document.business.business_link.value =  b_link.toJSONString();
			document.business.business_title.value =  b_title.toJSONString();
			document.business.business_target.value =  b_target.toJSONString();
			document.business.submit();
		}
	</script>
	</head>
	<%
		if(session == null || !"管理员".equals(session.getAttribute("username"))) {
			response.sendRedirect(request.getContextPath() + "/admin/index.jsp");
		}
	
	%>
	<body>
		<div class="wraper">
			<div class="header">
				<p style="font-size: 28px;"> hi,初见 配置更新管理</p>
			</div>		
			<div  class="nav" >
				<button onmouseover="this.style.cursor='pointer';" onclick="window.location.href='refresh'" style="float:right">刷新配置信息</button>
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
				<form name="config" action="update" method="post" >
					<%
						Config conf = ConfigManager.getConfigByCity("hangzhou");
					%>
					<table>
						<tr>
							<th>配置项</th>			  	   <th>当前值</th>     				<th>修改值</th>
						</tr>
						<tr>
							<td>iOS版本不显示三方的版本</td><td><%= conf.getNo_thirdpart_version()%></td>
							<td>
								<input type="text" name="no_thirdpart_version"/>
							</td>
						</tr>
					</table>
					<input type="hidden" name="city" value="hangzhou"/>	
					<button onclick="document.config.submit()" style="float: right;">确认更新</button>
				</form>
				<br/>
				<hr/><hr/>
				<br/><br/>

					<table >
						<caption>运营位</caption>
						<colgroup span="5">
							<col width="8%"/>
							<col width="30%"/>
							<col width="30%"/>
							<col width="8%"/>
							<col width="8%"/>
						</colgroup>
						<%
							JSONObject businessPictures = null;
							JSONObject businessLinks = null;
							JSONObject businessTitles = null;
							JSONObject businessTargets = null;
							businessLinks = JSON.parseObject(conf.getBusiness_link());
							businessPictures = JSON.parseObject(conf.getBusiness_pictures());
							businessTargets = JSON.parseObject(conf.getBusiness_target());
							businessTitles = JSON.parseObject(conf.getBusiness_title());
						%>
						<tr><th>板块</th><th>图片</th><th>链接</th><th>标题</th><th>目标</th></tr>
						<tr>
							<td>运动</td>
							<td><input onchange="b_pic.运动=this.value" value="<%=businessPictures.getString("运动")%>" /></td>
							<td><input onchange="b_link.运动=this.value" value="<%=businessLinks.getString("运动")%>" /></td>
							<td><input onchange="b_title.运动=this.value" value="<%=businessTitles.getString("运动")%>" /></td>
							<td><input onchange="b_target.运动=this.value" value="<%=businessTargets.getString("运动")%>" /></td>
						</tr>
						<tr>
							<td>游戏</td>
							<td><input onchange="b_pic.游戏=this.value" value="<%=businessPictures.getString("游戏")%>" /></td>
							<td><input onchange="b_link.游戏=this.value" value="<%=businessLinks.getString("游戏")%>" /></td>
							<td><input onchange="b_title.游戏=this.value" value="<%=businessTitles.getString("游戏")%>" /></td>
							<td><input onchange="b_target.游戏=this.value" value="<%=businessTargets.getString("游戏")%>" /></td>
						</tr>
						<tr>
							<td>聚餐</td>
							<td><input onchange="b_pic.聚餐=this.value" value="<%=businessPictures.getString("聚餐")%>" /></td>
							<td><input onchange="b_link.聚餐=this.value" value="<%=businessLinks.getString("聚餐")%>" /></td>
							<td><input onchange="b_title.聚餐=this.value" value="<%=businessTitles.getString("聚餐")%>" /></td>
							<td><input onchange="b_target.聚餐=this.value" value="<%=businessTargets.getString("聚餐")%>" /></td>
						</tr>
						<tr>
							<td>聚会</td>
							<td><input onchange="b_pic.聚会=this.value" value="<%=businessPictures.getString("聚会")%>" /></td>
							<td><input onchange="b_link.聚会=this.value" value="<%=businessLinks.getString("聚会")%>" /></td>
							<td><input onchange="b_title.聚会=this.value" value="<%=businessTitles.getString("聚会")%>" /></td>
							<td><input onchange="b_target.聚会=this.value" value="<%=businessTargets.getString("聚会")%>" /></td>
						</tr>
						<tr>
							<td>全部</td>
							<td><input onchange="b_pic.学习=this.value" value="<%=businessPictures.getString("学习")%>" /></td>
							<td><input onchange="b_link.学习=this.value" value="<%=businessLinks.getString("学习")%>" /></td>
							<td><input onchange="b_title.学习=this.value" value="<%=businessTitles.getString("学习")%>" /></td>
							<td><input onchange="b_target.学习=this.value" value="<%=businessTargets.getString("学习")%>" /></td>
						</tr>
						<tr>
							<td>艺术</td>
							<td><input onchange="b_pic.艺术=this.value" value="<%=businessPictures.getString("艺术")%>" /></td>
							<td><input onchange="b_link.艺术=this.value" value="<%=businessLinks.getString("艺术")%>" /></td>
							<td><input onchange="b_title.艺术=this.value" value="<%=businessTitles.getString("艺术")%>" /></td>
							<td><input onchange="b_target.艺术=this.value" value="<%=businessTargets.getString("艺术")%>" /></td>
						</tr>
						<tr>
							<td>其他</td>
							<td><input onchange="b_pic.其他=this.value" value="<%=businessPictures.getString("其他")%>" /></td>
							<td><input onchange="b_link.其他=this.value" value="<%=businessLinks.getString("其他")%>" /></td>
							<td><input onchange="b_title.其他=this.value" value="<%=businessTitles.getString("其他")%>" /></td>
							<td><input onchange="b_target.其他=this.value" value="<%=businessTargets.getString("其他")%>" /></td>
						</tr>
						<tr>
							<td>旅行</td>
							<td><input onchange="b_pic.旅行=this.value" value="<%=businessPictures.getString("旅行")%>" /></td>
							<td><input onchange="b_link.旅行=this.value" value="<%=businessLinks.getString("旅行")%>" /></td>
							<td><input onchange="b_title.旅行=this.value" value="<%=businessTitles.getString("旅行")%>" /></td>
							<td><input onchange="b_target.旅行=this.value" value="<%=businessTargets.getString("旅行")%>" /></td>
						</tr>
						<tr>
							<td>全部</td>
							<td><input onchange="b_pic.全部=this.value" value="<%=businessPictures.getString("全部")%>" /></td>
							<td><input onchange="b_link.全部=this.value" value="<%=businessLinks.getString("全部")%>" /></td>
							<td><input onchange="b_title.全部=this.value" value="<%=businessTitles.getString("全部")%>" /></td>
							<td><input onchange="b_target.全部=this.value" value="<%=businessTargets.getString("全部")%>" /></td>
						</tr>
					</table>
				
				<form name="business" action="update" method="post" >
					<input type="hidden" name="business_pictures"/>	
					<input type="hidden" name="business_link"/>	
					<input type="hidden" name="business_target"/>	
					<input type="hidden" name="business_title"/>	
					<input type="hidden" name="city" value="hangzhou"/>	
					<button onclick="submit_f()"  style="float: right;" >确认更新</button>

				</form>
				<br/>
				<hr/><hr/>
				<br/><br/>
			</div>		
			<div class="footer">
			</div>		
		</div>
	</body>
