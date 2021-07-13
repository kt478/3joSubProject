<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Gallery</title>
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    
    
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    
    
    <style>


    /*   #searchBox{width:200px;transition:all .5s ease; visibility: hidden;}
      #searchBox:focus{width:200px}
  
  
  
  	 .nav-search:hover{
    	cursor: pointer;
  	 } */
  
  
  *{
    font-family: 'Sunflower';
  }
  
  
  
  #navibar{
        background-color:white;
        text-align: center;
        line-height:98px;
        min-height:100px;
        height:auto;
        position:fixed;
        top:0px;left:0px;
        font-weight: 600;
        font-size: large;
        z-index: 1000 !important;
    }
      .navitext>a{color:black;}
      .navitext>a:link{text-decoration:none;}
      .navitext>a:hover{color: #52734D;}
      .navitext>a:visited{color: black;}
    .navitext:hover{border-bottom:3px solid #52734D;}
    #search{
        width:250px; height:41px;
        display: none;
    }
    #searchImg:active~#search{left:0px;}
   
   #searchImg:hover{
        cursor: pointer;
    }
    
    
    
    
    
    #rightArrow:hover{
    
    color:white;
    background-color:rgb(14, 194, 14)
    
    }
    #leftArrow:hover{
    
    color:white;
    background-color:rgb(14, 194, 14)
    
    }
    #bottomNumber:hover{
    
    color:white;
    background-color:rgb(14, 194, 14)
    
    
    }
	






  </style>



<script>
/* $(function(){
    $(".nav-search").on("click",function(){
      
      $("#searchBox").attr("style","visibility:visible");

    })
    $("#searchBox").keydown(function(key){
      if (key.keyCode == 13) {
                  location.href="http://www.naver.com";
              }
      

    })
    $("#searchBox").focusout(function(){
      
      $(this).attr("style","visibility:hidden");
      

    }) 

  })*/
    
  $(function(){
	  $("#searchImg").on("click",function(){
          $("#search").show("slow");
          $("#search").focus();
      });
      $("#search").on("blur",function(){
         $("#search").hide("slow");
      });  
      //네비바 검색창에서 검색기능
  	  $("#search").on("keyup",function(e){
  		 if(e.keyCode==13){
  			let search = $("#search").val();
  			location.href="${pageContext.request.contextPath}/search.cos?cpage=1&keyWord="+search;
  		 }
      })
      
      
    })    


 



