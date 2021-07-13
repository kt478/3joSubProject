<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<title>Document</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
	
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<style>
		.container{margin-top:100px; width:900px; border:1px solid #ddd; padding-left:35px;}
		h2{margin:20px 0px 40px 0px; font-weight:bold;}
		div[class*=col]{padding:0px; margin-bottom: 7px;}
		div>input[type=text]{width:100%; height:100%;}
		.img{height:100px;}
		.img>img{width:100px; height:100%;}
		#txt{width:100%; height:100%;}
		#btn{text-align:center; margin-top:40px;}
	</style>
	<script>
		$(function(){
			
			$("#back").on("click",function(){
				location.href="${pageContext.request.contextPath}/cosList.cos?cpage=1";
			})
			
			document.getElementById("search").onclick= function() {
            new daum.Postcode({
                oncomplete: function (data) {
                    var roadAddr = data.roadAddress; // 도로명 주소 변수
                    document.getElementById("postcode").value = data.zonecode;
                    document.getElementById("address1").value = roadAddr;
                }
            }).open();
        }
			
			
		})
	</script>
</head>
<body>
	<div class=container>
		<h2>산책 정보 수정</h2>
		<form action="${pageContext.request.contextPath}/update.cos" method="post" id="adminF" enctype="multipart/form-data" >
		<div class="row m-0">
			<div class="col-2">자치구</div>
			<div class="col-4"><input type=text value="${list.course_area }" name="course_area"></div>
		</div>
		<div class="row m-0">
			<div class="col-2">장소이름</div>
			<div class="col-4 course_name"><input type=text value="${list.course_name }" name="course_name"></div>
		</div>
		<div class="row m-0">
			<div class="col-2">우편번호</div>
			<div class="col-4"><input type=text value="${list.postcode }" name="postcode" id=postcode></div>
			<div class="col-2 pl-3">
                <input type="button" id="search" value="찾기" >
            </div>
		</div>
		<div class="row m-0">
			<div class="col-2">주소</div>
			<div class="col-8"><input type=text value="${list.address1 }" name="address1" id="address1"></div>
		</div>
		<div class="row m-0">
			<div class="col-2">설명</div>
			<div class="col-8"><textarea id=txt name="explain" rows="4">${list.explain }</textarea></div>
		</div>
		<div class="row m-0">
			<div class="col-2">운영시간</div>
			<div class="col-8"><input type=text value="${list.ex_time }" name="ex_time"></div>
		</div>
		<div class="row m-0">
			<div class="col-2">교통편</div>
			<div class="col-8"><input type=text value="${list.ex_way }" name="ex_way"></div>
		</div>
		<div class="row m-0">
			<div class="col-2">사진</div>
			<div class="col-6 img"><img src="map/img/${list.oriName }"></div>
		</div>
		<div class="row m-0">
            <div class="col-12" id="btn">
               	<input type=submit value="수정하기" id=updateBtn>
				<input type="button" value="취소" id="back" >
				<input type=hidden name="seq" value="${list.seq }">
            </div>
        </div>
		
		</form>
		
	</div>
	
</body>
</html>