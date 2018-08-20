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
		<legend>申请</legend>
		<form action="<%=basePath %>jbpm/submit">
			<input type="hidden" name="taskId" value="${param.id}"> 申请人:<input
				type="text" name="owner" value="${sessionScope['username']}"><br />
			请假时间:<input type="text" name="day" value=""><br /> 请假原因:
			<textarea name="reason"></textarea>
			<br /> <input type="submit">
		</form>
	</fieldset>
</body>
</html>