</script>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
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
	
	<c:choose>

		<c:when test="${login.id==null}">
			<div class="container-fluid p-0" id="navibar">


				<div class="row m-0">
					<div class="col-12 col-lg-3 col-xl-2 p-0">
						<a href="beforeLogin.gal?cpage=1"><img src="project_logo.jpg"></a>
					</div>
					<div class="col-3 col-lg-2 col-xl-1 p-0 navitext">
						<a href="${pageContext.request.contextPath}/getCourse.cos?course_area=종로구">산책장소</a>
					</div>
					<div class="col-3 col-lg-2 col-xl-1 p-0 navitext">
						<a href= "javascript:;" id="petsitter">펫시터</a>
					</div>
					<div class="col-3 col-lg-2 col-xl-1 p-0 navitext">
						<a href="${pageContext.request.contextPath}/galList.gal?cpage=1">갤러리</a>
					</div>
					<div class="col-3 col-lg-3 col-xl-1 p-0 navitext">
						<a href="${pageContext.request.contextPath}/listProc.fb?cpage=1">자유게시판</a>
					</div>
					<div class="col-12 col-lg-4 col-xl-4 p-0">
						<img src="search.png" id="searchImg"> <input type="text"
							placeholder="원하는구,장소를 검색하세요." class="form-control me-2 ml-3"
							id="search">
					</div>
					<div class="col-6 col-lg-4 col-xl-1 p-0 navitext" id="mypage">
						<a href="Signup/signupView.jsp">회원가입</a>
					</div>
					<div class="col-6 col-lg-4 col-xl-1 p-0 navitext">
						<a href="Signup/login.jsp">로그인</a>
					</div>
				</div>

			</div>
		</c:when>


		<c:otherwise>
			<div class="container-fluid p-0" id="navibar">
				<div class="row m-0">
					<div class="col-12 col-lg-3 col-xl-2 p-0">
						<a href="main.jsp"><img src="project_logo.jpg"></a>
					</div>
					<div class="col-3 col-lg-2 col-xl-1 p-0 navitext">
						<a href="${pageContext.request.contextPath}/getCourse.cos?course_area=종로구">산책장소</a>
					</div>
					<div class="col-3 col-lg-2 col-xl-1 p-0 navitext">
						<a href="${pageContext.request.contextPath}/petBoardList.pet?cpage=1">펫시터</a>
					</div>
					<div class="col-3 col-lg-2 col-xl-1 p-0 navitext">
						<a href="${pageContext.request.contextPath}/galList.gal?cpage=1">갤러리</a>
					</div>
					<div class="col-3 col-lg-3 col-xl-1 p-0 navitext">
						<a href="${pageContext.request.contextPath}/listProc.fb?cpage=1">자유게시판</a>
					</div>
					<div class="col-12 col-lg-4 col-xl-4 p-0">
						<img src="search.png" id="searchImg"> <input type="text"
							placeholder="원하는구,장소를 검색하세요." class="form-control me-2 ml-3"
							id="search">
					</div>
					<div class="col-6 col-lg-4 col-xl-1 p-0 navitext" id="mypage">
						<a href="Mypage.mem">마이페이지</a>
					</div>
					<div class="col-6 col-lg-4 col-xl-1 p-0 navitext">
						<a href="logout.mem">로그아웃</a>
					</div>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
	
	  
	  
    <!-- END nav -->
    <section class="hero-wrap hero-wrap-2" style="background-image: url('images/bg_2.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-end">
          <div class="col-md-9 ftco-animate pb-5">
          	<p class="breadcrumbs mb-2"><span class="mr-2"><a href="index.html">홈 <i class="ion-ios-arrow-forward"></i></a></span> <span>Blog <i class="ion-ios-arrow-forward"></i></span></p>
            <h1 class="mb-0 bread">갤러리</h1>
          </div>
        </div>
      </div>
    </section>



     <section class="ftco-section bg-light">
      <div class="container">
      
      
      <div class="row d-flex">
      
      
        <c:forEach var="i" items="${list }"> 
          <div class="col-md-4 d-flex ftco-animate">
            <div class="blog-entry align-self-stretch" style="width: 350px; height: 500px;">
              <a href="galDetail.gal?seq=${i.seq }" class="block-20 rounded" >
                
      				
      				<img src="files/${i.thumbPath}" style="width:100%;height:100%;">
       
     			 
                 
            
              </a>
              <div class="text p-4"> 
              	<div class="meta mb-2">
                  <div><a href="#">작성일: ${i.write_date } </a></div>
                 
                </div>
                <div class="meta mb-2">
                  <div><a href="#">글쓴이 : ${i.writer } </a></div>
                 
                </div>
                <br>
                <h3 class="heading"><a href="#" style="font-size:25px;">${i.title }</a></h3>
              </div>
            </div>
          </div>
         </c:forEach> 
       </div> 
       
        
        <div class="row mt-5">
          <div class="col text-center">
          
          <c:choose>
       		<c:when test="${login.id==null}">
       		</c:when>
       		<c:otherwise>
       		<div ><a href="Gallery/gallery_write.jsp" class="btn btn-primary">글쓰기</a></div>
       		</c:otherwise>
          </c:choose>
          	
          		<div id="inputForm" style="border:1px solid green; width:290px; border-radius:5px; margin:auto; margin-top:20px;">
              		<form action="galList.gal" method="get" id="searchForm">
            			<input type=hidden name=cpage value="1">
            			<select id="searchCondition" name="category" style="font-size:large; height:30px; border:none; background-color:#f8f9fd;">
							<option value="title">제목</option>
							<option value="writer">작성자</option>
							
						</select>
						<input id="keyword" name="keyword" type="text" placeholder="검색어를 입력하세요." style="border:none;background-color:#f8f9fd;">
						<a class=btn href="#" onclick="jQuery('#searchForm').submit();" style="padding-left:5px;"><img src="search.png" style="width:17px;height:17px;"></a>
						
						
            			
           			</form>
            	</div>
            
            
            
            <div class="block-27" style="margin-top:50px">
             <ul>
             <c:choose>
             <c:when test="${category==null || keyword==null }">
           
              <c:forEach var="i" items="${navi}" varStatus="s">
          	  		<c:choose>
          	  			<c:when test="${i == '>' }">
          	  		
          	  				<li><a href="${pageContext.request.contextPath}/galList.gal?cpage=${navi[s.index-1]+1}" id="rightArrow"> ${i} </a></li>
          	  			 
          	  			</c:when>
          	  			<c:when test="${i == '<' }">
          	  		
          	  				<li><a href="${pageContext.request.contextPath}/galList.gal?cpage=${navi[s.index+1]-1}" id="leftArrow"> ${i} </a></li>
          	  			
          	  			</c:when>
          	  		
          	  			<c:otherwise>
          	  				<c:choose>
          	  					<c:when test="${i==cpage}">
          	  						<li><a href="${pageContext.request.contextPath}/galList.gal?cpage=${i}" id="bottomNumber" style="color:white;background-color:rgb(14, 194, 14)"> ${cpage} </a></li>
          	  					</c:when>
          	  					<c:otherwise>
          	  						<li><a href="${pageContext.request.contextPath}/galList.gal?cpage=${i}" id="bottomNumber"> ${i} </a></li>
          	  					</c:otherwise>
          	  				</c:choose>
          	  			</c:otherwise>
          	  		</c:choose>
          	  		</c:forEach>
          	  	</c:when>
          	  	<c:otherwise>
          	  	
              <c:forEach var="i" items="${navi}" varStatus="s">
          	  		<c:choose>
          	  			<c:when test="${i == '>' }">
          	  		
          	  				<li><a href="${pageContext.request.contextPath}/galList.gal?cpage=${navi[s.index-1]+1}&category=${category}&keyword=${keyword}" id="rightArrow"> ${i} </a></li>
          	  			 
          	  			</c:when>
          	  			<c:when test="${i == '<' }">
          	  		
          	  				<li><a href="${pageContext.request.contextPath}/galList.gal?cpage=${navi[s.index+1]-1}&category=${category}&keyword=${keyword}" id="leftArrow"> ${i} </a></li>
          	  			
          	  			</c:when>
          	  		
          	  			<c:otherwise>
          	  				<c:choose>
          	  					<c:when test="${i==cpage}">
          	  						<li><a href="${pageContext.request.contextPath}/galList.gal?cpage=${i}&category=${category}&keyword=${keyword}" id="bottomNumber" style="color:white;background-color:rgb(14, 194, 14)"> ${cpage} </a></li>
          	  					</c:when>
          	  					<c:otherwise>
          	  						<li><a href="${pageContext.request.contextPath}/galList.gal?cpage=${i}&category=${category}&keyword=${keyword}" id="bottomNumber"> ${i} </a></li>
          	  					</c:otherwise>
          	  				</c:choose>
          	  			</c:otherwise>
          	  		</c:choose>
          	  		</c:forEach>
          	  	
          	  	
          	  	
          	  	</c:otherwise>
          	  	
          	  	
          	  	</c:choose>
           		 
           		 </ul>
            </div>
          </div>
        </div>
        
        
      </div>
    </section>

    <footer class="footer">
			<div class="container">
				<div class="row">
					<div class="col-md-6 col-lg-3 mb-4 mb-md-0">
						<h2 class="footer-heading">WAKI TOKI</h2>
						<p>Walk with dog Talk with dog의 줄임말로
							반려견과 함께 호흡하는 즐거운 시간을 나타내는 말입니다.<br><br>
							
							소중한 반려견과 편안한 시간을 갖도록 도움을 주는 웹 플랫폼입니다.<br><br>
							산책친구찾기 기능부터 산책장소 추천
							펫시터모집까지 다양한 편의기능을 지원합니다.</p>
						<ul class="ftco-footer-social p-0">
              <li class="ftco-animate"><a href="#" data-toggle="tooltip" data-placement="top" title="Twitter"><span class="fa fa-twitter"></span></a></li>
              <li class="ftco-animate"><a href="#" data-toggle="tooltip" data-placement="top" title="Facebook"><span class="fa fa-facebook"></span></a></li>
              <li class="ftco-animate"><a href="#" data-toggle="tooltip" data-placement="top" title="Instagram"><span class="fa fa-instagram"></span></a></li>
            </ul>
					</div>
					<div class="col-md-6 col-lg-3 mb-4 mb-md-0">
						<h2 class="footer-heading">최신 갤러리</h2>
						<div class="block-21 mb-4 d-flex">
              <a class="img mr-4 rounded" style="background-image: url(images/image_1.jpg);"></a>
              <div class="text">
                <h3 class="heading"><a href="#">강아지와 함께 산책</a></h3>
                <div class="meta">
                  <div><a href="#"><span class="icon-calendar"></span>2021년 6월 7일</a></div>
                
                </div>
              </div>
            </div>
            <div class="block-21 mb-4 d-flex">
              <a class="img mr-4 rounded" style="background-image: url(images/image_2.jpg);"></a>
              <div class="text">
                <h3 class="heading"><a href="#">강아지 목욕시키기</a></h3>
                <div class="meta">
                  <div><a href="#"><span class="icon-calendar"></span> 2021년 5월 20일</a></div>
                 
                </div>
              </div>
            </div>
					</div>
					<div class="col-md-6 col-lg-3 pl-lg-5 mb-4 mb-md-0">
						<h2 class="footer-heading">빠른 메뉴</h2>
						<ul class="list-unstyled">
              <li><a href="#" class="py-2 d-block">홈</a></li>
              <li><a href="#" class="py-2 d-block">산책</a></li>
              <li><a href="#" class="py-2 d-block">펫시터</a></li>
              <li><a href="#" class="py-2 d-block">플레너</a></li>
              <li><a href="#" class="py-2 d-block">갤러리</a></li>
              <li><a href="#" class="py-2 d-block">문의하기</a></li>
            </ul>
					</div>
					<div class="col-md-6 col-lg-3 mb-4 mb-md-0">
						<h2 class="footer-heading">궁금한점이 있으신가요?</h2>
						<div class="block-23 mb-3">
              <ul>
                <li><span class="icon fa fa-map"></span><span class="text">203 Fake St. Mountain View, San Francisco, California, USA</span></li>
                <li><a href="#"><span class="icon fa fa-phone"></span><span class="text">+2 392 3929 210</span></a></li>
                <li><a href="#"><span class="icon fa fa-paper-plane"></span><span class="text">info@yourdomain.com</span></a></li>
              </ul>
            </div>
					</div>
				</div>
				<div class="row mt-5">
          <div class="col-md-12 text-center">

            <p class="copyright"><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
  Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib.com</a>
  <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
          </div>
        </div>
			</div>
		</footer>

    
  

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>


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