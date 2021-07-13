<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Mypage</title>
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
	// 네비바 검색창
	$("#searchImg").on("click", function () {
		$("#search").show("slow");
        $("#search").focus();
    })
    $("#search").on("blur", function () {
    	$("#search").hide("slow");
   })
            
	//네비바 검색창에서 검색기능
	$("#search").on("keyup",function(e){
    	if(e.keyCode==13){
        	let search = $("#search").val();
        	location.href="${pageContext.request.contextPath}/search.cos?cpage=1&keyWord="+search;
    	}
	})
            
	$("#signout").on("click",function(){
    	let result = confirm("정말로 탈퇴하시겠습니까?")
   		if(result){
        	location.href="${pageContext.request.contextPath}/signout.mem";
        }else {
            location.href="${pageContext.request.contextPath}/Mypage.mem";
        }
	})
});
 </script>
<style>
* {font-family: 'Sunflower';}
body {background-color: #91C788;}
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
/* 페이지전체 navi Style 부분 끝 */     
#topContainer {
    margin: auto;
   	text-align: center;
	max-width:1150px;
        }
.top{border:1px solid #ddd;height:250px;background-color: white;border-radius: 8px;}
.img{border:1px solid #ddd;border-radius: 50%;overflow:hidden; height:100%;}
.name>h2{line-height: 160px;}
.name>h2:after{
	display: block;
    border-bottom:8px solid seagreen;
    position: relative;
    top:-60px;
    left: 30px;
    width: 150px;
    content: "";
}
#bottomContainer {
            margin: auto;
            text-align: center;
            position: relative;
            top: -60px;
            max-width:1140px;
        }
.menu{background-color: white;border-radius: 8px;}
.menu>.row{height:100px;}
.title{line-height:100px;border:1px solid rgb(173, 173, 173);border-radius: 8px;}
</style>
</head>
<body>
<!-- 페이지 전체 navi -->
	<c:choose>
		<c:when test="${login.id==null}"> <!-- 로그인 전 -->
			<nav class="navbar navbar-expand-lg navbar-light bg-white pb-0" id="navibar">
        		<a class="navbar-brand p-0 mr-4" href="${pageContext.request.contextPath}/main.jsp">
        			<img src="project_logo.jpg">
        		</a>
	        	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	          		<span class="navbar-toggler-icon"></span>
	        	</button>
	        	<div class="collapse navbar-collapse" id="navbarSupportedContent" style="line-height: 100px;">
	          		<ul class="navbar-nav mr-auto">
	            		<li class="nav-item active">
			            	<a class="nav-link" href="${pageContext.request.contextPath}/getCourse.cos?course_area=종로구">산책장소<span class="sr-only">(current)</span></a>
			            </li>
			            <li class="nav-item">
			            	<a class="nav-link beforelogin" href="javascript:;">펫시터</a>
			            </li>
			            <li class="nav-item">
			                <a class="nav-link beforelogin" href="javascript:;">갤러리</a>
			            </li>
			            <li class="nav-item">
			                <a class="nav-link beforelogin" href="javascript:;">자유게시판</a>
			            </li>
			            <li class="nav-item" id="searchBox">
			                <img src="search.png" class="nav-link" tabindex="-1" aria-disabled="true" id="searchImg">
			                <input type="search" placeholder="원하는구,장소를 검색하세요." class="form-control me-2 ml-3" id="search">
			            </li>
			        </ul>
		          	<form class="form-inline my-2 my-lg-0" id="loginNavi">
		            	<a class="mr-sm-2 p-1" style="width:70px;" href="Signup/login.jsp">로그인</a>
		            	<a class="my-2 my-sm-0" style="width:70px;" href="Signup/signupView.jsp">회원가입</a>
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
			            	<a class="nav-link" href="${pageContext.request.contextPath}/getCourse.cos?course_area=종로구">산책장소<span class="sr-only">(current)</span></a>
			            </li>
			            <li class="nav-item">
			              	<a class="nav-link" href="${pageContext.request.contextPath}/petBoardList.pet?cpage=1">펫시터</a>
			            </li>
			            <li class="nav-item">
			                <a class="nav-link" href="${pageContext.request.contextPath}/galList.gal?cpage=1">갤러리</a>
			            </li>
			            <li class="nav-item">
			                <a class="nav-link" href="${pageContext.request.contextPath}/listProc.fb?cpage=1">자유게시판</a>
			            </li>
			            <li class="nav-item" id="searchBox">
			                <img src="search.png" class="nav-link" tabindex="-1" aria-disabled="true" id="searchImg">
			                <input type="search" placeholder="원하는구,장소를 검색하세요." class="form-control me-2 ml-3" id="search">
			            </li>
			        </ul>
          			<form class="form-inline my-2 my-lg-0" id="loginNavi">
			            <a class="mr-sm-2" style="width:90px;" href="Mypage.mem">마이페이지</a>
			            <a class="my-2 my-sm-0" style="width:70px;" href="${pageContext.request.contextPath}/logout.mem">로그아웃</a>
		          	</form>
        		</div>
     		 </nav>
		</c:otherwise>
	</c:choose>

    <div class="container rounded p-4 pt-5" id="topContainer">
        <div class="row profile p-0 m-0">
            <div class="col-6 person p-2">
                <div class="row m-0 p-4 top">
                    <div class="col-6 img"> 
                        <img src="person_img/${person_img.person_oriName}" class="w-100 h-100">
                    </div>
                    <div class="col-6 name">
                       <h2>${login.person_name}</h2>
                    </div>
                </div>
            </div>
            <div class="col-6 dog p-2">
                <div class="row m-0 p-4 top">
                    <div class="col-6 img">
               		  <c:forEach var="dimg" items="${dog_img}">   
                        <img src="files/${dimg.dog_oriName}" class="w-100 h-100">
                      </c:forEach> 
                    </div>
                    <div class="col-6 name">
                        <c:forEach var="dog" items="${dog_list}">   
                          <h2>${dog.dog_name}</h2>
                         </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
 	
 	<div class="container rounded p-4 pt-5" id="bottomContainer">
        <div class="menu p-2">
            <div class="row m-0" style="height:100%">
                <div class="col-md-8 p-2">
                    <a href="${pageContext.request.contextPath}/history.planner">
                        <h5 class="title m-0">우리 동네 플래너</h5>
                    </a>
                </div>
                <div class="col-md-4 p-2">
                    <a href="${pageContext.request.contextPath}/list.message">
                        <h5 class="title m-0">내가 받은 쪽지함</h5>
                    </a>
                   </div>
            </div>
            <div class="row m-0" style="height:100%"> 
                <div class="col-4 p-2">
                    <a href="${pageContext.request.contextPath}/listProc.fb?cpage=1&category=writer&keyword=${login.id}">
                       <h5 class="title m-0">내가 올린 게시글</h5>
                  </a>
             </div>
              <div class="col-4 p-2">
                 <a href="${pageContext.request.contextPath}/galList.gal?cpage=1&category=writer&keyword=${login.id}">
                     <h5 class="title m-0">내가 올린 사진</h5>
                  </a> 
              </div>
              <div class="col-4 p-2">
                 <a href="${pageContext.request.contextPath}/petBoardList.pet?cpage=1&search=id&search2=&keyword=${login.id}">
                     <h5 class="title m-0">내가 올린 펫시터</h5>
                  </a> 
              </div>
            </div>
          <div class="row m-0" style="height:100%">   
              <div class="col-4 p-2">
                 <a href="${pageContext.request.contextPath}/doginfomodify.dog">
                     <h5 class="title m-0">강아지 정보수정</h5>
                  </a>
              </div>
            <div class="col-4 p-2">
                 <a href="${pageContext.request.contextPath}/doginfo.dog">
                    <c:choose>
                       <c:when test="${list2[0].dog_name==null}">    
                           <h5 class="title m-0">강아지정보 추가</h5>
                        </c:when>
                        <c:otherwise>
                           <h5 class="title m-0">강아지 정보수정</h5>
                        </c:otherwise>
                     </c:choose>   
                  </a> 
                </div>
                <div class="col-4 p-2">
                   <a href="${pageContext.request.contextPath}/modify.mem">
                         <h5 class="title m-0">내 정보수정</h5>
                    </a>
                </div>
                <div class="col-4 p-2">
                      <a href="" id="signout">
                        <h5 class="title m-0">회원 탈퇴</h5>
                    </a>
                </div>
            </div>
        </div>
    </div> 
</body>
</html>