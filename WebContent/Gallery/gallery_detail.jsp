<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>갤러리 디테일</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>


<style>
* {
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
    

    	$("#modify").on("click",function(){
			location.href="modify.gal?seq=${content.seq}"
			
			
		})	
		
		
		
		
		$("#delete").on("click",function(){
			
			let result = confirm("정말로 삭제하시겠습니까?")
            if(result){
               location.href="delete.gal?seq=${content.seq}";
            }else {
            location.href="#";
         }
			
		})
		
		$("#back").on("click",function(){
			/* location.href="javascript:history.back()" */
			location.href ="${pageContext.request.contextPath}/galList.gal?cpage=1"
			
			
		})


		 $("body").on("click","#del",function(){
		
		if(confirm("정말 삭제하시겠습니까?")){
			$(this).parents("#comment").siblings("#seq").attr("name","seq");
			
			$(this).parents(".commentForm").attr("action","delete.coms").submit();
		}
		
		
	})
	
	
	$("body").on("click","#modi",function(){
	
		if($(this).val()=="수정"){
			$(this).val("완료");
			$(this).parents(".container").children(".content").attr("contenteditable","true");
        	$(this).parents(".container").children(".content").focus();
        	$(this).parents(".").siblings("#seq").attr("name","seq");	
        	
    	}else{
    		$(this).parents(".container").find(".modifytxt").val($(this).parents(".container").children(".content").text());
    		$(this).parents(".commentForm").attr("action","update.coms").submit();
    	}
		 
		
		
	}) 
		
	$("#searchImg").on("click",function(){
        $("#search").show("slow");
        $("#search").focus();
    })
    $("#search").on("blur",function(){
       $("#search").hide("slow");
    })
	//네비바 검색창에서 검색기능
    $("#search").on("keyup",function(e){
        if(e.keyCode==13){
        	let search = $("#search").val();
        	location.href="${pageContext.request.contextPath}/search.cos?cpage=1&keyWord="+search;
        }
    })	
		
    
    
    
    	$("#btn").on("click",function(){
    	
    	var formData = $("#comForm").serialize();
			
			$.ajax({
			 	url:"add.coms",
				type:"post",
			 	data: formData
				
			}).done(function(resp){
				console.log(resp);
				
				
			});
			
			
		}) 
		
		
		
    
    
    
  })

  

		


