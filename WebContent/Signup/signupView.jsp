<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>회원 가입</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<!-- Font Icon -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/Signup/fonts/material-icon/css/material-design-iconic-font.min.css">

<!-- Main css -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/Signup/css/style.css">
<script>
      $(function(){
     
    	  $("#id").on("input",function(){
            // 첫번째 인자는 팝업창 url
            // 두번째 인자는 팝업창 이름 
            // 팝업창의 크기나 위치 등의 옵션
            // get 방식으로 사용자가 입력한 아이디의 값을 보낸다. 
            //window.open("${pageContext.request.contextPath}/idCheck.mem?id="+$("#id").val(),"","width=400,height=300");
       $.ajax({
     	 url:"${pageContext.request.contextPath}/idCheck.mem",
     	 data:{"id":$("#id").val()},
     	
       }).done(function(resp){
    	 
    	   if(resp=="true"){
    		   $("#IdduplCheck").text("다른 아이디를 사용해주세요.");
    		   $("#IdduplCheck").css("color","red");
    	   }else{
    		   $("#IdduplCheck").text("사용 가능한 아이디입니다.");
    	   	   $("#IdduplCheck").css("color","blue");
    	   }
    	   })
       });
      });
      
    	  </script>

<style>
.pw-check p {
	display: none
}
</style>

</head>

