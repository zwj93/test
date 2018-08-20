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
	String username = (String)session.getAttribute("username");
	
	if ("".equals(username) || username == null) {
		response.sendRedirect(basePath + "jbpm/login");
	}

	ProcessEngine processEngine = Configuration.getProcessEngine();
	RepositoryService repositoryService = processEngine.getRepositoryService();
	ExecutionService executionService = processEngine.getExecutionService();
	TaskService taskService = processEngine.getTaskService();
	
	
	List<ProcessDefinition> pdlist = repositoryService.createProcessDefinitionQuery().list();
	List<ProcessInstance> piList = executionService.createProcessInstanceQuery().list();
	List<Task> taskList = taskService.findPersonalTasks(username);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<a href="<%=basePath %>jbpm/deploy">发布新流程</a>&nbsp;[username:<%=username %>]<a href="<%=basePath %>jbpm/login">登录</a><br/>
	<br/>
	<table border="1" width="100%">
		<caption>流程定义</caption>
		<thead>
			<tr>
				<td>id</td>
				<td>name</td>
				<td>version</td>
				<td>&nbsp;</td>
			</tr>
		</thead>
		<tbody>
		<%
			for (ProcessDefinition pd : pdlist) {
		%>
			<tr>
				<td><%=pd.getId() %></td>		
				<td><%=pd.getName() %></td>		
				<td><%=pd.getVersion() %></td>		
				<td>
					<a href="<%=basePath %>jbpm/remove?id=<%=pd.getDeploymentId()%>">remove</a>
					&nbsp;|&nbsp;
					<a href="<%=basePath %>jbpm/start?id=<%=pd.getId()%>">start</a>
				</td>		
			</tr>
		<%
			}
		%>
		</tbody>
	</table>
	<br/>
	<table border="1" width="100%">
		<caption>流程实例</caption>
		<thead>
			<tr>
				<td>id</td></td>
				<td>name</td>
				<td>state</td>
				<td>&nbsp;</td>
			</tr>
		</thead>
		<tbody>
		<%
			for (ProcessInstance pi : piList) {
		%>
			<tr>
				<td><%=pi.getId() %></td>		
				<td><%=pi.findActiveActivityNames() %></td>		
				<td><%=pi.getState() %></td>		
				<td>
					<a href="<%=basePath %>jbpm/view?id=<%=pi.getId()%>">view</a>
				</td>		
			</tr>
		<%
			}
		%>
		</tbody>
	</table>
	<br/>
	<table border="1" width="100%">
		<caption>待办任务</caption>
		<thead>
			<tr>
				<td>id</td>
				<td>name</td>
				<td>&nbsp;</td>
			</tr>
		</thead>
		<tbody>
		<%
			for (Task task : taskList) {
		%>
			<tr>
				<td><%=task.getId() %></td>		
				<td><%=task.getName() %></td>		
				<td>
					<a href="<%=basePath %>jbpm/<%=task.getFormResourceName() %>?id=<%=task.getId()%>">view</a>
				</td>		
			</tr>
		<%
			}
		%>
		</tbody>
	</table>
	
	
</body>
</html>