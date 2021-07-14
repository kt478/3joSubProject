<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자_회원명단</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Gugi&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Brush+Script&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Sunflower:wght@300&display=swap" rel="stylesheet">
<script>
$(function () {
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
       
       
	$("#allList").on("click",function(){
		location.href="${pageContext.request.contextPath}/memberList.ad?cpage=1";
	})
	
})
</script>
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

/* 회원 명단 style */
.memberList{position:absolute; top:200px; left:300px;}
.memberTitle{background-color:#c8e3c4;}
.box{border:1px solid #ddd;}

.look{position:absolute; top:150px; left:300px;}
#searchBtn{width:100%;}
</style>
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

<!-- 검색기능 -->
	<form action="${pageContext.request.contextPath}/memberList.ad" method="get">
	<div class="container look">
	<input type="hidden" name="cpage" value="1"> 
	<div class="row">
	<div class="col-4 col-md-2">
	<select id="category" name="category" class="form-control">
		<option value="id">회원id</option>
		<option value="person_age">회원 나이</option>
		<option value="person_gender">회원 성별</option>
		<option value="local">지역</option>
		<option value="reg_date">가입일</option>
	</select>
	</div>
	<div class="col-4 col-md-8">
	<input type="text" name="keyword" placeholder="검색어를 입력하세요. 단, 회원 가입일은 210711 형식으로 입력바랍니다" class="form-control">
	</div>
	<div class="col-4 col-md-2">
	<button id="searchBtn" class="btn btn-outline-secondary">검색</button>
	</div>
	</div>
	</div>
	</form>
	
<!-- list 뽑아오기 -->
	<div class="container memberList">
		<div class= "row m-0 p-4 memberTitle">
			<div class="col-12"><h3>회원 정보</h3>
		</div>
	</div>
	<c:forEach var="i" items="${list}">
		<c:choose>
			<c:when test="${i.id!='admin'}">
 				<div class="row m-0 p-4 box">
            		<div class="col-9 p-0">
            	 		<div class="row m-0">
                   			 <div class="col-12">
                        		<h3>아이디 : ${i.id}</h3>
                    		</div>
                		</div>
                		<div class="row m-0">
                    		<div class="col-12 col-md-3 pl-3 pt-3">회원 이름 : ${i.person_name}</div>
                    		<div class="col-12 col-md-3 pl-3 pt-3">회원 나이 : ${i.person_age}</div>
                    		<div class="col-12 col-md-3 pl-3 pt-3">회원 성별 : ${i.person_gender}</div>
                		</div>
                		<div class="row m-0">
                    		<div class="col-12 col-md-3 pl-3 pt-3">지역 : ${i.local}</div>
                    		<div class="col-12 col-md-4 pl-3 pt-3">이메일 : ${i.email}</div>
                    		<div class="col-12 col-md-4 pl-3 pt-3">회원 가입일 : ${i.reg_date}</div>
                		</div>
            		</div>
           			 <div class="col-3 p-0" id="profile">
                		<div class="image"><img src="person_img/${i.person_oriName}" style="width:265px; height:120px;"></div>
            		</div>
 				</div>
 			</c:when>
 		</c:choose>
 	</c:forEach>
 	<!-- 페이징 -->
 	<div class="row">
 	<div class="col-6"><button type=button id="allList" class="btn btn-outline-secondary">전체 목록 출력</button></div>
 	<div class="col-6 page">
 	<c:forEach var="i" items="${navi}" varStatus="s">
				<c:choose>
					<c:when test="${ i == '>' }">
						<a href="${pageContext.request.contextPath}/memberList.ad?cpage=${navi[s.index-1]+1}&category=${category}&keyword=${keyword}">${i}</a>
					</c:when>
					<c:when test="${ i == '<' }">
						<a href="${pageContext.request.contextPath}/memberList.ad?cpage=${navi[s.index+1]-1}&category=${category}&keyword=${keyword}">${i}</a>
					</c:when>
					<c:otherwise>
						<a href="${pageContext.request.contextPath}/memberList.ad?cpage=${i}&category=${category}&keyword=${keyword}">${i}</a>
					</c:otherwise>
				</c:choose>
	</c:forEach>
	</div>
	</div>
	</div>
</body>
</html>