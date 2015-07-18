<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>推送白名单管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
	  * {font-size: 13px; color: #333333;}
	  #wrap {
	  	width: 100%;
	  	heigth: 100%;
	  	margin: 30 auto;
	  }
	  #header {
	  	width: 100px;
	  	heigth: 100px;
	  	background: #eeeeee;
	  }
	
	
	</style>
  </head>
  
  <body>
  	<div id="#wrap">
  	  <div id="#header">
  	    <p>推送白名单管理</p>
  	  
  	  </div>
  	
  	</div>
  </body>
</html>
