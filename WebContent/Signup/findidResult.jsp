
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Gugi&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Brush+Script&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Sunflower:wght@300&display=swap"
	rel="stylesheet">
<!-- Font Icon -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/Signup/fonts/material-icon/css/material-design-iconic-font.min.css">

<!-- Main css -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/Signup/css/style.css">
<style>
* {
	font-family: 'Sunflower';
	box-sizing: border-box;
}
</style>
<script>
	$(function() {
		$("#login")
				.on(
						"click",
						function() {

							location.href = "${pageContext.request.contextPath }/Signup/login.jsp"

						})

	})
</script>
</head>
<body>



	<!-- id찾기 -->
	<div>
		<section class="sign-in">

			<div class="container" style="margin-top: 150px;">
				<div class="signin-content">
					<div class="signin-image" style="margin-bottom:-75px;">
						<figure>
							<img
								src="${pageContext.request.contextPath}/Signup/images/signin-image.jpg"
								alt="sign up image">
						</figure>

					</div>

					<div class="signin-form">
						<h2 class="form-title">아이디 찾기 결과</h2>
						<!-- 아이디가 존재할때 -->
						<c:choose>
							<c:when test="${user_id!=null}">

								<div class="form-group" style="margin-top: 20px;">

									<div style="text-align: center">
										<h3>회원 가입시 등록한 아이디는</h3>
										<br>
										<h3 style="font-color: dodgerblue">${user_id}</h3>
										<h3>입니다.</h3>
									</div>
								</div>


								<div class="form-group form-button" style="text-align: center">
									<input type="button" name="login" id="login"
										class="form-submit" value="로그인창으로" />
								</div>





							</c:when>

							<c:otherwise>
								<!-- 아이디가 존재하지 않을때 -->

								<div class="form-group" style="margin-top: 20px;">

									<div style="text-align: center">
										<h3>회원 정보가 존재하지 않습니다.</h3>

									</div>
								</div>

								<a href="${pageContext.request.contextPath}/Signup/Idfind.jsp"><h3
										style="text-align: center"; >아이디 찾기로 이동</h3></a>
								<a
									href="${pageContext.request.contextPath}/Signup/signupView.jsp"><h3
										style="text-align: center">회원가입으로 이동</h3></a>
								<a
									href="${pageContext.request.contextPath}/main.jsp"><h3
										style="text-align: center">홈 화면으로 이동</h3></a>


							</c:otherwise>

						</c:choose>


					</div>
				</div>
			</div>


		</section>

	</div>
</body>
</html>
