<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펫시터 게시판 공지사항 글쓰기</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Sunflower:wght@300&display=swap" rel="stylesheet">
<script>

    $(function(){

	// 뒤로가기 눌렀을 때
	$("#back").on("click",function(){
		let result = confirm("정말로 뒤로 돌아가시겠습니까? 작성 하던 모든 내용은 취소됩니다.")
		if(result){
			location="${pageContext.request.contextPath}/petBoardList.pet?cpage=1"
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
          <h1 class="display-5">공지사항 작성</h1>
          </div>
</div>
	<form method="post" action="${pageContext.request.contextPath}/writeProc.pet">
		<div class="container p-4 mt-5 shadow bg-white rounded">
			<div class="row">
				<div class="col-12 col-md-2 p-2">
					<select id="selectBox" name="category" class="form-control">
						<option value="공지 사항" selected="selected">공지사항</option>
					</select>
				</div>
				<div class="col-12 col-md-10 p-2">
					<input type="text" placeholder="제목을 입력해주세요" id="title" class="form-control" name="title" style="width: 100%;">
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
						style="width: 100%; height: 100%;"></textarea>
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