<%@ page import="upload.ImageDAO" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %> <!-- 중복된 파일 이름이 있을경우 자동으로 바꿔주고 오류 없애주는 클래스 -->
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>upload</title>
</head>
<body>
	<%
		String directory = application.getRealPath("/upload/");
		int limitSize = 1024 * 1024 * 10; //10MB
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest
		= new MultipartRequest(request, directory, limitSize, encoding, new DefaultFileRenamePolicy());
		
		String thumbImg = multipartRequest.getOriginalFileName("file");
		String imgName = multipartRequest.getFilesystemName("file");
		
		new ImageDAO().imgupload(thumbImg, imgName);
		out.write("등록한 이미지명: " + thumbImg + "<br>");
		out.write("실제 저장된 이미지: " +  imgName + "<br>");
	%>
</body>
</html>