package com.jbpm4.controller;

import java.util.zip.*;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jbpm.api.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/jbpm")
public class JBPMController {
	
	/**
	 * 流程定义对象
	 */
	ProcessEngine processEngine = Configuration.getProcessEngine();
	
	/**
	 * 流程实例对象
	 */
	RepositoryService repositoryService = processEngine.getRepositoryService();
	
	/**
	 * 流程执行对象
	 */
	ExecutionService executionService = processEngine.getExecutionService();
	
	/**
	 * 流程任务对象
	 */
	TaskService taskService = processEngine.getTaskService();

	@RequestMapping("/index")
	public String index(){
		return "index";
	}
	
	@RequestMapping("/login")
	public String login(){
		return "login";
	}
	
	@RequestMapping("/boss")
	public String boss(){
		return "boss";
	}
	
	@RequestMapping("/manager")
	public String manager(){
		return "manager";
	}

	@RequestMapping("/request")
	public String request(){
		return "request";
	}
	
	@RequestMapping("/view")
	public String view(){
		return "view";
	}
	
	@RequestMapping("/doLogin")
	public String doLogin(HttpServletRequest request){
		request.getSession().setAttribute("username", request.getParameter("username"));
		return "index";
	}
	
	@RequestMapping("/pic")
	public String pic(){
		return "pic";
	}
	
	@ModelAttribute
	@RequestMapping("/checkLogin")
	public String checkLogin(HttpServletRequest request) {
		String username = (String)request.getSession().getAttribute("username");
		if ("".equals(username)) {
			return "login";
		} else {
			return "index";
		}
	}
	
	@RequestMapping("/deploy")
	public String deploy(HttpServletRequest request){
		processEngine = Configuration.getProcessEngine();
		repositoryService = processEngine.getRepositoryService();
		
		//repositoryService.createDeployment().addResourceFromClasspath("leave.jpdl.xml").deploy();
		
		ZipInputStream zis = new ZipInputStream(this.getClass().getResourceAsStream("/leave.zip"));
		repositoryService.createDeployment().addResourcesFromZipInputStream(zis).deploy();
		return "index";
	}

	@RequestMapping("/remove")
	public String remove(HttpServletRequest request){
		processEngine = Configuration.getProcessEngine();
		repositoryService = processEngine.getRepositoryService();
		
		repositoryService.deleteDeploymentCascade(request.getParameter("id"));
		return "index";
	}

	@RequestMapping("/start")
	public String start(HttpServletRequest request){
		processEngine = Configuration.getProcessEngine();
		executionService = processEngine.getExecutionService();
		Map map = new HashMap();
		map.put("owner", request.getSession().getAttribute("username"));
		String id = request.getParameter("id");
		// 根据id查找对象并向下一个流程执行
		executionService.startProcessInstanceById(id,map);
		return "index";
	}

	@RequestMapping("/submit_boss")
	public String submit_boss(HttpServletRequest request){
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		processEngine = Configuration.getProcessEngine();
		taskService = processEngine.getTaskService();
		String taskId = request.getParameter("taskId");
		String result = request.getParameter("result");
		
		// 结束一个流程
		taskService.completeTask(taskId,result);
		return "index";
	}
	
	@RequestMapping("/submit_manager")
	public String submit_manager(HttpServletRequest request){
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		ProcessEngine processEngine = Configuration.getProcessEngine();
		TaskService taskService = processEngine.getTaskService();
		String taskId = request.getParameter("taskId");
		String result = request.getParameter("result");
		
		// 结束一个流程
		taskService.completeTask(taskId,result);
		return "index";
	}

	@RequestMapping("/submit")
	public String submit(HttpServletRequest request){
		processEngine = Configuration.getProcessEngine();
		taskService = processEngine.getTaskService();
		String taskId = request.getParameter("taskId");
		String owner = request.getParameter("owner");
		int day = Integer.parseInt(request.getParameter("day"));
		String reason = request.getParameter("reason");
		
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("day", day);
		map.put("reason", reason);
		
		// 下面2钟方法都差不多
		
		// taskService.completeTask(taskId,map);
		
		// 变量放进去
		taskService.setVariables(taskId, map);
		taskService.completeTask(taskId);
		return "index";
	}
	
	
	
	
	
	
	
	
	
	
	

}
