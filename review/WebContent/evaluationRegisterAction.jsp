<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="evaluation.EvaluationDTO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
		
	}
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요합니다.');");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
	String shopName = null;
	String foodType = null;
	String shopLocation = null;
	String Title = null;
	String Content = null;
	String totalScore = null;
	String thumbImg = null;
	String imgName = null;
	
	if(request.getParameter("shopName") != null) {
		shopName = (String) request.getParameter("shopName");
	}
	if(request.getParameter("foodType") != null) {
		foodType = (String) request.getParameter("foodType");
	}
	if(request.getParameter("shopLocation") != null) {
		shopLocation = (String) request.getParameter("shopLocation");
	}
	if(request.getParameter("Title") != null) {
		Title = (String) request.getParameter("Title");
	}
	if(request.getParameter("Content") != null) {
		Content = (String) request.getParameter("Content");
	}
	if(request.getParameter("totalScore") != null) {
		totalScore = (String) request.getParameter("totalScore");
	}
	if(request.getParameter("thumbImg") != null) {
		thumbImg = (String) request.getParameter("thumbImg");
	}
	if(request.getParameter("imgName") != null) {
		imgName = (String) request.getParameter("imgName");
	}
	if ( shopName == null || foodType == null || shopLocation == null ||

		Title == null || Content == null || totalScore == null ||

		Title.equals("") || Content.equals("") ) {
		
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('모든 정보를 입력해 주세요.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
		
	} else {
		EvaluationDAO evaluationDAO = new EvaluationDAO();
		
		int result = evaluationDAO.write(new EvaluationDTO(0, userID, shopName, foodType, shopLocation,
				 Title, Content, totalScore, 0, thumbImg, imgName));
		
		if (result == -1) { //문제 발생시
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('등록이 불가능합니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
		} else {
			session.setAttribute("userID", userID);
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'index.jsp';");
			script.println("</script>");
			script.close();
		}
	}
		

%>