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
	<section class="hero-wrap hero-wrap-2"
		style="background-image: url('images/bg_2.jpg');"
		data-stellar-background-ratio="0.5">
		<div class="overlay"></div>
		<div class="container">
			<div class="row no-gutters slider-text align-items-end">
				<div class="col-md-9 ftco-animate pb-5">
					
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


				<div class="container col-12 col-lg-12 col-xl-12 p-0"
					style="overflow: hidden; width: 800px; margin: auto; border: 1px solid #ddd; border-radius: 10px;"
					id=comment>

					<div class="header col-12 col-lg-12 col-xl-12 p-0" style="background-color: white;">ID :
						${login.id}</div>
					<div class="content col-12 col-lg-12 col-xl-12 p-0" style="width: 770px; height: 110px;">
						<textarea
							style="height: 100%; width: 100%; border: 1px solid black; border-radius: 10px;"
							name="comments" id=comments placeholder="댓글을 입력해주세요." class="content col-12 col-lg-12 col-xl-12 p-0" required></textarea>
						<input type=hidden value=${content.seq } name=gallery_seq> 

					</div>

					<hr>
					<div class="reply">
						<button id=btn class="btn btn-primary"
							style="float: right; margin-bottom: 10px; margin-right:10px;">등록</button>
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
					<div class="container col-12 col-lg-12 col-xl-12 p-0"
						style="overflow: hidden; width: 800px; margin: auto;" id=comment>

						<div class="header" style="background-color: white;">ID :
							${list.writer} ${list.write_date }</div>
						<div class="content">${list.comments }</div>
						<input name=comments type=hidden class=modifytxt> <input
							name=seq value="${list.seq }" type=hidden>

						<hr>

						<div class="reply" >

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