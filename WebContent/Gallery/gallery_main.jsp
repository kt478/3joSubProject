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
    
    
    
    <style>

  
  
  *{
    font-family: 'Sunflower';
  }
  
  
  
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





  </style>



<script>

    
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
    <section class="hero-wrap hero-wrap-2" style="background-image: url('images/bg_2.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-end">
          <div class="col-md-9 ftco-animate pb-5">
          	
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