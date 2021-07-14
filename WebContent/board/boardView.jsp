<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판 글 보기</title>
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

/* 페이지전체 navi Style 부분 시작 */
    #navibar{
        background-color:white;
        z-index: 1000 !important;
    }
    #searchBox{position: relative;min-height: 110px;}
    .nav-item:hover{border-bottom:3px solid #52734D;}
    #search{
        width:250px; height:40px;
        position: absolute;
        top:40px;
        left: 30px;
        display: none;
    }
    #searchImg{position: absolute;top:40px;}
    #searchImg:active~#search{left:0px;}
    #searchBox{width:300px;}
    #loginNavi{min-width: 150px;}
    #loginNavi>a{color:black;}
    #loginNavi>a:link{text-decoration:none;}
    #loginNavi>a:hover{color: #52734D;border-bottom:3px solid #52734D;}
    #loginNavi>a:visited{color: black;}
    #search{
        width:250px; height:40px;
        position: absolute;
        top:40px;
        left: 30px;
        display: none;
    }
/* 페이지전체 navi Style 부분 끝 */

/* 게시판 사이즈 */
.container {max-width: 900px; margin: 50px auto;}

/* 메인 내비바 아래 제목 공간 */
#temp {
	margin-bottom: 50px;
	width: 100%;
	height: 300px;
	background-color: #c8e3c4;
	line-height: 150px;
	text-align: center;
	font-size: 40px;
	font-style: initial;
	font-weight: 600;
}

p {position:absolute; top:200px; left:300px; color: white;}

/* 게시글 폼 */
#viewForm {border: 1px solid #f2f2f2; border-radius: 5px;}
.title {padding-left: 20px;}
.contents {width: 100%; min-height: 300px; padding-left: 20px;}
.info {padding-right: 20px; color: grey;}
.btns {float: right;}

