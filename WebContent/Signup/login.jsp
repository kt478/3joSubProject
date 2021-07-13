<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Sign Up</title>
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
<script>
$(function(){
	
	$("#mypagebtn").on("click",function(){
		
		location.href="${pageContext.request.contextPath}/Mypage1.mem";
		
		
	})
		
	
	$("#signin").on("click",function(){
		
		$.ajax({ url:"${pageContext.request.contextPath}/login.mem",
	     	 data:{"id":$("#id").val(),"pw":$("#pw").val()}
	      	}).done(function(res){
			if(res=="1"){alert("로그인을 성공하였습니다.");
			
			
			location.href="${pageContext.request.contextPath}/forGallery.gal?cpage=1"
			
			
			}else if(res=="null"){alert("아이디혹은 비밀번호가 일치하지않습니다.")}
		
	});
	
	
})
});
</script>
<style>
*{
	font-family: 'Sunflower';
	box-sizing: border-box;
}


</style>
</head>
<body>



	<c:choose>
		<c:when test="${login !=null}">

			<!-- 로그인이 완료되었을때. -->
			<div>
				<input id="mypagebtn" type="button" value="마이페이지로이동">
			</div>
			<div>
				
			</div>
		</c:when>

		<c:otherwise>






			<div class="main">


				<!-- 비로그인상태  -->

				

				<section class="sign-in">

					<div class="container" style="margin-top: 60px;">
						<div class="signin-content">
							<div class="signin-image">
								<figure>
									<img src="images/signin-image.jpg" alt="sing up image">
								</figure>
								<a href="signupView.jsp" class="signup-image-link">아직 회원이 아니세요?</a>
								
							</div>

							<div class="signin-form" style="margin-top:30px;">
								<h2 class="form-title">로그인</h2>

								<form action="${pageContext.request.contextPath}/login.mem"
									method="POST" class="register-form" id="login-form">
									<div class="form-group">
										<label for="your_name"><i
											class="zmdi zmdi-account material-icons-name"></i></label> <input
											type="text" name="id" id="id" placeholder="아이디를 입력하세요." />
									</div>
									<div class="form-group">
										<label for="your_pass"><i class="zmdi zmdi-lock"></i></label>
										<input type="password" name="pw" id="pw"
											placeholder="패스워드를 입력하세요." />
									</div>
									<div class="form-group">
										
											<br><a href="Idfind.jsp" class="signup-image-link" style="margin-left:200px;margin-top:-23px; ">아이디 찾기</a>
											
									</div>
									<div class="form-group form-button" style="text-align:center">
										<input type="button" name="signin" id="signin"
											class="form-submit" value="로그인" />
									</div>
								</form>

							</div>
						</div>
					</div>


				</section>

			</div>
		</c:otherwise>
	</c:choose>
	<!-- JS -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>

</body>

</html>