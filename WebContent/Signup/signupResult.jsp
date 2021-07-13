
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
</head>
<body>
	<c:choose>
		<c:when test="${user_id!=null}">

			<!-- 로그인이 완료되었을때. -->
			<div>
			
				<div>회원 가입시에 등록한 아이디는:${user_id}</div>
				
			</div>
			
		</c:when>

		<c:otherwise>

			<div>등록되지않은 아이디입니다.</div>

			<a href="${pageContext.request.contextPath }/Signup/Idfin.jsp">아이디찾기로 다시 이동</a>
			<a href="${pageContext.request.contextPath }/Signup/signupView.jsp">회원가입으로 이동</a>

		</c:otherwise>

	</c:choose>


</body>
</html>