/* 댓글 폼 */
.cmtForm {background-color: #f2f2f2; border: 1px solid gainsboro; border-radius: 3px;}
.comments {padding: 20px;}
.comments textarea {margin: 0px; padding: 5px; border-color: #fff; border-radius: 5px;}
.replyForm {border: 1px solid gainsboro; border-radius: 5px; padding: 5px;}

</style>

<script>
	$(function() {
		// 네비바 검색창 보이게
		$("#searchImg").on("click", function() {
			$("#search").show("slow");
			$("#search").focus();
		})
		$("#search").on("blur", function() {
			$("#search").hide("slow");
		})

		//네비바 검색창에서 검색기능
		$("#search").on("keyup",function(e) {
			if (e.keyCode == 13) {
				let search = $("#search").val();
				location.href = "${pageContext.request.contextPath}/search.cos?cpage=1&keyWord=" + search;
			}
		})
		
		// 네비바 비회원일 경우 로그인 페이지로 일괄 보내기.
		$(".beforelogin, #read_more_pet").on("click",function(){
			var result = confirm("로그인이 필요한 서비스 입니다. 로그인 하시겠습니까?");
		    if(result){
		    	location.href = "Signup/login.jsp";
		   	}
		})         

		// 게시글 수정 폼으로 이동
		$("#modify").on("click", function() {
			$("#viewForm").attr("action", "modiForm.fb").submit();
		})
		
		// 댓글 삭제
		$("#delete").on("click", function() {
			if (confirm("정말 삭제하시겠습니까?")) {
				location.href = "${pageContext.request.contextPath}/deleteProc.fb?seq=${dto.seq}";
			}
		})
		
		// 댓글 수정
		$("body").on("click", "#modi", function() {
			if ($(this).val() == "수정") {
				$(this).val("완료");
				$(this).parents(".container").children(".content").attr("contenteditable", "true");
				$(this).parents(".container").children(".content").focus();
				$(this).parents(".").siblings(".seq").attr("name", "seq");
			} else {
				$(this).parents(".container").find(".modifytxt").val($(this).parents(".container").children(".content").text());
				$(this).parents(".commentForm").attr("action", "modifyCmt.fbc").submit();
			}
		})
	})
	
</script>
</head>

<body>

	<!-- 페이지 전체 navi -->
	<c:choose>
		<c:when test="${login.id==null}"> <!-- 로그인 전 -->
			<nav class="navbar navbar-expand-lg navbar-light bg-white" id="navibar">
        		<a class="navbar-brand p-0 mr-4" href="${pageContext.request.contextPath}/main.jsp">
        			<img src="project_logo.jpg">
        		</a>
	        	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	          		<span class="navbar-toggler-icon"></span>
	        	</button>
	        	<div class="collapse navbar-collapse" id="navbarSupportedContent" style="line-height: 100px;">
	          		<ul class="navbar-nav mr-auto">
	            		<li class="nav-item active">
			            	<a class="nav-link" href="${pageContext.request.contextPath}/getCourse.cos?course_area=종로구">
			            	<strong>산책장소</strong>
			            	<span class="sr-only">(current)</span></a>
			            </li>
			            <li class="nav-item">
			            	<a class="nav-link beforelogin" href="javascript:;"><strong>펫시터</strong></a>
			            </li>
			            <li class="nav-item">
			                <a class="nav-link beforelogin" href="javascript:;"><strong>갤러리</strong></a>
			            </li>
			            <li class="nav-item">
			                <a class="nav-link beforelogin" href="javascript:;"><strong>자유게시판</strong></a>
			            </li>
			            <li class="nav-item" id="searchBox">
			                <img src="search.png" class="nav-link" tabindex="-1" aria-disabled="true" id="searchImg">
			                <input type="search" placeholder="원하는구,장소를 검색하세요." class="form-control me-2 ml-3" id="search">
			            </li>
			        </ul>
		          	<form class="form-inline my-2 my-lg-0" id="loginNavi">
		            	<a class="mr-sm-2 p-1" style="width:70px;" href="Signup/login.jsp"><strong>로그인</strong></a>
		            	<a class="my-2 my-sm-0" style="width:70px;" href="Signup/signupView.jsp"><strong>회원가입</strong></a>
		          	</form>
		        </div>
			</nav>
		</c:when>
		<c:when test="${login.id=='admin'}">
         <nav class="navbar navbar-expand-lg navbar-light bg-white" id="navibar">
              <a class="navbar-brand p-0 mr-4" href="${pageContext.request.contextPath}/main.jsp">
                 <img src="project_logo.jpg">
              </a>
              <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                   <span class="navbar-toggler-icon"></span>
              </button>
              <div class="collapse navbar-collapse" id="navbarSupportedContent" style="line-height: 100px;">
                <ul class="navbar-nav mr-auto">
                     <li class="nav-item active">
                        <a class="nav-link" href="${pageContext.request.contextPath}/getCourse.cos?course_area=종로구">
                        <strong>산책장소</strong>
                        <span class="sr-only">(current)</span></a>
                     </li>
                     <li class="nav-item">
                          <a class="nav-link" href="${pageContext.request.contextPath}/petBoardList.pet?cpage=1"><strong>펫시터</strong></a>
                     </li>
                     <li class="nav-item">
                         <a class="nav-link" href="${pageContext.request.contextPath}/galList.gal?cpage=1"><strong>갤러리</strong></a>
                     </li>
                     <li class="nav-item">
                         <a class="nav-link" href="${pageContext.request.contextPath}/listProc.fb?cpage=1"><strong>자유게시판</strong></a>
                     </li>
                     <li class="nav-item" id="searchBox">
                         <img src="search.png" class="nav-link" tabindex="-1" aria-disabled="true" id="searchImg">
                         <input type="search" placeholder="원하는구,장소를 검색하세요." class="form-control me-2 ml-3" id="search">
                     </li>
                 </ul>
                   <form class="form-inline my-2 my-lg-0" id="loginNavi">
                     <a class="mr-sm-2" style="width:75px;" href="${pageContext.request.contextPath}/adminMain.ad"><strong>관리자</strong></a>
                     <a class="my-2 my-sm-0" style="width:70px;" href="${pageContext.request.contextPath}/logout.mem"><strong>로그아웃</strong></a>
                   </form>
              </div>
            </nav>
     	</c:when>
		<c:otherwise>
			<nav class="navbar navbar-expand-lg navbar-light bg-white" id="navibar">
		        <a class="navbar-brand p-0 mr-4" href="${pageContext.request.contextPath}/main.jsp">
		        	<img src="project_logo.jpg">
		        </a>
		        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
		          	<span class="navbar-toggler-icon"></span>
		        </button>
		        <div class="collapse navbar-collapse" id="navbarSupportedContent" style="line-height: 100px;">
			    	<ul class="navbar-nav mr-auto">
			            <li class="nav-item active">
			            	<a class="nav-link" href="${pageContext.request.contextPath}/getCourse.cos?course_area=종로구">
			            	<strong>산책장소</strong>
			            	<span class="sr-only">(current)</span></a>
			            </li>
			            <li class="nav-item">
			              	<a class="nav-link" href="${pageContext.request.contextPath}/petBoardList.pet?cpage=1"><strong>펫시터</strong></a>
			            </li>
			            <li class="nav-item">
			                <a class="nav-link" href="${pageContext.request.contextPath}/galList.gal?cpage=1"><strong>갤러리</strong></a>
			            </li>
			            <li class="nav-item">
			                <a class="nav-link" href="${pageContext.request.contextPath}/listProc.fb?cpage=1"><strong>자유게시판</strong></a>
			            </li>
			            <li class="nav-item" id="searchBox">
			                <img src="search.png" class="nav-link" tabindex="-1" aria-disabled="true" id="searchImg">
			                <input type="search" placeholder="원하는구,장소를 검색하세요." class="form-control me-2 ml-3" id="search">
			            </li>
			        </ul>
          			<form class="form-inline my-2 my-lg-0" id="loginNavi">
			            <a class="mr-sm-2" style="width:75px;" href="Mypage.mem"><strong>마이페이지</strong></a>
			            <a class="my-2 my-sm-0" style="width:70px;" href="${pageContext.request.contextPath}/logout.mem"><strong>로그아웃</strong></a>
		          	</form>
        		</div>
     		 </nav>
		</c:otherwise>
	</c:choose>

	<!-- 메인 내비바 아래 공간 -->
	<div class="container-fluid " id="temp" style="background-image: url('board/b6.webp');"><p></p></div>

		<div class="container">
			
			<!-- 게시글 출력 -->
			<form action="" method="post" id="viewForm" class="shadow-sm p-3 mb-5 bg-white rounded">
				<div class="container viewForm">
					<div class="row title">
						<div class="col">
							<h6>[${dto.seq}]<input type="hidden" name="seq" value="${dto.seq}"></h6>
							<h3>${dto.title}</h3>
						</div>
					</div>
	
					<div class="row info">
						<div class="col">
							<h6 align="right">${dto.writer}   |   ${dto.write_date}</h6>
						</div>
					</div>
	
					<hr>
					<div class="row contents">
						<div class="col">
							<h4>${dto.contents}</h4>
						</div>
					</div>
					
					<!-- 로그인에 따라 게시글 관련 버튼이 다르게 출력됨 -->
					<div class="row btns">
						<div class="col">
	
							<c:choose>
								<c:when test="${login.id == dto.writer}">
									<input type="button" class="btn btn-outline-success" value="수정" id="modify">
									<input type="button" class="btn btn-outline-danger" value="삭제" id="delete">
									<a href="${pageContext.request.contextPath}/listProc.fb?cpage=1" class="btn btn-outline-secondary">목록</a>
								</c:when>
	
								<c:when test="${login.id == 'admin'}">
									<input type="button" class="btn btn-outline-danger" value="삭제" id="delete">
									<a href="${pageContext.request.contextPath}/listProc.fb?cpage=1" class="btn btn-outline-secondary">목록</a>
								</c:when>
	
								<c:otherwise>
									<a href="${pageContext.request.contextPath}/listProc.fb?cpage=1" class="btn btn-outline-secondary">목록</a>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
			</form>
	
			<!-- 댓글 작성 폼 -->
			<form action="writeCmt.fbc" method="post" id="cmtForm">
				<div class="container cmtForm">
					<div class="row">
						<div class="col">
							<i class="bi bi-check-all"></i> ${login.id}
						</div>
					</div>
	
					<div class="row comments">
						<div class="col">
							<textarea name="comments" style="width: 700px; height: 100px;"></textarea>
							<input type="hidden" value="${dto.seq}" name="parent_seq">
						</div>
	
						<div class="col">
							<a href="${pageContext.request.servletPath}/writeCmt.fbc?parent_seq=${dto.seq}">
								<button id="reply" class="btn btn-info" style="width: 100%; height: 100px; padding: 0px;">작성</button>
							</a>
						</div>
					</div>
				</div>
			</form>
	
			<!-- 댓글 출력 및 수정, 삭제 -->
			<c:forEach var="i" items="${clist}" varStatus="s">
				<c:choose>
					<c:when test="${login.id == i.writer}">
						<form action="" method="post" class="commentForm">
							<div class="container comment shadow-sm p-3 mb-5 bg-white rounded" style="overflow: hidden; width: 800px; margin: 0px 35px 0px 35px;">
								<div class="header" style="background-color: white; padding-bottom: 10px;">
									${i.writer} | ${i.write_date}</div>
	
								<div class="content">${i.comments}</div>
								<input type="hidden" name="comments" class="modifytxt"> 
								<input type="hidden" class="seq" value="${i.seq}">
	
								<div class="reply">
									<a href="${pageContext.request.contextPath}/deleteCmt.fbc?seq=${i.seq}&parent_seq=${dto.seq}" style="float: right;"> 
									<input type="button" class="btn btn-outline-danger" value="삭제" style="float: right;"></a>
									<input type="button" id=modi class="btn btn-outline-success" style="float: right; margin-bottom: 10px; margin-right: 5px;" value="수정">
								</div>
							</div>
	
							<input type="hidden" id="seq" name="seq" value="${i.seq}">
							<input type="hidden" name="parent_seq" value="${dto.seq}">
							<hr>
						</form>
					</c:when>
	
					<c:when test="${login.id == 'admin'}">
						<br>
						<div class="container shadow-sm p-3 mb-5 bg-white rounded" style="overflow: hidden; width: 800px; margin: 0px 35px 0px 35px;">
							<div class="header" style="background-color: white; padding-bottom: 10px;">
								${i.writer} | ${i.write_date}</div>
	
							<div class="content">${i.comments}</div>
							<input type="hidden" class="seq" value="${i.seq}">
	
							<div class="reply">
								<a href="${pageContext.request.contextPath}/deleteCmt.fbc?seq=${i.seq}&parent_seq=${dto.seq}" style="float: right;"> 
									<input type="button" class="btn btn-outline-danger" value="삭제" style="float: right;"></a>
							</div>
						</div>
	
						<input type="hidden" value="${i.seq}" id="seq" name="seq">
						<input type="hidden" name="parent_seq" value="${dto.seq}">
						<hr>
					</c:when>
	
					<c:otherwise>
						<br>
						<div class="container shadow-sm p-3 mb-5 bg-white rounded" style="overflow: hidden; width: 800px; margin: 0px 35px 0px 35px;">
							<div class="header" tyle="background-color: white; padding-bottom: 10px;">
								${i.writer} | ${i.write_date}</div>
	
							<div class="content">${i.comments}</div>
							<input type="hidden" class="seq" value="${i.seq}">
	
							<div class="reply"></div>
						</div>
	
						<input type="hidden" value="${i.seq}" id="seq" name="seq">
						<input type="hidden" name="parent_seq" value="${dto.seq}">
						<hr>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
		
		<!-- footer 여백 만듦 -->
		<div class="container-fluid" style="width: 100%; height: 100px; background-color: white;"></div>
		
</body>

</html>