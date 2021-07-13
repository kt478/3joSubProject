<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(function(){
		
		document.getElementById("search").onclick= function() {
            new daum.Postcode({
                oncomplete: function (data) {
                    var roadAddr = data.roadAddress; // 도로명 주소 변수
                    document.getElementById("postcode").value = data.zonecode;
                    document.getElementById("address1").value = roadAddr;
                }
            }).open();
        }
		
		$("#back").on("click",function(){
			location.href="${pageContext.request.contextPath}/cosList.cos?cpage=1";
		})
		
	})
</script>
<style>
	.container{width:800px;margin-top:100px; border:1px solid #ddd; padding-left:35px;}
	 div[class*="col"]{padding: 0px; margin-bottom: 7px; border: 1px soild #ddd;}
	 h2{margin:20px 0px 40px 0px; font-weight:bold;}
	div>input[type=text]{width:100%; height:100%;}
	#txt{width:100%; height:100%;}
	#btn{text-align:center; margin-top:30px;}
</style>
</head>
<body>
	<div class="container">
	<form action="${pageContext.request.contextPath}/input.cos" method="post" enctype="multipart/form-data">
	<h2>산책 정보 추가</h2>
		<div class="row m-0">
			<div class="col-2">자치구</div>
			<div class="col-4">
					<select name=local>
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
		</div>
		<div class="row m-0">
			<div class="col-2">장소이름</div>
			<div class="col-4 course_name"><input type=text name=course_name></div>
		</div>
		<div class="row m-0">
			<div class="col-2">우편번호</div>
			<div class="col-4"><input type=text name=postcode id=postcode></div>
			 <div class="col-2 pl-3">
                <input type="button" id="search" value="찾기" >
            </div>
		</div>
		<div class="row m-0">
			<div class="col-2">주소</div>
			<div class="col-8"><input type=text name=address1 id=address1></div>
		</div>
		<div class="row m-0">
			<div class="col-2">설명</div>
			<div class="col-8"><textarea id=txt name=explain rows="4"></textarea></div>
		</div>
		<div class="row m-0">
			<div class="col-2">운영시간</div>
			<div class="col-8"><input type=text name=ex_time></div>
		</div>
		<div class="row m-0">
			<div class="col-2">교통편</div>
			<div class="col-8"><input type=text name=ex_way></div>
		</div>
		<div class="row m-0">
			<div class="col-2">사진</div>
			<div class="col-6 img"><input type=file name=file></div>
		</div>
		<div class="row m-0">
            <div class="col-12" id="btn">
                <input type="submit" value="추가하기" id="send" >
                <input type="button" value="취소" id="back" >
            </div>
        </div>
		
	</form>
	</div>
</body>
</html>