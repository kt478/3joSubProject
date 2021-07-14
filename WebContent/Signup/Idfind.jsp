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
*{
	font-family: 'Sunflower';
	box-sizing: border-box;
}


</style>
</head>

<body>
	

				<!-- id찾기 -->
<div>
				<section class="sign-in">

					<div class="container" style="margin-top: 150px; ">
						<div class="signin-content">
							<div class="signin-image" style= "margin-bottom:-70px">
								<figure>
									<img src="images/signin-image.jpg" alt="sing up image">
								</figure>
								<a href="signupView.jsp" class="signup-image-link" style="margin-top:-20px;">아직 회원이 아니세요?</a>
								
							</div>

							<div class="signin-form">
								<h2 class="form-title" style="text-align:center;">아이디 찾기</h2>

								<form action="${pageContext.request.contextPath}/IdFind.idf"method="POST">
									
									<div class="form-group" style="margin-top:20px;">
										<label for="your_name"><i
											class="zmdi zmdi-account material-icons-name"></i></label> <input
											type="text" name="userName" id="userName" placeholder="이름을 입력하세요." />
									</div>
									<div class="form-group">
										<label for="your_pass"><i class="zmdi zmdi-lock"></i></label>
										<input type="text" name="userNumber" id="userNumber"
											placeholder="- 를 제외한 번호 전체를 입력해주세요." />
									</div>
									
									
									<div class="form-group">
										<label for="your_pass"><i class="zmdi zmdi-lock"></i></label>
										<input type="text" name="userEmail" id="userEmail"
											placeholder="이메일을입력해주세요." />
									</div>
									
								
									<div class="form-group form-button" style="text-align:center; margin-bottom:-30px;">
										<input type="submit" name="signin" id="findid"
											class="form-submit" value="아이디 찾기" />
									</div>
								</form>

							</div>
						</div>
					</div>


				</section>

			</div>
	
	<!-- JS -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
</body>


</html>