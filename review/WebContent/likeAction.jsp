<%@page import="java.io.PrintWriter"%>
<%@page import="user.UserDAO"%>
<%@page import="evaluation.EvaluationDAO"%>
<%@page import="likey.LikeyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!
	public static String getClientIP(HttpServletRequest request){
		String ip = request.getHeader("X-FORWARDED-FOR");
		
		if(ip==null || ip.length() == 0){
			ip = request.getHeader("Proxy-Client-IP");
		}
		if(ip==null || ip.length() == 0){
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if(ip==null || ip.length() == 0){
			ip = request.getRemoteAddr();
		}
		return ip;
	}
%>

<%
	//ilqclwraaxlezsfy
	UserDAO userDAO = new UserDAO();
	String userID = null;
	if(session.getAttribute("userID") != null) { //로그인한 상태  == 섹션값이 유호한 상태일때
		userID = (String) session.getAttribute("userID"); //userID에 섹션값을 넣어준다.
	}
	if(userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요합니다.');");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
	request.setCharacterEncoding("UTF-8");
	String evaluationID = null;
	
	if(request.getParameter("evaluationID") != null){
		evaluationID = request.getParameter("evaluationID");
	}
	EvaluationDAO evaluationDAO = new EvaluationDAO();
	LikeyDAO likeyDAO = new LikeyDAO();
	int result = likeyDAO.like(userID, evaluationID, getClientIP(request));
	
	if (result == 1 && !userID.equals(evaluationDAO.getUserID(evaluationID))){
		result = evaluationDAO.like(evaluationID);
		if (result == 1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('추천하셨습니다!');");
			script.println("location.href = 'index.jsp'");
			script.println("</script>");
			script.close();
			return;
		}
		else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('DB ERR');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
	}
	//평가가 자신의 평가일 경우
	else if(userID.equals(evaluationDAO.getUserID(evaluationID))) { 
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('자신의 후기는 추천할 수 없습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	//이미 추천한 경우
	else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 추천하신 평가입니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;

	}

	
%>