<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// 获取当前文件路径
	String filePath = request.getServletPath();

	// 获取当前项目路径
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<fieldset>
		<legend>登录</legend>
		<form action="<%=basePath %>jbpm/doLogin" method="post">
			用户名: <input type="text" name="username">
			<button type="submit">登录</button>
		</form>
	</fieldset>
</body>
</html>