<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>산책장소</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
    <link
	href="https://fonts.googleapis.com/css2?family=Sunflower:wght@300&display=swap"
	rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6d9db0cb18c536b19f38869f24be5bcf&libraries=services"></script>
    <link href="https://fonts.googleapis.com/css2?family=Sunflower:wght@300&display=swap" rel="stylesheet">
    <script>
        $(function(){
        	$("#btn").hide();
        	$("#userBtn").hide();
        	 
        	//관리자
			$("#adminBtn").on("click",function(){
					location.href="${pageContext.request.contextPath}/cosList.cos?cpage=1";
			})        	
        	
        	//네비바 검색창에서 검색기능
        	$("#search").on("keyup",function(e){
        		if(e.keyCode==13){
        			let search = $("#search").val();
        			location.href="${pageContext.request.contextPath}/search.cos?cpage=1&keyWord="+search;
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
        	
        	 // 네비바 검색창
            $("#searchImg").on("click",function(){
                $("#search").show("slow");
                $("#search").focus();
            })
            $("#search").on("blur",function(){
               $("#search").hide("slow");
            })  
        	let container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
            let options = { //지도를 생성할 때 필요한 기본 옵션
                center: new kakao.maps.LatLng(37.566826004661, 126.978652258309), //지도의 중심좌표.
                level: 5 //지도의 레벨(확대, 축소 정도)
            };
            
            let map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴 
            
	        var bounds = new kakao.maps.LatLngBounds(); // 인자를 주지 않으면 빈 영역을 생성한다.
			var area = new kakao.maps.LatLng($("#lat").val() , $("#lng").val());
			bounds.extend(area);
	        map.setBounds(bounds);
	        map.setLevel(7);
	        
	        var markers = [];
        
        	if($(".searchCos").val()!=null){
        		
        		var mapContainer = document.getElementById('map');
    		    mapContainer.style.width = '40%';
    		    map.relayout();
        		
        		// 주소-좌표 변환 객체를 생성합니다
            	var geocoder = new kakao.maps.services.Geocoder();
            	// 주소로 좌표를 검색합니다
            	geocoder.addressSearch($(".searchAdd1").val(), function(result, status) {
            	    // 정상적으로 검색이 완료됐으면 
            	     if (status === kakao.maps.services.Status.OK) {
            	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);                   
            	        // 결과값으로 받은 위치를 마커로 표시합니다
            	        var marker = new kakao.maps.Marker({
            	            map: map,            	            
            	            position: coords
            	        });
            	        markers.push(marker);
            	        map.setCenter(coords);
            	        map.setLevel(5);
            	        for(var i=0; i<markers.length-1; i++){
                    		markers[i].setMap(null);
                    	}
            	    } 
            	});   
            	$("#map").css("width","40%");
            	$("#cosImg img").attr("src","map/img/"+$(".searchImg").val());
            	$("#ex").css("display","block");
            	$("#ex_cos").text($(".searchCos").val());
            	$(".explain").text($(".searchEx").val());
            	$(".address1").html('<i class="fas fa-map-marker-alt" style="margin-right: 10px;"></i>'+$(".searchAdd1").val());
            	$(".ex_time").html('<i class="far fa-clock"  style="margin-right: 10px;"></i>'+$(".searchEx_time").val());
            	$(".ex_way").html('<i class="fas fa-long-arrow-alt-up" style="margin-right: 10px;"></i>'+$(".searchEx_way").val());
            	
            	$("#calendar_postcode").val($(".searchPost").val());
           		$("#calendar_address1").val($(".searchAdd1").val());
           		$("#local").val($(".searchArea").val());
           	 	$("#place_name").val($(".searchCos").val());
           	 
           		if($(".searchCos").val()==$(".course_name").text()){
           			alert($(this));
           		}
           		console.log($(".course_name").text());
           	 	
        	}
        	
        	
            $(".areaN").on("click",function(){
            	$("#ex").hide();
                $(".areaN").css("font-weight","normal");
                $(this).css("font-weight","bold");
               
                location.href="${pageContext.request.contextPath}/getCourse.cos?course_area="+$(this).text();
            })
            
            $(".menu").on("click",function(){
            	
            	var mapContainer = document.getElementById('map');
    		    mapContainer.style.width = '40%';
    		    map.relayout();
            	//$("#map").css("width","40%");
            	$("#ex").show();
            	
            	if($("#checklogin").val() == "null"){
            		$("#btn").show();
            	}else if($("#checklogin").val() != null && $("#checklogin").val() != "admin"){
            		$("#userBtn").show();
            	} 
            	
            	$(".radio").attr("checked",false); 
            	$(this).find(".radio").attr("checked",true);
            	// 주소-좌표 변환 객체를 생성합니다
            	var geocoder = new kakao.maps.services.Geocoder();
            	// 주소로 좌표를 검색합니다
            	geocoder.addressSearch($(this).find("#address1").val(), function(result, status) {
            	    // 정상적으로 검색이 완료됐으면 
            	     if (status === kakao.maps.services.Status.OK) {
            	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
            	        map.setLevel(5, {anchor: coords});
            	        // 결과값으로 받은 위치를 마커로 표시합니다
            	        var marker = new kakao.maps.Marker({
            	            map: map,            	            
            	            position: coords
            	        });
            	        markers.push(marker);
            	        map.panTo(coords);
            	        for(var i=0; i<markers.length-1; i++){
                    		markers[i].setMap(null);
                    	}
            	    } 
            	});        
	            	$("#cosImg img").attr("src","map/img/"+$(this).find("#real_name").val());
	            	$("#ex").css("display","block");
	            	$("#ex_cos").text($(this).find(".course_name").text());
	            	$(".explain").text($(this).find("#explain").val());
	            	$(".address1").html('<i class="fas fa-map-marker-alt" style="margin-right: 10px;"></i>'+$(this).find("#address1").val());
	            	$(".ex_time").html('<i class="far fa-clock"  style="margin-right: 10px;"></i>'+$(this).find("#ex_time").val());
	            	$(".ex_way").html('<i class="fas fa-long-arrow-alt-up" style="margin-right: 10px;"></i>'+$(this).find("#ex_way").val());
	            	
	            	$("#calendar_postcode").val($(this).find("#postcode").val());
	            	 $("#calendar_address1").val($(this).find("#address1").val());
	            	 $("#input_local").val($(this).find(".course_area").text());
            })
            
            // modal부분.
			$("#userBtn").on("click",function(){
				 $("#input_place_name").val($("#ex_cos").html());
            	 $("#div_place_name").html($("#ex_cos").html());
				
			     $("#calendarModal").modal("show");
			   
			     $("#close1, #close2").on("click",function(){
			    	 $("#calendarModal").modal("hide");
			     })
			     
			     $("#addCalendar").on("click",function(){
			    	 $.ajax({ 
	            		url:"exam.cos",
	            		type:"post",
	            		data:{"start_date" : $("#calendar_start_date").val(), "end_date" : $("#calendar_end_date").val(),
	            			"local" : $("#input_local").val(), "place_name" : $("#input_place_name").val(),
	            			"postcode" : $("#calendar_postcode").val(), "address1" : $("#calendar_address1").val()}
	            	}).done(function(resp){
	            		if(resp=="1"){
	            			alert("일정을 추가 했습니다.");
	            		}
	            	})
	            	$("#calendarModal").modal("hide");
			     })
			})
            
			$("#btn").on("click",function(){
				let result = confirm("로그인이 필요한 화면입니다. 로그인 하시겠습니까?")
				if(result){
					location.href="Signup/login.jsp";
				}
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
/* 페이지전체 navi Style 부분 끝 */ 
  
    *{box-sizing:border-box; font-family:Sunflower;}
        .wrapper{width:100%; height: 660px; margin-left:25px; margin-right:25px; position: relative;}
        #area{width:100%; padding-bottom: 35px; position: relative; padding-top:35px;}
        #area img{width: 100%; height: 100%;}
        .areaN,.menu:hover {cursor: pointer;}
        #course{width:100%; height: 200px; border-top: 1px solid gray;}
        #area>div{font-size: 10px; }
        #title{width:360px; text-align:center; background-color:#52734D; height:60px;
        line-height: 60px; color: white;}
		#side{width:360px; height:600px; border:1px solid #ddd; }
		.menu>div{float:left;}
		.menu:hover{background-color:#ddd;}
		.menu{overflow:hidden; border-bottom: 1px solid gray; padding-top:6px; padding-bottom:6px;  padding-left:5px;}
		#radio{margin-right:10px;}
		.course_area{font-size:10px;}
		#btn{text-align:center;}
		#map{position: absolute;left:400px; width:70%;height:600px;}
        .wrapper>div{float: left;}
        #ex{position: relative; left:44%;width:30%;}
        #ex>div{border: 1px solid #ddd}
        #cosImg>img{width: 100%; height: 100%;}
        #cosImg{width: 100%; height:300px;}
        #ex_cos{text-align: center; height: 40px;line-height: 40px; font-weight:bold; font-size:20px;}
        #explain>div{border: 1px solid #ddd; padding: 3px; padding-left: 12px;}
        #ex{display:none;}
        #userBtn{position:absolute; left:800px; bottom:10px;border:1px solid #146c43; color:#146c43; }
        #userBtn:hover{background-color:#146c43;color:white;}
        #btn{position:absolute; left:800px; bottom:10px;border:1px solid #146c43; color:#146c43;}
        #btn:hover{background-color:#146c43;color:white;}
        #adminBtn{position:absolute; left:100px; bottom:10px;border:1px solid #146c43; color:#146c43;}
        #adminBtn:hover{background-color:#146c43;color:white;}
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

<!-- 산책장소 시작 -->
    <div class="container-fluid wrapper">
	    	<div id="side">
	    	<div id=title><strong>산책장소 추천</strong></div>
	        <div id="area">
	            <img src="${pageContext.request.contextPath}/map/img/map.PNG" alt="">
	            <div>
	                <div class="areaN" style="position: absolute; text-align: center; top: 175px; right: 20px;">강동구</div>
	                <div class="areaN" style="position: absolute; text-align: center; top: 220px; right: 48px;">송파구</div>
                    <div class="areaN" style="position: absolute; text-align: center; top: 230px; right: 97px;">강남구</div>
                    <div class="areaN" style="position: absolute; text-align: center; top: 245px; right: 133px;">서초구</div>
                    <div class="areaN" style="position: absolute; text-align: center; top: 177px; right: 70px;">광진구</div>
                    <div class="areaN" style="position: absolute; text-align: center; top: 130px; right: 68px;">중랑구</div>
                    <div class="areaN" style="position: absolute; text-align: center; top: 150px; right: 97px;">동대문구</div>
                    <div class="areaN" style="position: absolute; text-align: center; top: 175px; right: 110px;">성동구</div>
                    <div class="areaN" style="position: absolute; text-align: center; top: 225px; right: 180px;">동작구</div>
                    <div class="areaN" style="position: absolute; text-align: center; top: 260px; right: 185px;">관악구</div>
                    <div class="areaN" style="position: absolute; text-align: center; top: 200px; right: 208px;">영등포구</div>
                    <div class="areaN" style="position: absolute; text-align: center; top: 250px; right: 230px;">금<br>천<br>구</div>
                    <div class="areaN" style="position: absolute; text-align: center; top: 230px; left: 60px;">구로구</div>
                    <div class="areaN" style="position: absolute; text-align: center; top: 207px; left: 70px;">양천구</div>
                    <div class="areaN" style="position: absolute; text-align: center; top: 165px; left: 40px;">강서구</div>
                    <div class="areaN" style="position: absolute; text-align: center; top: 170px; left: 112px;">마포구</div>
                    <div class="areaN" style="position: absolute; text-align: center; top: 153px; left: 128px;">서대문구</div>
                    <div class="areaN" style="position: absolute; text-align: center; top: 113px; left: 128px;">은평구</div>
                    <div class="areaN" style="position: absolute; text-align: center; top: 140px; left: 170px;">종로구</div>
                    <div class="areaN" style="position: absolute; text-align: center; top: 90px; left: 195px;">강북구</div>
                    <div class="areaN" style="position: absolute; text-align: center; top: 60px; left: 215px;">도봉구</div>
                    <div class="areaN" style="position: absolute; text-align: center; top: 77px; left: 249px;">노원구</div>
                    <div class="areaN" style="position: absolute; text-align: center; top: 129px; left: 203px;">성북구</div>
                    <div class="areaN" style="position: absolute; text-align: center; top: 193px; left: 173px;">용산구</div>
                    <div class="areaN" style="position: absolute; text-align: center; top: 167px; left: 188px;">중구</div>
                    
	            </div>
	        </div>
	       
	        
	        <div id="course">
	           <c:forEach var="clist" items="${clist}">
	           	<div class=menu>
		           		<div id="radio">
							<c:choose>
								<c:when test="${searchList.course_name==clist.course_name }">
									<input type="radio" name="course" class="radio" checked>
								</c:when>
								<c:otherwise>
									<input type="radio" name="course" class="radio">
								</c:otherwise>
							</c:choose>
						</div>
	               		<div>
		                    <div class="course_area">${clist.course_area}</div>
		                    <div class="course_name">${clist.course_name}</div>
		                    <input type=hidden value="${clist.postcode}" id=postcode>
		                    <input type=hidden value="${clist.address1}" id=address1>
		                    <input type=hidden value="${clist.oriName }"  id=real_name>
		                    <input type=hidden value="${clist.explain }" id=explain>
		                    <input type=hidden value="${clist.ex_time }" id=ex_time>
		                    <input type=hidden value="${clist.ex_way }" id=ex_way>
	               		</div>
	           	</div>
	            </c:forEach> 
	            <c:choose>
	            	<c:when test="${searchList!=null }">
	            		<input type=hidden value="${searchList.course_area }" class=searchArea>
			            <input type=hidden value="${searchList.course_name }" class=searchCos>
			            <input type=hidden value="${searchList.postcode }" class=searchPost>
			            <input type=hidden value="${searchList.address1 }" class=searchAdd1>
			            <input type=hidden value="${searchList.oriName }" class=searchImg>
			            <input type=hidden value="${searchList.explain }" class=searchEx>
			            <input type=hidden value="${searchList.ex_time }" class=searchEx_time>
			            <input type=hidden value="${searchList.ex_way }" class=searchEx_way>
	            	</c:when>
	        	</c:choose>
	        </div>
	       <!--  <div ><input type=button value="일정 추가하기" class="btn btn-outline-success" id=btn></div>  -->
	        <c:choose>
	        	<c:when test="${login.id=='admin'}">
	        		<div><input type=button value="산책 관리자페이지" class="btn btn-outline-success" id=adminBtn></div> 
				</c:when>
	        	<c:when test="${login != null }">
	        		<div><input type=button value="일정 추가하기" class="btn btn-outline-success" id="userBtn">
	        		<input type="hidden" value="${login.id}" id="checklogin">
	        		</div> 
				</c:when>
				<c:otherwise>
					<div><input type=button value="일정 추가하기" class="btn btn-outline-success" id="btn">
					<input type="hidden" value="null" id="checklogin">
					</div> 
				</c:otherwise>
			</c:choose> 
				
			</div>
			
			<div id="map"></div>
        <input type=hidden value="${mlist.lat}" id=lat>
        <input type=hidden value="${mlist.lng}" id=lng>
        <div id="ex">
	        <div id="cosImg"><img src=""></div>
	        <div id="ex_cos"></div>
	        <div id="explain">
	            <div class="address1"><i class="fas fa-map-marker-alt" style="margin-right: 10px;"></i></div>
	            <div class=ex_time><i class="far fa-clock"  style="margin-right: 10px;"></i></div>
	            <div  class=explain>설명</div>
	            <div class=ex_way><i class="fas fa-long-arrow-alt-up" style="margin-right: 10px;"></i></div>
	        </div>
    	</div>
    </div>
    
			<!-- 일정추가 모달 -->
			<div class="modal fade" id="calendarModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"aria-hidden="true">
	        <div class="modal-dialog" role="document">
	            <div class="modal-content">
	                <div class="modal-header">
	                    <h5 class="modal-title" id="exampleModalLabel">산책 일정 추가하기</h5>
	                    	<button type="button" class="close" data-dismiss="modal" aria-label="Close" id="close1">
          						<span aria-hidden="true">&times;</span>
        					</button>
	                </div>
	                <div class="modal-body">
	                    <div class="form-group">
	                    	<label for="taskId" class="col-form-label">산책 장소</label>
	                        <div class="form-control" id="div_place_name"></div>
	                        <input type="hidden" class="form-control" id="input_local" name="local" value="">
	                        <input type="hidden" class="form-control" id="input_place_name" name="place_name" value="">
							<input type="hidden" class="form-control" id="calendar_postcode" name="postcode" value="">
							<input type="hidden" class="form-control" id="calendar_address1" name="address1" value="">

	                        <label for="taskId" class="col-form-label">산책 시작 일자</label>
	                        <input type="datetime-local" class="form-control" id="calendar_start_date" name="calendar_start_date">
	                        <label for="taskId" class="col-form-label">산책 종료 일자</label>
	                        <input type="datetime-local" class="form-control" id="calendar_end_date" name="calendar_end_date">
	                    </div>
	                </div>
	                <div class="modal-footer">
	                    <button type="submit" class="btn btn-warning" id="addCalendar">추가</button>
	                    <button type="button" class="btn btn-secondary" data-dismiss="modal" id="close2">취소</button>
	                </div>     
	            </div>
	        </div>
	   	 </div>
		
        
</body>
</html>