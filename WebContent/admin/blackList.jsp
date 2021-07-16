<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자_블랙리스트</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Gugi&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Brush+Script&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Sunflower:wght@300&display=swap" rel="stylesheet">

<style>

* {font-family: 'Sunflower'; box-sizing: border-box;}
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

/* 블랙리스트 */
body {background-color: white; border-color: black;}
.row div{text-align:center;}
.container {box-sizing: border-box;}

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
		
		
		//삭제버튼
      $(".block_reg").on("click",function() {
               $(".block_id").val($(this).parent().siblings(".mem_id").text());
               $(".block_name").val($(this).parent().siblings(".mem_name").text());
               $(".block_email").val($(this).parent().siblings(".mem_email").text());
               $(".block_contact").val($(this).parent().siblings(".mem_contact").text());
               $("#block_reg_form").submit();
               
            })
            
            
            /* $("#blacklistshowup").on("click",function(){
               var box1 = document.getElementById("BlackListView");
               var box2 = document.getElementById("BlackListView2");
               
               
            if(box1.style.display=="none"||box2.style.display=="none"){   
               $("#BlackListView").css("display","block");
               $("#BlackListView2").css("display","block");
            }
            else if(box1.style.display=="block"||box2.style.display=="block"){
               $("#BlackListView").css("display","none");
               $("#BlackListView2").css("display","none"); 
            }
		}) */
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
	

<!-- 블랙리스트 -->
   <div class="container-lg border p-0" id="BlackListView"
      style="/* display:none; */width: 1600px; height: 500px; margin-left: 250px; margin-top: 50px; box-sizing: border-box ;overflow-x:auto; overflow-y:scroll;">
      <h3 style="text-align: center">가입 회원 정보 조회</h3>

      <div class="row m-0" style="box-sizing: border-box; over-flow-y:scroll;">

         <div class="border col-lg-1 col-xl-1">아이디</div>
         <div class="border col-lg-2 col-xl-2">이메일</div>
         <div class="border col-lg-1 col-xl-1">이름</div>
         <div class="border col-lg-1 col-xl-1">연령대</div>
         <div class="border col-lg-2 col-xl-2">연락처</div>
         <div class="border col-lg-1 col-xl-1">가입날짜</div>
         <div class="border col-lg-3 col-xl-2">강제탈퇴사유설정</div>
         <div class="border col-lg-2 col-xl-2">강제 탈퇴</div>

      </div>

      <c:forEach var="mem" items="${Member}">
         <form action="${pageContext.request.contextPath}/block_member.mem"
            method="post" id="block_reg_form">
            <div class="row m-0" style="box-sizing: border-box">
               <div class="border col-lg-1 col-xl-1 mem_id">${mem.id}</div>
               <div class="border col-lg-2 col-xl-2 mem_email">${mem.email}</div>
               <div class="border col-lg-1 col-xl-1 mem_name">${mem.person_name}</div>
               <div class="border col-lg-1 col-xl-1">${mem.person_age}</div>
               <div class="border col-lg-2 col-xl-2 mem_contact">${mem.contact}</div>
               <div class="border col-lg-1 col-xl-1">${mem.reg_date}</div>
               <div class="border col-lg-3 col-xl-2">
                  <select name="block_reason">
                     <option value="타 회원 비방 및 욕설">타 회원 비방 및 욕설</option>
                     <option value="불법적인 경로로 가입">불법적인 경로로 가입</option>
                     <option value="불법적인/선정적인 게시물 게시">불법적/선정적인 게시물 게시</option>
                  </select>
               </div>
               <div class="border col-lg-2 col-xl-2">
                  <input type="button" value="블랙리스트로 등록" class="block_reg">
               </div>
               <input type=hidden name="id" class="block_id" value=""> <input
                  type=hidden name="name" class="block_name" value=""> <input
                  type=hidden name="contact" class="block_contact" value="">
               <input type=hidden name="email" class="block_email" value="">
            </div>
         </form>
      </c:forEach>
   </div>

   <div class="container-lg border p-0" id="BlackListView2"
      style="/* display:none; */ text-align:center; width: 1600px; height: 500px; margin-left: 250px; margin-top: 170px; box-sizing: border-box overflow-x:auto; overflow-y:scroll;">
      <h3 style="text-align: center">블랙리스트 회원 조회</h3>

      <div class="row m-0" style="box-sizing: border-box; margin-left:550px; text-align:center'">
         <div class="border col-lg-1 col-xl-1">번호</div>
         <div class="border col-lg-1 col-xl-1">아이디</div>
         <div class="border col-lg-2 col-xl-2">이메일</div>
         <div class="border col-lg-1 col-xl-1">이름</div>
         <div class="border col-lg-2 col-xl-2">연락처</div>
         <div class="border col-lg-3 col-xl-3">강제 탈퇴 사유</div>
         <div class="border col-lg-1 col-xl-2">강제 탈퇴 날짜</div>

      </div>

      <div class="row m-0" style="box-sizing: border-box; text-align:center; margin-left:550px; text-align:center">

         <c:forEach var="blocked" items="${BlackList}">
         
            <div class="border col-lg-1 col-xl-1">${blocked.seq}</div>
            <div class="border col-lg-1 col-xl-1">${blocked.id}</div>
            <div class="border col-lg-2 col-xl-2">${blocked.email}</div>
            <div class="border col-lg-1 col-xl-1">${blocked.name}</div>
            <div class="border col-lg-2 col-xl-2">${blocked.contact}</div>
            <div class="border col-lg-3 col-xl-3">${blocked.block_reason}</div>
            <div class="border col-lg-1 col-xl-2">${blocked.block_date}</div>

         </c:forEach>
      </div>
   </div>

</body>
</html>