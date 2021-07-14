<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자_문의하기 쪽지함</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Sunflower:wght@300&display=swap" rel="stylesheet">

<style>
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

/* side navi style */
.side_menu{position:fixed; top:150px; width:250px;}
.list-group{height:100px;}
.list-group-item{padding:0px;}
.admin_menu{width:100%; height:100px; text-align:center; line-height:100px;}

/* 메인 내비바 아래 제목 공간 */
#temp {
	margin-bottom: 50px;
	width: 100%;
	height: 100px;
	background-color: white;
	line-height: 100px;
	text-align: center;
	font-size: 30px;
	font-style: initial;
	font-weight: 600;
}

/* 게시판 사이즈 */
/* .page_nav {position: absolute; left: 50%; top: calc(50% + 0.475rem); transform: translate(-50%, -50%); margin-left: 20px;}
.table {table-layout: fixed;}
.table thead {background-color: #f2f2f2;}
.table thead th {border-bottom: none;}
.table td, .table th {border-color: #ddd;}
.table td {word-wrap: break-word; position: relative;}
tfoot {position: relative;} */

/* 게시판 페이지 내비 */
ul {list-style: none;}
li {float: left;}
a:link {text-decoration: none; color: black;}
a:visited {text-decoration: none; color: black;}
a:active {text-decoration: none; color: black;}
a:hover {text-decoration: none; color: black;}
/* #boardNavi{position:absolute; top:150px; left:300px;} */
#boardNavi ul li {display: inline-block;}
#boardNavi ul li.active a {background: #fff; color: grey; border: 1px solid gainsboro;}

span{font-size:30px; font-weight:600; background-color:#c8e3c4;}

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
	
	
<!-- side navi -->
	<div class="container side_menu">
		<ul class="list-group">
  			<li class="list-group-item">
  				<a href="${pageContext.request.contextPath}/memberList.ad?cpage=1" class="list-group-item list-group-item-action list-group-item-success admin_menu"><strong>회원 명단</strong></a>
			</li>
  			<li class="list-group-item">
  				<a href="${pageContext.request.contextPath}/questionList.ad?cpage=1" class="list-group-item list-group-item-action list-group-item-success admin_menu"><strong>쪽지함</strong></a>
 			 </li>
  			<li class="list-group-item">
  				<a href="${pageContext.request.contextPath}/blackList.ad" class="list-group-item list-group-item-action list-group-item-success admin_menu" id="blacklistshowup"><strong>블랙리스트 명단</strong></a></li>
  			</li>
		</ul>
	</div>


	<!-- 문의하기 쪽지함 목록 -->
	
	<div class="container" style="text-align:center; position:absolute; top:150px; left:300px;">
		<span>문의하기 쪽지함</span><hr>
		<c:forEach var="list" items="${list}" varStatus="">
			<div class="container form shadow-sm p-3 mb-5 bg-white rounded" 
				style="border: 1px solid grey; padding: 10px; text-align:center; border-radius:5px; margin-bottom:10px;">
				<div class="row">
					<div class="col-4">번호 : ${list.seq}</div>
					<div class="col-4">이름 : ${list.name}</div>
					<div class="col-4">이메일 : ${list.email}</div>
				</div>
				<hr>
				<div class="row">
					<div class="col-4">날짜 : ${list.ask_date}</div>
					<div class="col-4">카테고리 : ${list.type}</div>
					<div class="col-4"><a href="${pageContext.request.contextPath}/questionDelete.ad?seq=${list.seq}">
						<button class="btn btn-outline-info btn-sm delete">삭제</button></a></div>
				</div>
				<hr>
				<div class="row">
					<div class="col-12">내용 : ${list.contents}</div>
				</div>
			</div>
		</c:forEach>
		<!-- 페이지 내비 -->
		<div class="container">
			<nav aria-label="Page navigation example" id="boardNavi" style="position:absolute; left:550px;">
				<ul class="pagination">
					<c:forEach var="i" items="${navi}" varStatus="s">
						<c:choose>
							<c:when test="${i == '>'}">
								<li class="page-item">
								<a class="page-link" href="${pageContext.request.contextPath}/questionList.ad?cpage=${navi[s.index-1]+1}&category=${category}&keyword=${keyword}"
									id="rightNavi">${i}</a></li>
							</c:when>
		
							<c:when test="${i == '<'}">
								<li class="page-item">
								<a class="page-link" href="${pageContext.request.contextPath}/questionList.ad?cpage=${navi[s.index+1]-1}&category=${category}&keyword=${keyword}"
									id="leftNavi">${i}</a></li>
							</c:when>
		
							<c:otherwise>
								<li class="page-item active">
								<a class="page-link" href="${pageContext.request.contextPath}/questionList.ad?cpage=${i}&category=${category}&keyword=${keyword}"
									id="centerNavi">${i}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</ul>
			</nav>		
		</div>		
	</div>

	<!-- footer 여백 만듦 -->
	<div class="container-fluid" style="width: 100%; height: 100px; background-color: white;"></div>
	
</body>
</html>