<%@page import="java.io.PrintWriter"%>
<%@page import="user.UserDAO"%>
<%@page import="evaluation.EvaluationDAO"%>
<%@page import="likey.LikeyDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	
	if(userID.equals(evaluationDAO.getUserID(evaluationID))){
		int result = new EvaluationDAO().delete(evaluationID);
		if (result == 1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('정말 삭제하시겠습니까?');");
			script.println("location.href = 'index.jsp'");
			script.println("</script>");
			script.close();
			return;
		}
		else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('삭제가 불가능합니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
	}
	else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('본인의 글만 삭제가 가능합니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;

	}

	
%>