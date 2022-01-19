<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	String userPassword = null;
	if(request.getParameter("userID") != null) {
		userID = (String) request.getParameter("userID");
	}
	if(request.getParameter("userPassword") != null) {
		userPassword = (String) request.getParameter("userPassword");
	}

	if (userID == null || userPassword == null || userID.equals("") || userPassword.equals("")){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('모든 정보를 입력해 주세요.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	} else {
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(userID, userPassword);
		if (result == 1) { //정상 처리시
			session.setAttribute("userID", userID);
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'index.jsp'"); 
			script.println("</script>");
			script.close();
			return;
		} else if (result == 0){ //비밀번호 틀림 (UserDAO)
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('PW를 확인해 주세요');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		} else if (result == -1){ // 아이디가 존재하지 않음(UserDAO)
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('ID가 존재하지 않습니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}  else if (result == -2){ //  DB에러(UserDAO)
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('DB에러...');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		} 

	}

%>