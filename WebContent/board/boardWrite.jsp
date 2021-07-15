<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판 글 작성</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Sunflower:wght@300&display=swap" rel="stylesheet">

<style>
/* 글씨체 적용 */
* {font-family: 'Sunflower';}

/* 게시판 사이즈 */
.container {max-width: 900px; margin: 50px auto;}

/* 메인 내비바 아래 제목 공간 */
#temp {
	margin-bottom: 50px;
	width: 100%;
	height: 300px;
	background-color: #c8e3c4;
	line-height: 300px;
	text-align: center;
	font-size: 30px;
	font-style: initial;
	font-weight: 600;
}

p {position:absolute; top:200px; left:300px; color: white;}

/* 게시글 작성 폼 */
.title {overflow: hidden; padding-bottom: 10px; border-bottom: 5px solid seagreen;}
.title h3 input {border: none; width: 100%;}
.title h3 input:focus {outline: none;}
.contents {padding: 20px; min-height: 300px;}
.contents textarea {padding: 5px; width: 100%; height: 100%; border-color: #fff;}
.contents textarea:focus {outline: none; border-color: #f2f2f2;}
.btn_wrap {padding-top: 10px; border-top: 1px solid #ddd;}

</style>

<script>

	$(function() {
		// 메인 내비바 검색창
		$("#searchImg").on("click", function() {
			$("#search").show("slow");
			$("#search").focus();
		})
		$("#search").on("blur", function() {
			$("#search").hide("slow");
		})         
	})
	
</script>
</head>

<body>

	<div class="container-fluid">

	<!-- 메인 내비바 아래 공간 -->
	<div class="container-fluid " id="temp" style="background-image: url('board/b6.webp');"><p></p></div>

		<!-- 게시글 작성 -->
		<div class="container" id="writeForm">
			<form action="${pageContext.request.contextPath}/writeProc.fb" method="post" class="shadow-sm p-3 mb-5 bg-white rounded">
				<div class="writeBox">
				
					<div class="title">
						<h3><input type="text" name="title" id="" placeholder="제목을 입력하세요"></h3>
					</div>

					<div class="contents">
						<textarea name="contents" id="" cols="60" rows="10" placeholder="내용을 입력하세요."></textarea>
					</div>

					<div class="btn_wrap text-center">
						<input type="submit" class="btn btn-outline-success" value="등록">
						<a href="#" class="btn btn-outline-secondary" onclick="history.back()">뒤로가기</a>
					</div>
				</div>
			</form>
		</div>
	</div>
	
	<!-- footer 여백 만듦 -->
	<div class="container-fluid" style="width: 100%; height: 100px; background-color: white;"></div>
	
</body>

</html>