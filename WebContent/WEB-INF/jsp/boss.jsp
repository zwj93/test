<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*,org.jbpm.api.*,org.jbpm.api.task.*"%>
<%
	// 获取当前文件路径
	String filePath = request.getServletPath();

	// 获取当前项目路径
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	ProcessEngine processEngine = Configuration.getProcessEngine();
	TaskService taskService = processEngine.getTaskService();
	String taskId = request.getParameter("id");
	Task task = taskService.getTask(taskId);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<fieldset>
		<legend>老板审核</legend>
		<form action="<%=basePath %>jbpm/submit_manager" method="post">
			<input type="hidden" name="taskId" value="${param.id}">		
			申请人:<%=taskService.getVariable(taskId, "owner") %><br/>
			请假时间:<%=taskService.getVariable(taskId, "day") %><br/>
			请假原因:<%=taskService.getVariable(taskId, "reason") %></textarea><br/>
			<input type="submit" name="result" value="批准"><input type="submit" name = "result"  value="驳回">
		</form>
	</fieldset>

</body>
</html>