</script>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link
	href="https://fonts.googleapis.com/css?family=Montserrat:200,300,400,500,600,700,800&display=swap"
	rel="stylesheet">

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

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
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Gugi&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Brush+Script&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Sunflower:wght@300&display=swap"
	rel="stylesheet">
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
                     <a class="mr-sm-2" style="width:75px;" href="${pageContext.request.contextPath}/adminMain.ad">관리자</a>
                     <a class="my-2 my-sm-0" style="width:70px;" href="${pageContext.request.contextPath}/logout.mem">로그아웃</a>
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
			            <a class="mr-sm-2" style="width:75px;" href="Mypage.mem">마이페이지</a>
			            <a class="my-2 my-sm-0" style="width:70px;" href="${pageContext.request.contextPath}/logout.mem">로그아웃</a>
		          	</form>
        		</div>
     		 </nav>
		</c:otherwise>
	</c:choose>



	<!-- END nav -->
	<section class="hero-wrap hero-wrap-2"
		style="background-image: url('images/bg_2.jpg');"
		data-stellar-background-ratio="0.5">
		<div class="overlay"></div>
		<div class="container">
			<div class="row no-gutters slider-text align-items-end">
				<div class="col-md-9 ftco-animate pb-5">
					<p class="breadcrumbs mb-2">
						<span class="mr-2"><a href="index.html">홈 <i
								class="ion-ios-arrow-forward"></i></a></span> <span class="mr-2"><a
							href="blog.html">갤러리 <i class="ion-ios-arrow-forward"></i></a></span> <span>갤러리
							디테일 <i class="ion-ios-arrow-forward"></i>
						</span>
					</p>
					<h1 class="mb-0 bread">갤러리</h1>
				</div>
			</div>
		</div>
	</section>



	<section class="ftco-section ftco-degree-bg">
		<div class="container">
			<div class="row">
				<div class="col-lg-8 ftco-animate" style="margin: auto;">
					<p>
					<c:forEach var="img" items="${ilist }">
						<img src="files/${img.oriName }" style="width:800px;height:700px; margin-left:-30px;" class="col-12 col-lg-12 col-xl-12 p-0">
					</c:forEach>
						
					</p>
					<h2 class="mb-3">${content.title }</h2>

					<p>${content.contents }</p>

					<div class="about-author d-flex p-4 bg-light">
						
						<div class="desc">
							<h5>작성자 : ${content.writer }</h5>
						</div>
					</div>
					<br><br>
					<c:choose>
						<c:when test="${login.id == content.writer }">

							<input type="button" id="modify" class="btn btn-primary"
								value="수정">
							<input type="button" value="삭제" class="btn btn-primary"
								id="delete">
							<input type="button" value="목록으로" class="btn btn-primary"
								id="back">

						</c:when>
						<c:when test="${login.id == 'admin' }">
						
						<input type="button" value="삭제" class="btn btn-primary"
								id="delete">
						<input type="button" value="목록으로" class="btn btn-primary"
								id="back">
						
						</c:when>
						<c:otherwise>


							<input type="button" value="목록으로" id="back"
								class="btn btn-primary">


						</c:otherwise>
					</c:choose>



				</div>
			</div>
		</div>
	</section>




	<!--  댓글 폼 -->

	<c:choose>
		<c:when test="${login.id==null }">
			<div class="container"
				style="overflow: hidden; width: 800px; margin: auto;" id=comment>

				<div class="header" style="background-color: white;">
					<a href="temp_login.jsp">댓글을 작성하려면 로그인 해주세요.<!--로그인proc 두개 만들어 줘야/로그인해서 바로 게시물로 이어지는 프록  --></a>
				</div>

				<hr>

			</div>

		</c:when>




		<c:otherwise>
			<form method="post" id="comForm">


				<div class="container"
					style="overflow: hidden; width: 800px; margin: auto; border: 1px solid #ddd; border-radius: 10px;"
					id=comment>

					<div class="header" style="background-color: white;">ID :
						${login.id}</div>
					<div class="content" style="width: 770px; height: 110px;">
						<textarea
							style="height: 100%; width: 100%; border: 1px solid black; border-radius: 10px;"
							name="comments" id=comments placeholder="댓글을 입력해주세요." class="col-12 col-lg-12 col-xl-12 p-0" required></textarea>
						<input type=hidden value=${content.seq } name=gallery_seq> 

					</div>

					<hr>
					<div class="reply">
						<button id=btn class="btn btn-primary"
							style="float: right; margin-bottom: 10px">등록</button>
					</div>




				</div>


			</form>

		</c:otherwise>
	</c:choose>

	<!-- 등록 댓글 출력 부분 -->
	<c:forEach var="list" items="${list}">
		<c:choose>
			<c:when test="${login.id==list.writer}">


				<form action="" method=get class=commentForm>
					<div class="container"
						style="overflow: hidden; width: 800px; margin: auto;" id=comment>

						<div class="header" style="background-color: white;">ID :
							${list.writer} ${list.write_date }</div>
						<div class="content">${list.comments }</div>
						<input name=comments type=hidden class=modifytxt> <input
							name=seq value="${list.seq }" type=hidden>

						<hr>

						<div class="reply">

							<button type="button" id=del class="btn btn-primary"
								style="float: right; margin-bottom: 10px; margin-left: 10px;">삭제</button>
							<input type="button" id=modi class="btn btn-primary"
								style="float: right; margin-bottom: 10px;" value="수정">
						</div>




					</div>
					<input type="hidden" value="${list.seq}" id="seq"> <input
						type="hidden" name="gallery_seq" value="${content.seq}">
				</form>
			</c:when>
			<c:otherwise>


				<br>
				<div class="container"
					style="overflow: hidden; width: 800px; margin: auto;" id=comment>

					<div class="header" style="background-color: white;">ID :
						${list.writer} ${list.write_date }</div>
					<div class="content">${list.comments }</div>
					<hr>

				</div>
			</c:otherwise>
		</c:choose>
	</c:forEach>



	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>






	<footer class="footer">
		<div class="container">
			<div class="row">
				<div class="col-md-6 col-lg-3 mb-4 mb-md-0">
					<h2 class="footer-heading">WAKI TOKI</h2>
					<p>
						Walk with dog Talk with dog의 줄임말로 반려견과 함께 호흡하는 즐거운 시간을 나타내는 말입니다.<br>
						<br> 소중한 반려견과 편안한 시간을 갖도록 도움을 주는 웹 플랫폼입니다.<br>
						<br> 산책친구찾기 기능부터 산책장소 추천 펫시터모집까지 다양한 편의기능을 지원합니다.
					</p>
					<ul class="ftco-footer-social p-0">
						<li class="ftco-animate"><a href="#" data-toggle="tooltip"
							data-placement="top" title="Twitter"><span
								class="fa fa-twitter"></span></a></li>
						<li class="ftco-animate"><a href="#" data-toggle="tooltip"
							data-placement="top" title="Facebook"><span
								class="fa fa-facebook"></span></a></li>
						<li class="ftco-animate"><a href="#" data-toggle="tooltip"
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
								<a href="#">강아지와 함께 산책</a>
							</h3>
							<div class="meta">
								<div>
									<a href="#"><span class="icon-calendar"></span>2021년 6월 7일</a>
								</div>

							</div>
						</div>
					</div>
					<div class="block-21 mb-4 d-flex">
						<a class="img mr-4 rounded"
							style="background-image: url(images/image_2.jpg);"></a>
						<div class="text">
							<h3 class="heading">
								<a href="#">강아지 목욕시키기</a>
							</h3>
							<div class="meta">
								<div>
									<a href="#"><span class="icon-calendar"></span> 2021년 5월
										20일</a>
								</div>

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
							<li><span class="icon fa fa-map"></span><span class="text">203
									Fake St. Mountain View, San Francisco, California, USA</span></li>
							<li><a href="#"><span class="icon fa fa-phone"></span><span
									class="text">+2 392 3929 210</span></a></li>
							<li><a href="#"><span class="icon fa fa-paper-plane"></span><span
									class="text">info@yourdomain.com</span></a></li>
						</ul>
					</div>
				</div>
			</div>
			<div class="row mt-5">
				<div class="col-md-12 text-center">

					<p class="copyright">
						<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
						Copyright &copy;
						<script>document.write(new Date().getFullYear());</script>
						All rights reserved | This template is made with <i
							class="fa fa-heart" aria-hidden="true"></i> by <a
							href="https://colorlib.com" target="_blank">Colorlib.com</a>
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
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
	<script src="js/google-map.js"></script>
	<script src="js/main.js"></script>



</body>
</html>