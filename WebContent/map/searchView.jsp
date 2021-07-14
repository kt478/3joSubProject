<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<link
	href="https://fonts.googleapis.com/css2?family=Sunflower:wght@300&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<style>
* {font-family: 'Sunflower';}
/* 페이지전체 navi Style 부분 시작 */ㅋ
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

	
	#keyword{background-color:#ddd; height:60px;  line-height:60px; text-align:center; margin-bottom:20px;}
	.menu{border:1px solid #ddd; height:100px;   margin:auto; width:600px; padding: 15px 0px 0px 15px; position:relative;}
	.menu:hover{background-color:#ddd;}
	.menu>div{float:left;}
	.cosName{ font-weight:bold; font-size:18px; margin-bottom:10px;}
	.cosName>a{text-decoration:none; color:darkblue;}
	.img{ height:80px; width:100px; position:absolute; right:20px; top:10px;}
	.img>img{width:100%; height:100%;}
	#pageList{text-align:center; margin: 30px 0px 60px 0px;}
	#pageList>a{color:black; font-size:17px;}
	#page{padding:3px;}
	#text{text-align:center; margin-top:40px; font-size:20px; font-weight:bold; border:1px solid #ddd; height:180px; line-height:180px;}
</style>
	<script>
		$(function(){
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
			// 펫시터
			$("#petsitter").on("click",function(){
					let result = confirm("로그인이 필요한 화면입니다 로그인 하시겠습니까?")
					if(result){
						location.href="signup/login.jsp";
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
    <!-- END nav -->


	<div class=container>
		<div id=keyword>"${keyWord}"를 검색하였습니다.</div>
		<c:forEach var="list" items="${list}">
		<c:choose>
			<c:when test="${list!=null }">
				<div class=menu>
				<div>
					<div class=cosName>
						<a
							href="${pageContext.request.contextPath}/getCourse.cos?course_name=${list.course_name}">${list.course_name }</a>
					</div>
					<div class=add1>${list.address1 }</div>
				</div>
				<div class=img>
					<img src="map/img/${list.oriName }">
				</div>
			</div>
			</c:when>
		</c:choose>
			
		</c:forEach>
		<c:choose>
			<c:when test="${listSize =='0' }">
				<div id=text>검색된 내용이 없습니다.</div>
			</c:when>
		</c:choose>
		
		<div id="pageList">
		<c:forEach var="i" items="${navi}" varStatus="s">
			<c:choose>
				<c:when test="${i =='>' }">
					<a
						href="${pageContext.request.contextPath}/search.cos?cpage=${navi[s.index-1]+1}&keyWord=${keyWord}">${i }</a>
				</c:when>
				<c:when test="${i =='<' }">
					<a
						href="${pageContext.request.contextPath}/search.cos?cpage=${navi[s.index+1]-1}&keyWord=${keyWord}">${i }</a>
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${i==cpage }">
							<a
						href="${pageContext.request.contextPath}/search.cos?cpage=${i}&keyWord=${keyWord}" id=page  style="color:blue;">${cpage}</a>
						</c:when>
						<c:otherwise>
							<a
						href="${pageContext.request.contextPath}/search.cos?cpage=${i}&keyWord=${keyWord}" id=page>${i}</a>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		</div>
	</div>
</body>
</html>