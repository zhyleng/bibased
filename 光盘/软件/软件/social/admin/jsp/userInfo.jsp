<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>第三方注册用户信息</title>
</head>
<body>
	<div>
		<div><label>用户昵称：</label>${user.nickName}</div>
		<div><label>用户id：</label>${user.userId}</div>
		<div><img alt="头像" src="${user.head_portrait}"></div>
	</div>
</body>
</html>