<body>

	<div class="main">

		<!-- Sign up form -->
		<section class="signup">
			<div class="container">
				<div class="signup-content">
					<div class="signup-form">
						<h2 class="form-title">회원가입</h2>
						<form action="signup.mem" method="POST" class="register-form"
							id="register-form" enctype="multipart/form-data">
							<div class="form-group">
								<label for="id"><i
									class="zmdi zmdi-account material-icons-name"></i></label> <input
									type="text" name="id" id="id" placeholder="아이디를 입력해주세요."
									required>
							</div>

							<div class="form-group">
								<label for="pass"><i class="zmdi zmdi-lock"></i></label> <input
									type="password" name="pw" id="pw" placeholder="비밀번호를 입력해주세요."
									required>
							</div>

							<div class="form-group">
								<label for="re-pass"><i class="zmdi zmdi-lock-outline"></i></label>
								<input type="password" name="repw" id="repw"
									placeholder="확인 비밀번호를 입력해주세요." required>
							</div>



							<div class="form-group">
								<label for="email"><i class="zmdi zmdi-email"></i></label> <input
									type="text" name="email" id="email" placeholder="이메일을 입력해주세요."
									required>
							</div>


							<div class="form-group">
								<label for="name"><i class="zmdi zmdi-account-add"></i></label>
								<input type="text" name="name" id="person_name"
									placeholder="이름을 입력해주세요." required>
							</div>



							<div class="form-group" style="border-bottom: 1px solid gray;">
								<label for="age"><i
									class="zmdi zmdi-account material-icons-name"></i></label>
									<select name="person_age" id="person_age"
									style="width: 80%; border: 0px; color: gray;">
									<option>연령대를 선택해주세요.</option>
									<option value="10대">10대</option>
									<option value="20대">20대</option>
									<option value="30대">30대</option>
									<option value="40대">40대</option>
									<option value="50대">50대</option>
									<option value="60대">60대</option>
									<option value="70대">70대</option>
								</select>
							</div>

							<div class="form-group" style="border-bottom: 1px solid gray;">
								<label for="gender"><i class="zmdi zmdi-male-female"></i></label>
								<select name="person_gender" id="person_gender"
									style="width: 80%; border: 0px; color: gray;">
									<option>성별을 선택하세요.</option>
									<option value="남">남</option>
									<option value="여">여</option>
								</select>
							</div>



							<div class="form-group">
								<label for="contact"><i class="zmdi zmdi-phone"></i></label> <input
									type="text" name="contact" id="contact"
									placeholder="연락처를 입력해주세요." required>

							</div>

							<div class="form-group">
								<label for="profile"><i class="zmdi zmdi-camera"></i></label> <input
									type="file" required name="profile" id="profile"
									class="form-control upload" aria-describedby="file_upload">

							</div>

							<div class="form-group" style="border-bottom: 1px solid gray;">
								<label for="local"><i class="zmdi zmdi-home"></i></label> <select
									name="local" id="local"
									style="width: 80%; border: 0px; color: gray;">
									<option>거주하는 구를 선택하세요.</option>
									<option value="강남구">강남구</option>
									<option value="강동구">강동구</option>
									<option value="강북구">강북구</option>
									<option value="강서구">강서구</option>
									<option value="관악구">관악구</option>
									<option value="광진구">광진구</option>
									<option value="구로구">구로구</option>
									<option value="금천구">금천구</option>
									<option value="노원구">노원구</option>
									<option value="도봉구">도봉구</option>
									<option value="동대문구">동대문구</option>
									<option value="동작구">동작구</option>
									<option value="마포구">마포구</option>
									<option value="서대문구">서대문구</option>
									<option value="서초구">서초구</option>
									<option value="성동구">성동구</option>
									<option value="성북구">성북구</option>
									<option value="송파구">송파구</option>
									<option value="양천구">양천구</option>
									<option value="영등포구">영등포구</option>
									<option value="용산구">용산구</option>
									<option value="은평구">은평구</option>
									<option value="종로구">종로구</option>
									<option value="중구">중구</option>
									<option value="중랑구">중랑구</option>
								</select>
							</div>



							<div class="form-group form-button">
								<input type="submit" name="signup" id="signup"
									class="form-submit" value="가입하기">
							</div>

						</form>
					</div>




					<div class="signup-image">

						<div class="col-12 col-sm-auto pw-check mb-2">
							<p class="text-success" id="pw-success">비밀번호가 일치합니다.</p>
							<p class="text-danger" id="pw-danger">비밀번호가 일치하지 않습니다!</p>
							<img src="images/signup-image.jpg">
							<div id="IdduplCheck" style="margin-top: -10px;"></div>
						</div>

						<a href="login.jsp" class="signup-image-link"><h3>이미 저희 사이트의 회원이신가요?</h3></a>
					</div>
				</div>
			</div>

		</section>
	</div>
	<script
		src="${pageContext.request.contextPath }/signup/vendor/jquery/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath }/signup/js/main.js"></script>

	<script>
		//아이디 비밀번호 이름 이메일 휴대전화 유효성 검사
		let idInput = document.getElementById("id");
		let pwInput = document.getElementById("pw");
		let nameInput = document.getElementById("person_name");
		let phoneInput = document.getElementById("contact");
		let emailInput = document.getElementById("email");
		

		let idReg = /^[a-z0-9]{5,15}$/; //아이디 : 소문자/숫자 조합 5~15자
		let pwReg = /[A-Za-z0-9]{6,12}$/; //영어알파벳 숫자를 포함한 6~12자
		let nameReg = /^[가-힣a-zA-Z]{3,10}$/;//영어 알파벳 한글조합 3~10자 
		let emailReg = /^[a-z0-9\.\-_]+@([a-z]+\.)+[a-z]{3,6}/;//이메일 영문소문자+숫자조합 이메일
		let phoneReg = /^010.?\d{3,4}.?\d{4}$/;//핸드폰번호

		document.getElementById("signup").onclick =function() {

			if (!(idReg.test(idInput.value))) {
				alert("아이디는 5-15자의 영문 소문자 숫자 조합만 사용 가능합니다."); //
				return false;
			}
			if (!(pwReg.test(pwInput.value))) {
				alert("비밀번호는 영어알파벳 숫자를 포함한 6~12자를  사용하세요.");
				return false;
			}
			if (!(emailReg.test(emailInput.value))) {
				alert("이메일을 정확한 형식으로 입력해주세요.");
				return false;
			}
			
			if (!(nameReg.test(nameInput.value))) {
				alert("이름은 3~10자의 한글과 영문 대,소문자를 사용하세요.(특수기호,공백 사용 불가)");
				return false;
			}
			if (!(phoneReg.test(phoneInput.value))) {
				alert("올바른 휴대전화번호 형식으로 입력해주세요.");
				return false;
				
			}
			if($("#person_age").val()=="연령대를 선택해주세요."){
				alert("연령대를 선택해주세요.")
			
				return false;
			}
		
			if($("#person_gender").val()=="성별을 선택하세요."){
				alert("성별을 선택하세요.")
				return false;
			
			}
		
	
		
			if($("#local").val()=="거주하는 구를 선택하세요."){
				alert("거주하는 구를 선택하세요.")
				return false;
			}
		
			if($("#profile").val()=="") {
				alert("프로필 사진을 첨부해주세요."); 
				return false; 
			}
			    



			document.getElementById("register-form").submit();

		}
		
	
		
		
		//비밀번호 일치여부 확인
		document.getElementById("repw").onkeyup = function(){
			
			let chkPW = document.getElementById("pw").value;
			if (chkPW == this.value) {
				
				$("#pw-success").attr("style","display:block");
				$("#pw-success").css("color","blue");
				$("#pw-danger").attr("style","display:none");
	
			}else{
				document.getElementById("pw-success").setAttribute("style",
						"display:none");
				document.getElementById("pw-danger").setAttribute("style",
						"display:block");
				$("#pw-danger").css("color","red");
				
			}
		}
			
			

	

		
	</script>





</body>
<!-- This templates was made by Colorlib (https://colorlib.com) -->
</html>