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
.name>h2{line-height: 190px;}
#bottomContainer {
            margin: auto;
            text-align: center;
            position: relative;
            top: -40px;
            max-width:1140px;
        }
.menu{background-color: white;border-radius: 8px;}
.menu>.row{height:100px;}
.title{line-height:100px;border:1px solid rgb(173, 173, 173);border-radius: 8px;}
a:link {text-decoration: none; color: black;}
a:visited {text-decoration: none; color: black;}
a:active{text-decoration: none; color: black;}
a:hover{text-decoration: none; color: #146c43;}
h5:hover{font-weight:700;}
#adddog{padding-top:40px;border:1px solid #146c43;}
#adddog:hover{background-color:#146c43;}
#adddog:hover>a>h4{color:white;}
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

    <div class="container rounded p-4 pt-5" id="topContainer">
        <div class="row profile p-0 m-0">
            <div class="col-6 person p-2">
                <div class="row m-0 p-4 top">
                    <div class="col-6 img p-0"> 
                        <img src="person_img/${person_img.person_oriName}" class="w-100 h-100">
                    </div>
                    <div class="col-6 name">
                       <h2 class="m-0 h-100">${login.person_name}</h2>
                       <hr style="height: 5px; max-width:150px;background-color: #146c43; opacity: 1;
                      			 position: relative; top: -130px;">
                    </div>
                </div>
            </div>
            <div class="col-6 dog p-2">
                <div class="row m-0 p-4 top">
                <c:choose>
                	<c:when test="${dog_img != null }">
                		<div class="col-6 img p-0">
                			<img src="files/${dog_img.dog_oriName}" class="h-100">
                		</div>	
                		<div class="col-6 name">
                			<h2 class="m-0 h-100">${dog_list.dog_name}</h2>
                        	<hr style="height: 5px; max-width:150px;background-color: #146c43; opacity: 1;
                      			 	position: relative; top: -130px;">  
                      	</div>			 
                	</c:when>
                	<c:otherwise>
                		<div class="col-12 p-5">
                			<div class="btn btn-outline-success w-100 h-100" id="adddog">
                				<a href="${pageContext.request.contextPath}/Signup/doginfo.jsp"><h4 class="m-0">🐶강아지 정보추가🐶</h4></a>
                			</div>
                		</div>
                	</c:otherwise>
                </c:choose>
                </div>
            </div>
        </div>
    </div>
 	
 	<div class="container rounded p-4 pt-5" id="bottomContainer">
        <div class="menu p-2">
            <div class="row m-0" style="height:100%">
                <div class="col-8 p-2">
                    <a href="${pageContext.request.contextPath}/history.planner">
                        <h5 class="title m-0">📆우리 동네 플래너📆</h5>
                    </a>
                </div>
                <div class="col-4 p-2">
                    <a href="${pageContext.request.contextPath}/list.message">
                        <h5 class="title m-0">💌쪽지함💌</h5>
                    </a>
                </div>
                
            </div>
            <div class="row m-0" style="height:100%">
            	<div class="col-4 p-2">
                 	<a href="${pageContext.request.contextPath}/petBoardList.pet?cpage=1&search=id&search2=&keyword=${login.id}">
                     	<h5 class="title m-0">🐾내가 올린 펫시터🐾</h5>
                  	</a> 
              	</div>
            	<div class="col-4 p-2">
	                 <a href="${pageContext.request.contextPath}/galList.gal?cpage=1&category=writer&keyword=${login.id}">
	                     <h5 class="title m-0">💟내가 올린 사진💟</h5>
	                  </a> 
				</div>
                <div class="col-4 p-2">
                    <a href="${pageContext.request.contextPath}/listProc.fb?cpage=1&category=writer&keyword=${login.id}">
                       <h5 class="title m-0">📋내가 올린 게시글📋</h5>
                  	</a>
	            </div>
            </div>
          <div class="row m-0" style="height:100%">   
              <div class="col-4 p-2">
                 <a href="${pageContext.request.contextPath}/doginfomodify.dog">
                     <h5 class="title m-0">🐶강아지 정보수정🐶</h5>
                  </a>
              </div>
                <div class="col-4 p-2">
                   <a href="${pageContext.request.contextPath}/modify.mem">
                         <h5 class="title m-0">😊내 정보수정😊</h5>
                    </a>
                </div>
                <div class="col-4 p-2">
                      <a href="${pageContext.request.contextPath}/logout.mem" id="signout">
                        <h5 class="title m-0">😭회원 탈퇴😭</h5>
                    </a>
                </div>
            </div>
        </div>
    </div> 
</body>
</html>