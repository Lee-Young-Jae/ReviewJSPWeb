<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="user.UserDAO"%>
<%@page import="evaluation.EvaluationDAO" %>
<%@page import="util.SHA256"%>
<%@page import="util.Gmail"%>
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
	String reportTitle = null;
	String reportContent = null;
	
	if(request.getParameter("reportTitle") != null){
		reportTitle = request.getParameter("reportTitle");
	}
	if(request.getParameter("reportContent") != null){
		reportContent = request.getParameter("reportContent");
	}
	if(reportTitle == null || reportContent == null || reportTitle.equals("") || reportContent.equals("") ){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('제목과 내용 기입은 필수 입니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	// 이용자에게 메세지 전송
	String host = "http://222.101.105.168:8081/review/";
	String from = "haneul.ori.com@gmail.com";
	String to = "kimhonor@naver.com";
	String subject = userID + "님이 보낸 신고 메일입니다.";
	String content = 
					"# 제목<br>" +
					reportTitle + "<br><br>" +
					"# 내용<br>" +
					reportContent + "<br><br>" +
					"# 링크<br>" +  "<a href='" + host + "index.jsp?code="  + "'>바로가기</a>" ;
		

	// Google SMTP에 접근하기 위한 정보들
	Properties p = new Properties();
	p.put("mail.smtp.user", from);
	p.put("mail.smtp.host", "smtp.googlemail.com");
	p.put("mail.smtp.port", "465");
	p.put("mail.smtp.starttls.enable", "true");
	p.put("mail.smtp.auth", "true");
	
	p.put("mail.smtp.debug", "true");
	p.put("mail.smtp.socketFactory.port", "465");
	p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	p.put("mail.smtp.socketFactory.fallback", "false");

	try{
	    Authenticator auth = new Gmail(); //new SMTPAuthenticator(id,pwd);
	    Session ses = Session.getInstance(p, auth);
	    ses.setDebug(true); //메일 전송시 콘솔출력
	    
	    MimeMessage msg = new MimeMessage(ses); 
	    msg.setSubject(subject);
	    Address fromAddr = new InternetAddress(from);
	    msg.setFrom(fromAddr);
	    
	    Address toAddr = new InternetAddress(to);
	    msg.addRecipient(Message.RecipientType.TO, toAddr);
	    
	    msg.setContent(content, "text/html;charset=UTF-8");
	    Transport.send(msg);
	    
	    
	} catch(Exception e){
	    e.printStackTrace();
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Error...');");
		script.println("history.back();");
		script.println("</script>");
		script.close();		
	    return;
	}
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('신고 처리가 완료되었습니다.');");
	script.println("history.back();");
	script.println("</script>");
	script.close();		
%>