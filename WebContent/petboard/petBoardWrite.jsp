<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펫시터 게시판 글쓰기</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Sunflower:wght@300&display=swap" rel="stylesheet">
<script>

    $(function(){
    // 펫시터 합니다는 강아지 정보 없어도 가능 나머지는 필수 
    $("#selectBox").change(function(){
    	       var option = $('#selectBox option:selected').val();
    	       console.log(option)
    	       if(option == "펫시터 합니다"){
    	    	   $("#pet_name").prop("required",false);
    	    	   $("#pet_breed").prop("required",false);
    	    	   $("#pet_gender").prop("required",false);
    	    	   $("#pet_age").prop("required",false);
    	    	   $("#pet_neutering").prop("required",false);
    	    	   $("#pet_feature").prop("required",false);
    	    	   $("[name=local2]").attr("required",true);
    	    	   $("[name=place_name]").attr("required",true);
    	       }else{
    	    	   $("#pet_name").prop("required",true);
    	    	   $("#pet_breed").prop("required",true);
    	    	   $("#pet_gender").prop("required",true);
    	    	   $("#pet_age").prop("required",true);
    	    	   $("#pet_neutering").prop("required",true);
    	    	   $("#pet_feature").prop("required",true);
    	    	   $("[name=local2]").attr("required",true);
    	    	   $("[name=place_name]").attr("required",true);
    	       }
    	   })

// 뒤로가기 눌렀을 때
	$("#back").on("click",function(){
		let result = confirm("정말로 뒤로 돌아가시겠습니까? 작성 하던 모든 내용은 취소됩니다.")
		if(result){
			location="${pageContext.request.contextPath}/petBoardList.pet?cpage=1"
			}
	})
// submit 했을 때
	$("#real").on("click",function(){
		let result = confirm("글 작성을 완료하시겠습니까?")
		if(result){
			$("#frm").on("submit",function(){
				$("#hperson_id").val($("#person_id").text());
				$("#hperson_name").val($("#person_name").text());
				$("#hperson_gender").val($("#person_gender").text());
				$("#hperson_age").val($("#person_age").text());
				
				$("#frm").attr("action","${pageContext.request.contextPath}/writeProc.pet").submit();
			})
		}
	})
   
})
</script>
<style>
* {font-family: 'Sunflower';}
input {padding: 0px;}
div>input {width: 100%;}
#postcode {width: 50%;}
#search {width: 40%;}
/* jumbo */
.jumbotron{background-color:#D6EFC7;}
.line1{padding-top:10px; }  
.display-5{color:#184D47; font-weight:600;}
p{color:#184D47;}
/* 글쓰기 */
#selectBox{width:100%; height:100%;}
div{color:gray; font-weight:600; font-size:medium;}
.address_2>div>input{width:100%;}
#pet_title{text-align:center; line-height:45px;}
</style>
</head>
<body>
 <div class="jumbotron jumbotron-fluid">
        <div class="container">
          <h1 class="display-5">펫시터 게시판</h1>
          <hr>
          <p class="line1">반려견과 함께 산책할 친구를 찾고 계신가요?</p>
          <p class="line2">혹은 나의 소중한 반려견을 돌봐 줄 누군가를 찾고 있나요?</p>
          <p class="line3">주변의 도움이 될 만한 분들을 찾아 드립니다!</p>
        </div>
</div>
	<form method="post" id="frm">
		<div class="container p-4 mt-5 shadow bg-white rounded">
			<div class="row">
				<div class="col-12 col-md-2 p-2">
					<select id="selectBox" name="category" class="form-control">
						<option value="산책 동행" selected="selected">산책 동행</option>
						<option value="펫시터 구해요">펫시터 구해요</option>
						<option value="펫시터 합니다">펫시터 합니다</option>
					</select>
				</div>
				<div class="col-12 col-md-10 p-2">
					<input type="text" placeholder="제목을 입력해주세요" id="title" class="form-control" name="title" style="width: 100%;" required>
				</div>
			</div>
			<div class="row">
				<div class="col-12 col-md-3" id="pet_title">강아지 정보</div>
				<div class="col-12  col-md-3 p-2" >
					<input type="text" id="pet_name" name="pet_name" placeholder="강아지 이름" class="form-control" required>
				</div>
				<div class="col-12 col-md-3 p-2">
					<select id="pet_breed" name="pet_breed" class="form-control" required>
					       <option value="">강아지의 품종</option>
						   <option value="">토이그룹</option>
                           <option value="">------</option>
                           <option value="치와와">치와와</option>
                           <option value="말티즈">말티즈</option>
                           <option value="미니어쳐 핀셔">미니어쳐 핀셔</option>
                           <option value="파피용">파피용</option>
                           <option value="포메라니안">포메라니안</option>
                           <option value="푸들">푸들</option>
                           <option value="시츄">시추</option>
                           <option value="">테리어그룹</option>
                           <option value="">-------</option>
                           <option value="미니어쳐 슈나우저">미니어쳐 슈나우져</option>
                           <option value="요크셔테리어">요크셔테리어</option>
                           <option value="에어데일 테리어">에어데일 테리어</option>
                           <option value="스코티쉬테리어">스코티쉬테리어</option>
                           <option value="">하운드 그룹</option>
                           <option value="">-------</option>
                           <option value="비글">비글</option>
                           <option value="닥스훈트">닥스훈트</option>
                           <option value="아프간하운드">아프간하운드</option>
                           <option value="그레이하운드">그레이하운드</option>
                           <option value="바셋하운드">바셋하운드</option>
                           <option value="">사냥견그룹</option>
                           <option value="">-------</option>
                           <option value="코카스패니얼">코카스패니얼</option>
                           <option value="골든리트리버">골든리트리버</option>
                           <option value="포인터">포인터</option>
                           <option value="세터">세터</option>
                           <option value="비즐라">비즐라</option>
                           <option value="">사역견그룹</option>
                           <option value="">-------</option>
                           <option value="시베리안 허스키">시베리안 허스키</option>
                           <option value="알래스칸 말라뮤트">알래스칸 말라뮤트</option>
                           <option value="도베르만 핀셔">도베르만 핀셔</option>
                           <option value="로트 와일러">로트 와일러</option>
                           <option value="버니즈 마운틴 독">버니즈 마운틴 독</option>
                           <option value="">목양견그룹</option>
                           <option value="">-------</option>
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
				<div class="col-12 col-md-3 p-2">
					<select id="pet_gender" name="pet_gender" class="form-control" required>
						<option value="">강아지 성별</option>
						<option value="암컷">암컷</option>
						<option value="수컷">수컷</option>
					</select>
				</div>
				</div>
				<div class="row">
				<div class="col-12 col-md-4 p-2">
					<select id="pet_age" name="pet_age" class="form-control" required>
						<option value="">강아지 나이</option>
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
				<div class="col-12 col-md-4 p-2" >
					<select id="pet_neutering" name="pet_neutering" class="form-control" required>
						<option value="">강아지 중성화 여부</option>
						<option value="유">유</option>
						<option value="무">무</option>
					</select>
				</div>
				<div class="col-12 col-md-4 p-2">
					<select id="pet_feature" name="pet_feature" class="form-control" required>
                           <option value="">강아지 특징</option>
                           <option value="활발하고 활동적이에요">활발하고 활동적이에요</option>
                           <option value="사람이나 강아지를 보고 짖어요">사람이나 강아지를 보고 짖어요</option>
                           <option value="조용하고 소심해요">조용하고 소심해요</option>
                           <option value="법정 지정 맹견이에요">법정 지정 맹견이에요</option>
                           <option value="예민하지 않고 친근한 성격이에요">예민하지 않고 친근한 성격이에요</option>
                     </select>
				</div>
			</div>
			<div class="row">
				<div class="col-4 p-2" id="person">사람정보</div>
				<div class="col-2 p-2" id="person_id">${info.id}</div>
				<div class="col-2 p-2" id="person_name">${info.person_name}</div>
				<div class="col-2 p-2" id="person_gender">${info.person_gender}</div>
				<div class="col-2 p-2" id="person_age">${info.person_age}</div>
				<input type="hidden" id="hperson_id" name="person_id"> 
				<input type="hidden" id="hperson_name" name="person_name"> 
				<input type="hidden" id="hperson_gender" name="person_gender"> 
				<input type="hidden" id="hperson_age" name="person_age">
			</div>
			<div class="row">
				<div class="col-md-2 col-12 p-2" style="line-height:40px;">기간 선택하기</div>
				<div class="col-md-2 col-4 p-2" style="line-height:40px;">시작 날짜와 시간</div>
				<div class="col-md-3 col-8 p-2">
					<input type="datetime-local" name="start_date" class="form-control" required>
				</div>
				<div class="col-md-2 col-4 p-2" style="line-height:40px;">종료 날짜와 시간</div>
				<div class="col-md-3 col-8 p-2">
					<input type="datetime-local" name="end_date" class="form-control" required>
				</div>
			</div>
			<div class="row address_1">
				<div class="col-md-2 col-12 p-2">약속장소 정하기</div>
				<div class="col-md-10 col-12 p-2">
					 <label for="taskId" class="col-form-label">자치구</label>
                        <select name="local" id="local2" class="form-control" onchange="categoryChange(this)" required> 
                           <option value="">거주하는 구를 선택하세요.</option>
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
                        <label for="taskId" class="col-form-label" id="addresstext">장소 선택</label>
                        <select name="place_name" id="place_name" class="form-control" required>
                           <option>장소를 선택해주세요.</option>
                        </select>
                        <script>
                        function categoryChange(e) {
                           var place_name_강남구 = ["청담근린공원", "대모산자연공원", "양재천"];
                           var place_name_강동구 = ["일자산공원", "암사생태공원", "길동자연생태공원"];
                           var place_name_강북구 = ["북서울꿈의 숲", "우이천", "솥밭공원"];
                           var place_name_강서구 = ["봉제산 근린공원", "궁산근린공원", "우장산공원"];
                           var place_name_관악구 = ["관악산 호수공원", "낙성대공원", "도림천"];
                           var place_name_광진구 = ["아차산 생태공원", "뚝섬 한강공원", "광진숲나루", "어린이대공원"];
                           var place_name_구로구 = ["푸른수목원", "구로개봉 유수지 생태공원", "고척근린공원"];
                           var place_name_금천구 = ["금천 체육공원", "호암늘솔길", "금천구 안양천"];
                           var place_name_노원구 = ["경춘선숲길", "불암산 힐링타운", "영축산 순환산책로"];
                           var place_name_도봉구 = ["방학천", "서울 창포원"];
                           var place_name_동대문구 = ["배봉산 둘레길", "답십리공원", "중량천 장안벚꽃안길"];
                           var place_name_동작구 = ["보라매공원", "서달산 동작충효길", "사육신공원"];
                           var place_name_마포구 = ["상암 하늘공원", "경의선숲길", "망원 한강공원"];
                           var place_name_서대문구 = ["안산 도시자연공원", "불광천", "궁동근린공원"];
                           var place_name_서초구 = ["몽마르뜨공원", "양재시민의 숲", "우면산"];
                           var place_name_성동구 = ["서울숲", "금호산 응봉근린공원", "달맞이봄공원"];
                           var place_name_성북구 = ["개운산공원", "정릉천", "오동공원"];
                           var place_name_송파구 = ["송파둘레길", "아시아공원", "올림픽공원"];
                           var place_name_양천구 = ["서서울공원", "용왕산 근린공원", "달마을 근린공원"];
                           var place_name_영등포구 = ["여의도 한강공원", "양화 한강공원", "선유도공원"];
                           var place_name_용산구 = ["옹산가족공원", "이촌한강공원", "남산둘레길"];
                           var place_name_은평구 = ["봉산 둘레길", "서울 혁신파크", "신사근린공원"];
                           var place_name_종로구 = ["북악스카이웨이", "낙산공원", "숭인근린공원"];
                           var place_name_중구 = ["남산공원", "서울로 7107", "매봉산공원"];
                           var place_name_중랑구 = ["중량천", "봉화산", "용마폭포공원"];
                           
                           var target = document.getElementById("place_name");
                           
                           if(e.value == "강남구") {var place = place_name_강남구;}
                           else if(e.value == "강동구") {var place = place_name_강동구;}
                           else if(e.value == "강북구") {var place = place_name_강북구;}
                           else if(e.value == "강서구") {var place = place_name_강서구;}
                           else if(e.value == "관악구") {var place = place_name_관악구;}
                           else if(e.value == "광진구") {var place = place_name_광진구;}
                           else if(e.value == "구로구") {var place = place_name_구로구;}
                           else if(e.value == "금천구") {var place = place_name_금천구;}
                           else if(e.value == "노원구") {var place = place_name_노원구;}
                           else if(e.value == "도봉구") {var place = place_name_도봉구;}
                           else if(e.value == "동대문구") {var place = place_name_동대문구;}
                           else if(e.value == "동작구") {var place = place_name_동작구;}
                           else if(e.value == "마포구") {var place = place_name_마포구;}
                           else if(e.value == "서대문구") {var place = place_name_서대문구;}
                           else if(e.value == "서초구") {var place = place_name_서초구;}
                           else if(e.value == "성동구") {var place = place_name_성동구;}
                           else if(e.value == "성북구") {var place = place_name_성북구;}
                           else if(e.value == "송파구") {var place = place_name_송파구;}
                           else if(e.value == "양천구") {var place = place_name_양천구;}
                           else if(e.value == "영등포구") {var place = place_name_영등포구;}
                           else if(e.value == "용산구") {var place = place_name_용산구;}
                           else if(e.value == "은평구") {var place = place_name_은평구;}
                           else if(e.value == "종로구") {var place = place_name_종로구;}
                           else if(e.value == "중구") {var place = place_name_중구;}
                           else if(e.value == "중랑구") {var place = place_name_중랑구;}
                           
                           target.options.length = 0;
                           
                           for (x in place) {
                              var opt = document.createElement("option");
                              opt.value = place[x];
                              opt.innerHTML = place[x];
                              target.appendChild(opt);
                           }
                        }
                        </script>
                </div>
			</div>
			<div class="row">
				<div class="col-12 p-2">
					<textarea name="contents" placeholder="게시글 내용을 입력해주세요" class="form-control"
						style="width: 100%; height: 100%;" required></textarea>
				</div>
			</div>
			<div class="row button">
				<div class="col-12 col-md-4 p-2">
					<input type="reset" value="다시작성하기" class="btn btn-outline-success"> 
				</div>
				<div class="col-12 col-md-4 p-2"> 
					<input type="submit" value="글 작성하기" id="real" class="btn btn-success"> 
				</div>
				<div class="col-12 col-md-4 p-2"> 
					<input type="button" id="back" value="돌아가기" class="btn btn-outline-success">
				</div>
			</div>
		</div>
	</form>
</body>
</html>