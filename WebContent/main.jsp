<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Team_Project2_main</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>

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
</style>
<script>
$(function() {
	$.ajax({
        url:"mainGallery.gal?cpage=1",
        type:"get",
        dataType:"json"
       }).done(function(resp){
    	   $("#galImg1").attr("src", "files/"+resp[0].thumbPath);
    	   $("#galImg2").attr("src", "files/"+resp[1].thumbPath);
    	   $("#galImg3").attr("src", "files/"+resp[2].thumbPath);
    	   
    	   $("#writeDate1").text(resp[0].write_date);
    	   $("#writeDate2").text(resp[1].write_date);
    	   $("#writeDate3").text(resp[2].write_date);
    	   
    	   $("#writer1").text(resp[0].writer);
    	   $("#writer2").text(resp[1].writer);
    	   $("#writer3").text(resp[2].writer);
    	   
    	   $("#galTitle1").text(resp[0].title);
    	   $("#galTitle2").text(resp[1].title);
    	   $("#galTitle3").text(resp[2].title);
     })
     
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
<link href="https://fonts.googleapis.com/css?family=Montserrat:200,300,400,500,600,700,800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/animate.css">
<link rel="stylesheet" href="css/owl.carousel.min.css">
<link rel="stylesheet" href="css/owl.theme.default.min.css">
<link rel="stylesheet" href="css/magnific-popup.css">
<link rel="stylesheet" href="css/bootstrap-datepicker.css">
<link rel="stylesheet" href="css/jquery.timepicker.css">
<link rel="stylesheet" href="css/flaticon.css">
<link rel="stylesheet" href="css/style.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Gugi&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Brush+Script&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Sunflower:wght@300&display=swap" rel="stylesheet">

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


   <!-- 친구들과 함께 산책해보세요! -->
   <div class="hero-wrap js-fullheight"
      style="background-image: url('images/bg_1.jpg');"
      data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
         <div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center" data-scrollax-parent="true">
            <div class="col-md-11 ftco-animate text-center">
               <h1 class="mb-4" style="font-weight: 200px; font-family: 'Sunflower';">
                  <a href="Signup/signupView.jsp" style="color: white;">친구들과 함께 산책해 보세요!</a>
               </h1>
               <!-- <p><a href="#" class="btn btn-primary mr-md-4 py-3 px-4" style="font-size: large;font-weight: 100px; margin-top:50px;">둘러보기<span class="ion-ios-arrow-forward"></span></a></p> -->
            </div>
         </div>
      </div>
   </div>

   <!--산책 / 펫시터 / 갤러리  -->
   <section class="ftco-section bg-light ftco-no-pt ftco-intro">
      <div class="container">
         <div class="row">
            <div class="col-md-4 d-flex align-self-stretch px-4 ftco-animate">
               <div class="d-block services text-center">
                  <div class="icon d-flex align-items-center justify-content-center">
                     <span class="flaticon-blind"></span>
                  </div>
                  <div class="media-body">
                     <h3 class="heading">산책 장소</h3>
                     <p>주변, 혹은 다른 지역의 산책장소 찾기 어려우셨죠? 여러 지역의 산책장소를 둘러보고 마음에 드는
                        산책장소를 선택하고 일정을 추가할 수 있습니다.</p>
                     <a href="${pageContext.request.contextPath}/getCourse.cos?course_area=종로구" class="btn-custom d-flex align-items-center justify-content-center">
                     	<span class="fa fa-chevron-right"></span><i class="sr-only">Read more</i>
                     </a>
                  </div>
               </div>
            </div>
            <div class="col-md-4 d-flex align-self-stretch px-4 ftco-animate">
               <div class="d-block services text-center">
                  <div class="icon d-flex align-items-center justify-content-center">
                     <span class="flaticon-dog-eating"></span>
                  </div>
                  <div class="media-body">
                     <h3 class="heading">펫시터</h3>
                     <p>여러분의 강아지를 믿고 맡길 수 있는 분에게 잠시 위탁해보세요! 강아지에게 새로운 경험을 선물해 주세요!</p>
                     <c:choose>
                     <c:when test="${login.id==null}">
                     <a href="javascript:;" id="read_more_pet" class="btn-custom d-flex align-items-center justify-content-center">
                     	<span class="fa fa-chevron-right"></span><i class="sr-only">Read more</i>
                     </a>
                     </c:when>
                     <c:otherwise>
                     <a href="${pageContext.request.contextPath}/petBoardList.pet?cpage=1" class="btn-custom d-flex align-items-center justify-content-center">
                     	<span class="fa fa-chevron-right"></span><i class="sr-only">Read more</i>
                     </a>
                     </c:otherwise>
                     </c:choose>
                  </div>
               </div>
            </div>
            
            <div class="col-md-4 d-flex align-self-stretch px-4 ftco-animate">
               <div class="d-block services text-center">
                  <div class="icon d-flex align-items-center justify-content-center">
                     <span class="flaticon-pawprint-1"></span>
                  </div>
                  <div class="media-body">
                     <h3 class="heading">갤러리</h3>
                     <p>내가 자랑하고 싶은 강아지와의 사진을 공유하고,다른 귀여운 강아지들의 활동모습도 구경해 보세요!</p>
                     <c:choose>
                     <c:when test="${login.id==null}">
                     <a href="javascript:;" id="read_more_pet" class="btn-custom d-flex align-items-center justify-content-center">
                     	<span class="fa fa-chevron-right"></span><i class="sr-only">Read more</i>
                     </a>
                     </c:when>
                     <c:otherwise>
                     <a href="galList.gal?cpage=1" class="btn-custom d-flex align-items-center justify-content-center">
                     	<span class="fa fa-chevron-right"></span><i class="sr-only">Read more</i>
                     </a>
                     </c:otherwise>
                     </c:choose>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </section>

   <!--사이트 장점  -->
   <section class="ftco-section ftco-no-pt ftco-no-pb">
      <div class="container">
         <div class="row d-flex no-gutters">
            <div class="col-md-5 d-flex">
               <div
                  class="img img-video d-flex align-self-stretch align-items-center justify-content-center justify-content-md-center mb-4 mb-sm-0"
                  style="background-image: url(images/about-1.jpg);"></div>
            </div>
            <div class="col-md-7 pl-md-5 py-md-5">
               <div class="heading-section pt-md-5">
                  <h2 class="mb-4">우리 사이트의 장점은?</h2>
               </div>
               <div class="row">
                  <div class="col-md-6 services-2 w-100 d-flex">
                     <div
                        class="icon d-flex align-items-center justify-content-center">
                        <span class="flaticon-stethoscope"></span>
                     </div>
                     <div class="text pl-3">
                        <h4>산책장소</h4>
                        <p>다양한 장소의 산책장소를 검색해보세요.</p>
                     </div>
                  </div>
                  <div class="col-md-6 services-2 w-100 d-flex">
                     <div
                        class="icon d-flex align-items-center justify-content-center">
                        <span class="flaticon-customer-service"></span>
                     </div>
                     <div class="text pl-3">
                        <h4>반려인들 소통의 장</h4>
                        <p>산책동행을 구하고, 다양한 정보를 나눠보세요.</p>
                     </div>
                  </div>
                  <div class="col-md-6 services-2 w-100 d-flex">
                     <div class="icon d-flex align-items-center justify-content-center">
                        <span class="flaticon-emergency-call"></span>
                     </div>
                     <div class="text pl-3">
                        <h4>선별된 사용자들</h4>
                        <p>모든 사용자들을 믿고 이용하실 수 있습니다.</p>
                     </div>
                  </div>
                  <div class="col-md-6 services-2 w-100 d-flex">
                     <div
                        class="icon d-flex align-items-center justify-content-center">
                        <span class="flaticon-veterinarian"></span>
                     </div>
                     <div class="text pl-3">
                        <h4>일정 관리</h4>
                        <p>우리동네 반려인들의 산책장소와 일정을 공유해보세요!</p>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </section>

   <!-- 산책장소 -->
   <div class="hero-wrap js-fullheight" id="backGif"
      style="background: linear-gradient(to bottom, rgba(92, 77, 66, 0.8) 0%, rgba(92, 77, 66, 0.8) 100%), url('images/dogWalk.gif');"
      data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
         <div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center"
            data-scrollax-parent="true">
            <div class="col-md-11 ftco-animate text-center">
               <h1 class="mb-4" style="font-size: 40px; font-family: 'Sunflower';">
                  산책장소!<br> 정하기 어려우셨다구요?<br>추천코스를 이용해보세요!
               </h1>
               <p>
                  <a href="${pageContext.request.contextPath}/getCourse.cos?course_area=종로구" class="btn btn-primary mr-md-4 py-3 px-4" style="font-size: large;">
                  둘러보기<span class="ion-ios-arrow-forward"></span>
                  </a>
               </p>
            </div>
         </div>
      </div>
   </div>

   <!-- 우리동네 플래너 -->  <!-- 청아님 여기에 원하시는거 작성하시면 될 것 같습니다!  -->
   <section class="ftco-section" style="overflow:hidden;">
      <div class="container">
         <div class="row justify-content-center pb-5 mb-3">
            <div class="col-md-7 heading-section text-center ftco-animate">
               <h2>우리동네  walking  플래너</h2>
               <hr style="height: 0.2rem; max-width:250px; margin:15px auto; background-color: #146c43; opacity: 1;">
            </div>
         </div>

         <div class="row m-0 mb-5">
         	<img src="walkplanner.JPG" class="col-8 p-0">
         	<div class="col-4 p-3 pt-4">
         		<p style="color:black;"><strong>
         			우리동네 산책일정을 한눈에 확인 할 수 있어요!
         		</strong></p>	
         		<p style="color:#146c43;"><strong>내 일정은 green!</strong></p>
         		<p style="color:tomato;">
         			<strong>사람이나 강아지를 보고 짖고, 법정 지정 맹견인<br>조금 같이 산책하기 어려운 강아지들의 일정은 red!
         			</strong>
         		</p>
         		<p style="color:royalblue;"><strong>우리동네 다른 반려인들의 일정은 blue!</strong></p>
				<p style="color:black;" class="mb-5"><strong>내 일정을 확인하고, 수정, 삭제할 수 있고<br>
				 오늘 +4일의 날씨와 미세먼지농도까지 확인 할 수 있는<br>
				 Smart한 나만의 산책 Planner를 경험해 보세요😍</strong></p>
				 <p class="mb-0"><strong>✨지도를 통해서 산책 장소 위치까지 확인 가능✨</strong></p>
         	</div>
         </div>	
         <div class="row m-0 pt-5" style="border-top:2px solid #146c43;">
         	<div class="col-3 p-2 pt-4">
         		<p><strong>
         			산책 히스토리🐾를 통해서<br>
         			같이 산책했던 반려인이나 펫시터분들의<br>
         			일정과 정보를 확인 할 수 있습니다!

         		</strong>
         		</p>
         		<p style="color:black;" class="mb-0"><strong>
         			맘에 들었던 분들에게<br>
         			또 같이 산책일정을 잡거나<br>
         			다시 펫시터를 해달라고 쪽지를 보내<br>
         			일정을 잡을 수 있습니다💌
         		</strong></p>
         	</div>
         	<img src="history.JPG" class="col-9 p-0">
		</div>
	</div>
   </section>
       
   <!--갤러리  -->
   <section class="ftco-section bg-light">
      <div class="container">
         <div class="row justify-content-center pb-5 mb-3">
            <div class="col-md-7 heading-section text-center ftco-animate">
               <h2 style="border: 1px;">갤 러 리</h2>
               <hr style="height: 0.2rem; max-width: 3.25rem; margin: 1.5rem auto; background-color: #146c43; opacity: 1;">
            </div>
         </div>
               <div class="row d-flex">
                     <div class="col-md-4 d-flex ftco-animate">
                        <div class="blog-entry align-self-stretch"
                           style="width: 350px; height: 500px;">
                           <a href="${pageContext.request.contextPath}/galList.gal?cpage=1" class="block-20 rounded"> <img
                              src="" style="width: 100%; height: 100%;" id="galImg1">
                           </a>
                           <div class="text p-4">
                              <div class="meta mb-2">
                                 <div id="writeDate1">
                                    <a href="#" ></a>
                                 </div>
                              </div>
                              <div class="meta mb-2">
                                 <div id="writer1">
                                    <a href="${pageContext.request.contextPath}/galList.gal?cpage=1"> </a>
                                 </div>

                              </div>
                              <h3 class="heading" id="galTitle1">
                                 <a href="${pageContext.request.contextPath}/galList.gal?cpage=1" style="font-size: 25px;"></a>
                              </h3>
                           </div>
                        </div>
                     </div>
                  
               

                  
                     <div class="col-md-4 d-flex ftco-animate">
                        <div class="blog-entry align-self-stretch"
                           style="width: 350px; height: 500px;">
                           <a href="${pageContext.request.contextPath}/galList.gal?cpage=1" class="block-20 rounded"> <img
                              src="" style="width: 100%; height: 100%;" id="galImg2">
                           </a>
                           <div class="text p-4">
                              <div class="meta mb-2">
                                 <div id="writeDate2">
                                    <a href="#" ></a>
                                 </div>


                              </div>
                              <div class="meta mb-2">
                                 <div id="writer2">
                                    <a href="${pageContext.request.contextPath}/galList.gal?cpage=1"> </a>
                                 </div>

                              </div>
                              <h3 class="heading" id="galTitle2">
                                 <a href="${pageContext.request.contextPath}/galList.gal?cpage=1" style="font-size: 25px;"></a>
                              </h3>
                           </div>
                        </div>
                     </div>
      
                     <div class="col-md-4 d-flex ftco-animate">
                        <div class="blog-entry align-self-stretch"
                           style="width: 350px; height: 500px;">
                           <a href="${pageContext.request.contextPath}/galList.gal?cpage=1" class="block-20 rounded"> <img
                              src="" style="width: 100%; height: 100%;" id="galImg3">
                           </a>
                           <div class="text p-4">
                              <div class="meta mb-2">
                                 <div id="writeDate3">
                                    <a href="#" ></a>
                                 </div>


                              </div>
                              <div class="meta mb-2">
                                 <div id="writer3">
                                    <a href="${pageContext.request.contextPath}/galList.gal?cpage=1"> </a>
                                 </div>

                              </div>
                              <h3 class="heading" id="galTitle3">
                                 <a href="${pageContext.request.contextPath}/galList.gal?cpage=1" style="font-size: 25px;"></a>
                              </h3>
                           </div>
                        </div>
                     </div>
                  
               </div>
      </div>
   </section>

<!--문의하기  -->
   <section
      class="ftco-appointment ftco-section ftco-no-pt ftco-no-pb img"
      style="background-image: url(images/bg_5.png);">
      <div class="overlay"></div>
      <div class="container">
         <div class="row d-md-flex justify-content-end">
            <div class="col-md-12 col-lg-6 half p-3 py-5 pl-lg-5 ftco-animate">
               <h2 class="mb-4">문의하기</h2>
               <form action="${pageContext.request.contextPath}/questionWrite.ad" class="appointment">
                  <div class="row">
                     <div class="col-md-12">
                        <div class="form-group">
                           <div class="form-field">
                              <div class="select-wrap">
                                 <div class="icon">
                                    <span class="fa fa-chevron-down"></span>
                                 </div>
                                 <select name="type" id="" class="form-control"required>
                                    <option value="산책장소">산책장소</option>
                                    <option value="펫시터">펫시터</option>
                                    <option value="갤러리">갤러리</option>
                                    <option value="플래너">플래너</option>
                                    <option value="기타">기타</option>
                                 </select>
                              </div>
                           </div>
                        </div>
                     </div>
                     <div class="col-md-6">
                        <div class="form-group">
                           <input type="text" name="name" class="form-control" placeholder="이름*" required>
                        </div>
                     </div>
                     <div class="col-md-6">
                        <div class="form-group">
                           <input type="text" name="email" class="form-control" placeholder="메일*" required>
                        </div>
                     </div>


                     <div class="col-md-12">
                        <div class="form-group">
                           <textarea name="contents" id="" cols="30" rows="7" class="form-control"
                              placeholder="내용*" required></textarea>
                        </div>
                     </div>
                     <div class="col-md-12">
                        <div class="form-group">
                           <input type="submit" value="문의 보내기"
                              class="btn btn-primary py-3 px-4">
                        </div>
                     </div>
                  </div>
               </form>
            </div>
         </div>
      </div>
   </section>


   <!-- 하단 네비  -->
   <footer class="footer">
      <div class="container">
         <div class="row">
            <div class="col-md-6 col-lg-3 mb-4 mb-md-0">
               <h2 class="footer-heading">WAKI TOKI</h2>
               <p>
                  Walk with dog Talk with dog의 줄임말로 반려견과 함께 호흡하는 즐거운 시간을 나타내는 말입니다.<br>
                  <br> 소중한 반려견과 편안한 시간을 갖도록 도움을 주는 웹 플랫폼입니다.<br> <br>
                  산책친구찾기 기능부터 산책장소 추천 펫시터모집까지 다양한 편의기능을 지원합니다.
               </p>
               <ul class="ftco-footer-social p-0">
                  <li class="ftco-animate"><a href="https://twitter.com/" data-toggle="tooltip"
                     data-placement="top" title="Twitter"><span
                        class="fa fa-twitter"></span></a></li>
                  <li class="ftco-animate"><a href="https://www.facebook.com/" data-toggle="tooltip"
                     data-placement="top" title="Facebook"><span
                        class="fa fa-facebook"></span></a></li>
                  <li class="ftco-animate"><a href="https://www.instagram.com/" data-toggle="tooltip"
                     data-placement="top" title="Instagram"><span
                        class="fa fa-instagram"></span></a></li>
               </ul>
            </div>
            <div class="col-md-6 col-lg-3 mb-4 mb-md-0">
               <h2 class="footer-heading">최신 갤러리</h2>
               <div class="block-21 mb-4 d-flex">
                  <a class="img mr-4 rounded"
                     style="background-image: url(images/image_1.jpg);"></a>
                  <div class="text">
                     <h3 class="heading">
                        <a href="galList.gal?cpage=1">강아지와 함께 산책</a>
                     </h3>
                     <div class="meta">
                        <div>
                           <a href="galList.gal?cpage=1"><span class="icon-calendar"></span>2021년 6월 7일</a>
                        </div>

                     </div>
                  </div>
               </div>
               <div class="block-21 mb-4 d-flex">
                  <a class="img mr-4 rounded"
                     style="background-image: url(images/image_2.jpg);"></a>
                  <div class="text">
                     <h3 class="heading">
                        <a href="galList.gal?cpage=1">강아지 목욕시키기</a>
                     </h3>
                     <div class="meta">
                        <div>
                           <a href="galList.gal?cpage=1"><span class="icon-calendar"></span> 2021년 5월
                              20일</a>
                        </div>

                     </div>
                  </div>
               </div>
            </div>
            <div class="col-md-6 col-lg-3 pl-lg-5 mb-4 mb-md-0">
               <h2 class="footer-heading">빠른 메뉴</h2>
               <ul class="list-unstyled">
                  <li><a href="forGallery.gal?cpage=1" class="py-2 d-block">홈</a></li>
                  <li><a href="${pageContext.request.contextPath}/getCourse.cos?course_area=종로구" class="py-2 d-block">산책장소</a></li>
                  <c:choose>
                  <c:when test="${login.id==null}">
                  <li><a href="javascript:;" class="petsitter py-2 d-block">펫시터</a></li>
                  </c:when>
                  <c:otherwise>
                  <li><a href="${pageContext.request.contextPath}/petBoardList.pet?cpage=1" class="py-2 d-block">펫시터</a></li>
                  </c:otherwise>
                  </c:choose>
                  <li><a href="galList.gal?cpage=1" class="py-2 d-block">갤러리</a></li>
                  <li><a href="${pageContext.request.contextPath}/listProc.fb?cpage=1" class="py-2 d-block">자유게시판</a></li>
                  
               </ul>
            </div>
            <div class="col-md-6 col-lg-3 mb-4 mb-md-0">
               <h2 class="footer-heading">궁금한점이 있으신가요?</h2>
               <div class="block-23 mb-3">
                  <ul>
                     <li><span class="icon fa fa-map"></span><span class="text">
                           서울특별시 중구 남대문로 120 대일빌딩 3층 E Class</span></li>
                     <li><a href="#"><span class="icon fa fa-phone"></span><span
                           class="text">02-1544-9970</span></a></li>
                     <li><a href="#"><span class="icon fa fa-paper-plane"></span><span
                           class="text">info@WAKI_TOKI.com</span></a></li>
                  </ul>
               </div>
            </div>
         </div>
         <div class="row mt-5">
            <div class="col-md-12 text-center">

               <p class="copyright">
                  <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                  Copyright &copy;
                  <script>
                     document.write(new Date().getFullYear());
                  </script>
                   All rights reserved WAKI_TOKI 
                  <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
               </p>
            </div>
         </div>
      </div>
   </footer>

   <!-- loader -->
   <div id="ftco-loader" class="show fullscreen">
      <svg class="circular" width="48px" height="48px">
         <circle class="path-bg" cx="24" cy="24" r="22" fill="none"
            stroke-width="4" stroke="#eeeeee" />
         <circle class="path" cx="24" cy="24" r="22" fill="none"
            stroke-width="4" stroke-miterlimit="10" stroke="#F96D00" /></svg>
   </div>

   <script src="js/jquery.min.js"></script>
   <script src="js/jquery-migrate-3.0.1.min.js"></script>
   <script src="js/popper.min.js"></script>
   <script src="js/bootstrap.min.js"></script>
   <script src="js/jquery.easing.1.3.js"></script>
   <script src="js/jquery.waypoints.min.js"></script>
   <script src="js/jquery.stellar.min.js"></script>
   <script src="js/jquery.animateNumber.min.js"></script>
   <script src="js/bootstrap-datepicker.js"></script>
   <script src="js/jquery.timepicker.min.js"></script>
   <script src="js/owl.carousel.min.js"></script>
   <script src="js/jquery.magnific-popup.min.js"></script>
   <script src="js/scrollax.min.js"></script>
   <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
   <script src="js/google-map.js"></script>
   <script src="js/main.js"></script>

</body>
</html>