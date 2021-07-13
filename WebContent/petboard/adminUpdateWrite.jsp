<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Sunflower:wght@300&display=swap" rel="stylesheet">
<script>
$(function(){
	$("#back").on("click",function(){
		let result = confirm("수정 하기 전으로 돌아가시겠습니까?")
		if(result){
			location.href="${pageContext.request.contextPath}/detailWrite.pet?seq=${dto.seq}"
		}
	})
})
</script>
<style>
* {font-family: 'Sunflower';}
.Btn>div>button{width:100%;}
</style>
</head>
<body>
<div class="jumbotron jumbotron-fluid">
        <div class="container">
          <h1 class="display-5">공지사항 수정</h1>
          </div>
</div>
	<form action="updateProc.pet?seq=${dto.seq}" method="post">
		<div class="container p-4 mt-5 shadow bg-white rounded">
			<div class="row">
				<div class="col-12 col-md-2 p-2">
					<select id="selectBox" name="category" class="form-control">
						<option value="공지 사항" selected="selected">공지사항</option>
					</select>
				</div>
				<div class="col-12 col-md-10 p-2">
					<input type="text" placeholder="제목을 입력해주세요" id="title" class="form-control" name="title" style="width: 100%;" value="${dto.title}">
					<input type="hidden" id="person_id" name="person_id" value="admin">
					<input type="hidden" name="local" value="admin">
					<input type="hidden" id="person_name" name="person_name" value="admin"> 
					<input type="hidden" id="person_gender" name="person_gender" value="admin"> 
					<input type="hidden" id="person_age" name="person_age" value="admin">
					<input type="hidden" name="place_name" value="admin">
					<input type="hidden" name="pet_name" value="admin">
					<input type="hidden" name="pet_breed" value="admin">
					<input type="hidden" name="pet_gender" value="admin">
					<input type="hidden" name="pet_age" value="admin">
					<input type="hidden" name="pet_neutering" value="admin">
					<input type="hidden" name="pet_feature" value="admin">
					<input type="hidden" name="start_date" value="2021-07-12T18:08">
					<input type="hidden" name="end_date" value="2021-07-12T18:08">
				</div>
			</div>
			<div class="row">
				<div class="col-12 p-2">
					<textarea name="contents" placeholder="게시글 내용을 입력해주세요" class="form-control"
						style="width: 100%; height: 100%;">${dto.contents}</textarea>
				</div>
			</div>
			<div class="row p-2 Btn">
        		<div class="col-12 col-md-6"><button class="btn btn-outline-success">수정완료하기</button></div>
       			<div class="col-12 col-md-6"><button class="btn btn-outline-success" type="button" id="back">목록으로 돌아가기</button></div>
        	</div>
		</div>
	</form>
</body>
</html>