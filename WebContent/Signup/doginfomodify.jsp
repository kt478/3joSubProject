<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>강아지 정보추가</title>

<!-- Font Icon -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/Signup/fonts/material-icon/css/material-design-iconic-font.min.css">

<link
	href="${pageContext.request.contextPath}/WebContent/bootstrap-select/bootstrap-select.min.css"
	rel="stylesheet" type="text/css" />


<!-- Main css -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/Signup/css/style.css">
<script src="/WebContent/bootstrap-select/bootstrap-select.min.js"></script>
<script>
	$(window).on('load', function() {
		$('.selectpicker').selectpicker({
			'selectedText' : 'cat'
		});
	});
</script>





</head>
<body>

	<div class="main">





		<!-- modify form -->
		<section class="signup">
			<div class="container">
				<div class="signup-content">
					<div class="signup-form" style="margin-bottom: 50px;">
						<h2 class="form-title">강아지 정보수정</h2>

						<div class="form-group">




							<c:choose>
								<c:when test="${login != null}">
                               
                                ${login.id} 님, 안녕하세요?
                            	
                            	</c:when>
							</c:choose>
						</div>
						<form
							action="${pageContext.request.contextPath}/doginfomodifyPro.dog"
							method="POST" class="register-form" id="register-form"
							enctype="multipart/form-data">


							<div class="form-group">
								<label for="name"><i
									class="zmdi zmdi-account material-icons-name"></i></label> <input
									type="text" name="dog_name" id="dog_name"
									placeholder="강아지 이름을 입력해주세요." />
							</div>
							<div class="form-group" style="border-bottom: 1px solid gray;">
								<label for="breed"><i class="zmdi zmdi-github"></i></label> <select
									name="dog_breed" id="dog_breed"
									style="width: 80%; border: 0px; color: gray;">

									<option>강아지의 종을 선택해주세요.</option>
									<option>토이그룹</option>
									<option>------</option>
									<option value="치와와">치와와</option>
									<option value="말티즈">말티즈</option>
									<option value="미니어쳐 핀셔">미니어쳐 핀셔</option>
									<option value="파피용">파피용</option>
									<option value="포메라니안">포메라니안</option>
									<option value="푸들">푸들</option>
									<option value="시츄">시추</option>
									<option>테리어그룹</option>
									<option>-------</option>
									<option value="미니어쳐 슈나우저">미니어쳐 슈나우져</option>
									<option value="요크셔테리어">요크셔테리어</option>
									<option value="에어데일 테리어">에어데일 테리어</option>
									<option value="스코티쉬테리어">스코티쉬테리어</option>
									<option>하운드 그룹</option>
									<option>-------</option>
									<option value="비글">비글</option>
									<option value="닥스훈트">닥스훈트</option>
									<option value="아프간하운드">아프간하운드</option>
									<option value="그레이하운드">그레이하운드</option>
									<option value="바셋하운드">바셋하운드</option>
									<option>사냥견그룹</option>
									<option>-------</option>
									<option value="코카스패니얼">코카스패니얼</option>
									<option value="골든리트리버">골든리트리버</option>
									<option value="포인터">포인터</option>
									<option value="세터">세터</option>
									<option value="비즐라">비즐라</option>
									<option>사역견그룹</option>
									<option>-------</option>
									<option value="시베리안 허스키">시베리안 허스키</option>
									<option value="알래스칸 말라뮤트">알래스칸 말라뮤트</option>
									<option value="도베르만 핀셔">도베르만 핀셔</option>
									<option value="로트 와일러">로트 와일러</option>
									<option value="버니즈 마운틴 독">버니즈 마운틴 독</option>
									<option>목양견그룹</option>
									<option>-------</option>
									<option value="보더콜리">보더콜리</option>
									<option value="셔틀랜드 쉽독">셔틀랜드 쉽독</option>
									<option value="웰시코기">웰시코기</option>
									<option value="셰퍼드">셰퍼드</option>
									<option value="잉글리시 쉽독">잉글리시 쉽독</option>
									<option value="진돗개">진돗개</option>
									<option value="삽살개">삽살개</option>
									<option value="풍산개">풍산개</option>
									<option value="불독">불독</option>
									<option value="시바견">시바견</option>
									<option value="달마시안">달마시안</option>
									<option value="비숑프리제">비숑프리제</option>
									<option value="차우차우">차우차우</option>
									<option value="샤페이">샤페이</option>
									<option value="믹스견">믹스견</option>


								</select>
							</div>


							<div class="form-group" style="border-bottom: 1px solid gray;">
								<label for="age"><i
									class="zmdi zmdi-account material-icons-name"></i></label> <select
									name="dog_gender" id="dog_gender"
									style="width: 80%; border: 0px; color: gray;">
									<option>강아지의 성별을 선택해주세요.</option>
									<option value="암컷">암컷</option>
									<option value="수컷">수컷</option>


								</select>
							</div>


							<div class="form-group" style="border-bottom: 1px solid gray;">
								<label for="age"><i
									class="zmdi zmdi-account material-icons-name"></i></label> <select
									name="dog_age" id="dog_age"
									style="width: 80%; border: 0px; color: gray;">

									<option>강아지의 나이를 선택해주세요.</option>


									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
									<option value="6">6</option>
									<option value="7">7</option>
									<option value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									<option value="13">13</option>
									<option value="14">14</option>
									<option value="15">15</option>
									<option value="16">16</option>
									<option value="17">17</option>
									<option value="18">18</option>
									<option value="19">19</option>
									<option value="20">20</option>

								</select>
							</div>





							<div class="form-group" style="border-bottom: 1px solid gray;">
								<label for="age"><i
									class="zmdi zmdi-account material-icons-name"></i></label> <select
									name="dog_neutering" id="dog_neutering"
									style="width: 80%; border: 0px; color: gray;">
									<option>강아지의 중성화 여부를 입력해주세요.</option>
									<option value="유">유</option>
									<option value="무">무</option>


								</select>
							</div>




							<div class="form-group">
								<label for="profile"><i
									class="zmdi zmdi-account material-icons-name"></i></label> <input
									type="file" name="profile" id="profile"
									class="form-control upload" aria-describedby="file_upload">

							</div>
							<div class="form-group" style="border-bottom: 1px solid gray;">
								<label for="age"><i
									class="zmdi zmdi-account material-icons-name"></i></label> <select
									name="dog_feature" id="dog_feature"
									style="width: 80%; border: 0px; color: gray;">
									<option value="">강아지 성격을 선택해주세요.</option>
		                           <option value="활발하고 활동적이에요">활발하고 활동적이에요</option>
		                           <option value="사람이나 강아지를 보고 짖어요">사람이나 강아지를 보고 짖어요</option>
		                           <option value="조용하고 소심해요">조용하고 소심해요</option>
		                           <option value="법정 지정 맹견이에요">법정 지정 맹견이에요</option>
		                           <option value="예민하지 않고 친근한 성격이에요">예민하지 않고 친근한 성격이에요</option>
								</select>
							</div>



							<div class="dog_parent">
								<c:choose>
									<c:when test="${login != null}">
										<input type="hidden" value="${login.id}" name="dog_parent_id">
									</c:when>
								</c:choose>
							</div>

							<div class="dog_seq">



								<c:forEach var="dog" items="${list2}">

									<input type="hidden" value="${dog.seq}" name="seq">

								</c:forEach>

							</div>



							<div class="form-group form-button">
								<input type="submit" name="signup" id="signup"
									class="form-submit" value="수정하기">
							</div>




						</form>
					</div>
					<div class="signup-image">
						<figure>
							<img
								src="${pageContext.request.contextPath}/Signup/images/signup-image.jpg"
								alt="modify image">
						</figure>

					</div>

				</div>
				<!-- 		<div class="form-group form-button border" style="margin-top:-145px">
								<input type="button" name="backtomypage" id="backtomypage"
									class="" value="뒤로가기" />
							</div> -->
			</div>
		</section>
	</div>



	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
</body>
<!-- This templates was made by Colorlib (https://colorlib.com) -->
</html>