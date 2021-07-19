<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8'>
<meta http-equiv='X-UA-Compatible' content='IE=edge'>
<title>우리동네 산책 플래너</title>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- bootstrap 4 -->
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

 <!-- fullcalendar -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.7.0/main.min.css">
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/fullcalendar@5.7.0/main.min.js"></script>

<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6d9db0cb18c536b19f38869f24be5bcf&libraries=services"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Sunflower:wght@300&display=swap" rel="stylesheet">
<script>
    document.addEventListener('DOMContentLoaded', function () {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
            navLinks: true, // 날짜 클릭시 이벤트
            navLinkDayClick: function(date, jsEvent) {
              	$("#weatherDay").text("");
            	$("#weatherContents").text("");
            	$("#weatherimg").attr("src","");
            	$("#dust").text("");
            	$("#minTemper").text("");
				$("#maxTemper").text(""); // 초기화
				
            	var get_date = new Date(date);
            	$.ajax({ 
        			url:"weather.planner",
        			type:"get",
        			data:{"date" : get_date.yyyymmdd1()},
            		dataType:"json"
        		}).done(function(resp){
        			console.log(resp);
        			convertDate(date);
        			if(resp[0].text == null){
        				$("#weatherDay").append("예보가<br>아직 확정되지 않았습니다.");
        			}else{
        			 	if(resp[0].text == "맑음"){
        					$("#weatherimg").attr("src","${pageContext.request.contextPath}/Mypage/sun.PNG");
        				}else if(resp[0].text == "구름조금"){
        					$("#weatherimg").attr("src","${pageContext.request.contextPath}/Mypage/littlecloud.PNG");
        				}else if(resp[0].text == "구름많음"){
        					$("#weatherimg").attr("src","${pageContext.request.contextPath}/Mypage/cloudy.PNG");
        				}else if(resp[0].text == "흐림"){
        					$("#weatherimg").attr("src","${pageContext.request.contextPath}/Mypage/gray.PNG");
        				}else if(resp[0].text == "비"){
        					$("#weatherimg").attr("src","${pageContext.request.contextPath}/Mypage/rain.PNG");
        				} 
        				$("#weatherContents").text(resp[0].text);
        				
        				if(resp[0].dust != null) {
            				$("#dust").text("미세먼지 : " + resp[0].dust);
        				}
        				$("#minTemper").text("최저 기온 : " + resp[0].minTemper +"℃");
        				$("#maxTemper").text("최고 기온 : " + resp[0].maxTemper +"℃");
        			}
        		})

            },
            timeZone: 'UTC',
            initialView: 'dayGridMonth', // 홈페이지에서 다른 형태의 view를 확인할  수 있다.   
            fixedWeekCount : false, // default가 6주로 표시되는데, 그 달에 맞추어 주 표시
            editable: false, // false로 변경 시 draggable 작동 x 
            eventDisplay: 'block',
            eventClick:function(eventData) { //일정보기,수정
	            if(eventData.event.extendedProps.dog_parent_id == "${login.id}"){
	            	var start = eventData.event.startStr;
	            	var end = eventData.event.endStr; 
					
		            $("#myview_place_name").val(eventData.event.title);
		            $("#myview_start_date").val(start.slice(0,-1));
		            $("#myview_end_date").val(end.slice(0,-1));
		            
		            $("#myview_contents").val(
		            	'person_id : ' + eventData.event.extendedProps.dog_parent_id + ', ' + 	
		            	'이름 : ' + eventData.event.extendedProps.dog_name + ', ' + 
		            	'종 : ' + eventData.event.extendedProps.dog_breed + ', ' + 
		            	'성별 : ' + eventData.event.extendedProps.dog_gender + ', ' + 
		            	'특징 : ' + eventData.event.extendedProps.dog_feature + ', ' + 
		            	'나이 : ' + eventData.event.extendedProps.dog_age + ', ' + 
		            	'중성화 여부 : ' + eventData.event.extendedProps.dog_neutering
		            );

		            $("#myViewModal").modal("show");

		            $("#myview_update").on("click",function(){
	         			$.ajax({ 
	            			url:"update.planner",
	            			type:"get",
	            			data:{"seq" : eventData.event.id, "title" : $("#view_place_name").val(), "start" : $("#view_start_date").val(),"end" : $("#view_end_date").val()}
	            		}).done(function(resp){
	            			if(resp =="1"){
	            				alert("일정 수정 완료!");
	            			}else{
	            				alert("일정 수정에 실패했습니다.");
	            			}
	            		})
	            		calendar.render();
	         		}) 
	         		
	         		$("#myview_delete").on("click",function(){
	         			$.ajax({ 
	            			url:"delete.planner",
	            			type:"get",
	            			data:{"seq" : eventData.event.id}
	            		}).done(function(resp){
	            			if(resp =="1"){
	                 			eventData.event.remove();
	            				alert("일정 삭제 완료!");
	            			}else{
	            				alert("일정 삭제에 실패했습니다.");
	            			}
	            		})
	            		calendar.render();
	         		}) 
	            }else{
	            	var start = eventData.event.startStr;
	            	var end = eventData.event.endStr; 
					
		            $("#otherview_place_name").val(eventData.event.title);
		            $("#otherview_start_date").val(start.slice(0,-1));
		            $("#otherview_end_date").val(end.slice(0,-1));
		            
		            $("#otherview_contents").val(
		            	'person_id : ' + eventData.event.extendedProps.dog_parent_id + ', ' + 	
		            	'이름 : ' + eventData.event.extendedProps.dog_name + ', ' + 
		            	'종 : ' + eventData.event.extendedProps.dog_breed + ', ' + 
		            	'성별 : ' + eventData.event.extendedProps.dog_gender + ', ' + 
		            	'특징 : ' + eventData.event.extendedProps.dog_feature + ', ' + 
		            	'나이 : ' + eventData.event.extendedProps.dog_age + ', ' + 
		            	'중성화 여부 : ' + eventData.event.extendedProps.dog_neutering
		            );

		            $("#otherViewModal").modal("show");
	            }
            },                
            headerToolbar: {
                center: 'addEventButton' // headerToolbar에 버튼을 추가
            }, customButtons: {
                addEventButton: { // 추가한 버튼 설정
                    text : "일정 추가",  // 버튼 내용
                    click : function(){ // 버튼 클릭 시 이벤트 추가
                        $("#calendarModal").modal("show"); // modal 나타내기

                        $("#addCalendar").on("click",function(){  // modal의 추가 버튼 클릭 시
                            var start_date = $("#calendar_start_date").val();
                            var end_date = $("#calendar_end_date").val();
                            var local = $("#local").val();
                            var place_name = $("#place_name").val();
                                
                            //내용 입력 여부 확인
                           if(start_date == "" || end_date == ""){
                                alert("날짜를 입력하세요.");
                            }else if(new Date(end_date)- new Date(start_date) < 0){ // date 타입으로 변경 후 확인
                                alert("종료일이 시작일보다 먼저입니다.");
                            }else if(local == null){
                            	alert("산책장소를 선택해주세요.");
                            }else{ // 정상적인 입력 시
                            	$.ajax({ 
                        			url:"add.planner",
                        			type:"get",
                        			data:{"start" : start_date, "end" : end_date,
                        				"local" : local,"place_name" : place_name},
                        		}).done(function(resp){
                        			if(resp =="1"){
                        				alert("일정 추가 완료!");
                        			}else{
                        				alert("일정을 추가에 실패했습니다.");
                        			}
                        		})
                        		calendar.addEvent({
                                    title: place_name,
                                    start: start_date,
                                    end : end_date,
                                    color : '#52734D'
                                });
                            }
                        })
                    }
                }
            }
        });
        calendar.render();
        // 일정불러오기
         $.ajax({
     		url:"event.calendar",
 			type:"get",
 			dataType:"json"
     	}).done(function(resp){    
     		$.each(resp, function(index, item){
     			calendar.addEvent(item);
     		})
     		calendar.render();
     	})

        // 받은 날짜값을 date 형태로 형변환 해주어야 한다.
        function convertDate(date) {
            var date = new Date(date);
            $("#weatherDay").text(date.yyyymmdd2()+" 날씨");
        }

        // 받은 날짜값을 YYYY-MM-DD 형태로 출력하기위한 함수.
        Date.prototype.yyyymmdd1 = function() {
            var yyyy = this.getFullYear().toString();
            var mm = (this.getMonth() + 1).toString();
            var dd = this.getDate().toString();

            return yyyy + (mm[1] ? mm : "0" + mm[0]) + (dd[1] ? dd : "0" + dd[0]);
        }
        
        Date.prototype.yyyymmdd2 = function() {
            var yyyy = this.getFullYear().toString();
            var mm = (this.getMonth() + 1).toString();
            var dd = this.getDate().toString();
            var hh = this.getHours().toString();
            var mi = this.getMinutes().toString();
            return yyyy + "-" + (mm[1] ? mm : "0" + mm[0]) + "-" + (dd[1] ? dd : "0" + dd[0]);
        }
		
        // 네비바 검색창
        $("#searchImg").on("click",function(){
            $("#search").show("slow");
            $("#search").focus();
        })
        $("#search").on("blur",function(){
        	$("#search").hide("slow");
        })
        
        // 쪽지보내기
        $(".message").on("click",function(){
        	$("#to_id").val($(this).siblings(".otherId").text());
            $("#messageModal").modal("show");
            
            $("#sendMessage").on("click",function(){
            	if($("#title").val() == null || $("#title").val() == ""){
                    alert("제목을 입력하세요.");
                }else if($("#contents").val() == null || $("#contents").val() == ""){
                    alert("쪽지내용을 입력하세요.");
                }else{ // 정상적인 입력 시
                    $.ajax({ 
	           			url:"${pageContext.request.contextPath}/add.message?pb_seq=0",
	        			type:"get",
	        			data:{"title":$("#title").val(), "to_id":$("#to_id").val(), "contents":$("#contents").val()},
	        			dataType:"json"
        			}).done(function(resp){
            			if(resp == "1"){
            				alert($("#to_id").val() + "님에게 쪽지를 보냈습니다.");
            			}
            		})	
                }
            })
        })
        
		// 우편번호 검색 
        $("#postbtn").on("click",function(){
            new daum.Postcode({
			    oncomplete: function (data) {
            	    let roadAddr = data.roadAddress; 
            	    
           		    document.getElementById("calendar_postcode").value = data.zonecode;
            	    // document.getElementById("address1").value = roadAddr; 도로명주소
                    document.getElementById("calendar_address1").value = data.jibunAddress;
			    }
		    }).open();
        });
        
        // 산책히스토리 출력
        let count = 0;
        $(".historyBar").on("click",function(){
            if(count==0 && $(this).text() != '-'){
            	if($(this).parents(".historylist").find(".person_name").text() == '이름 : '){
            		if($(this).siblings(".category").text() == "산책동행" || $(this).siblings(".category").text() == "팻시터 합니다"){
            			let person_name = $(this).parents(".historylist").find(".person_name");
            			let person_age = $(this).parents(".historylist").find(".person_age");
            			let person_gender = $(this).parents(".historylist").find(".person_gender");
                		$.ajax({ 
                			url:"p_info.planner",
                			type:"get",
                			data:{"otherId":$(this).siblings(".otherId").text()},
                			dataType:"json"
                		}).done(function(resp){ 
                			person_name.append(resp.person_name);
                			person_age.append(resp.person_age);
                			person_gender.append(resp.person_gender);
                		});
                		
                		let dog_name = $(this).parents(".historylist").find(".dog_name");
                		let dog_age = $(this).parents(".historylist").find(".dog_age");
                		let dog_gender = $(this).parents(".historylist").find(".dog_gender");
                		let dog_breed = $(this).parents(".historylist").find(".dog_breed");
                		let dog_feature = $(this).parents(".historylist").find(".dog_feature");
                		let dog_neutering = $(this).parents(".historylist").find(".dog_neutering"); 
                		$.ajax({ 
                			url:"d_info.planner",
                			type:"get",
                			data:{"otherId":$(this).siblings(".otherId").text()},
                			dataType:"json"
                		}).done(function(resp){ 
                			console.log
                			dog_name.append(resp.dog_name);
                			dog_age.append(resp.dog_age);
                			dog_gender.append(resp.dog_gender);
                			dog_breed.append(resp.dog_breed);
                			dog_feature.append(resp.dog_feature);
                			dog_neutering.append(resp.dog_neutering); 
                		})
                	}else if($(this).siblings(".category").text() == "펫시터 구해요"){
                		let person_name = $(this).parents(".historylist").find(".person_name");
            			let person_age = $(this).parents(".historylist").find(".person_age");
            			let person_gender = $(this).parents(".historylist").find(".person_gender");
                		
                		$.ajax({ 
                			url:"p_info.planner",
                			type:"get",
                			data:{"otherId":$(this).siblings(".otherId").text()},
                			dataType:"json"
                		}).done(function(resp){ 
                			person_name.append(resp.person_name);
                			person_age.append(resp.person_age);
                			person_gender.append(resp.person_gender);
                		})
                	}
            	}
            	$(this).text('접기');
                $(this).parent().next(".hisinforma").show("slow");
                count++;
            }else if(count==1){
				$(this).parent().next(".hisinforma").hide("slow");
            	$(this).text('보기');
            	count = 0;
            }
        })
		
        // 산책히스토리 - 장소 마커
		$(".placeName").on("click",function(){ 
			var geocoder = new kakao.maps.services.Geocoder();
    		geocoder.addressSearch($(this).children(".address").val(), function(result, status) { // 주소로 좌표를 검색합니다.
    			
				if (status === kakao.maps.services.Status.OK) { // 정상적으로 검색이 완료됐으면 
    				var coords = new kakao.maps.LatLng(result[0].y, result[0].x);    
    			    var marker = new kakao.maps.Marker({ // 결과값으로 받은 위치를 마커로 표시합니다
    			    	map: map,
    			        position: coords
    			   	});
    				map.setCenter(coords); // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다.
				}
    		})
    	})
        
       let container = document.getElementById("map");
            let options = {
                center: new kakao.maps.LatLng(33.450701, 126.570667),
                level:3
            }; //어떤 설정을 줄건지
            let map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴s
            // 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
            let mapTypeControl = new kakao.maps.MapTypeControl();
            // 지도에 컨트롤을 추가해야 지도위에 표시됩니다
            // kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
            map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
            // 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
            let zoomControl = new kakao.maps.ZoomControl();
            // 마커가 표시될 위치입니다 
            var markerPosition  = new kakao.maps.LatLng(33.450701, 126.570667); 
            // 마커를 생성합니다
            var marker = new kakao.maps.Marker({
                position: markerPosition
            });
            // 마커가 지도 위에 표시되도록 설정합니다
            marker.setMap(map);
            // 아래 코드는 지도 위의 마커를 제거하는 코드입니다
            // marker.setMap(null); 

    })
</script>
<style>
* {font-family: 'Sunflower';}
    /* div{border:1px solid black;} */
    body{background-color: #91C788;}
    .container{
        background-color: white;
        border:1px solid #ddd;
        margin:auto;
        text-align:center;
        position:relative;
        top:40px;
    }
    .row{margin:0px;}
    #calendarBox{
        width: 100%;
        height:100%;
    } 
/* 페이지전체 navi Style 부분 시작 */
    #navibar{
        background-color:white;
        z-index: 1000 !important;
    }
    #searchBox{position: relative;min-height: 110px;}
    .nav-item:hover{border-bottom:3px solid #52734D;}
    #search{
        width:200px; height:40px;
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
    #body{height: auto;}
    #weather{border:1px solid black;height:115px;}
    #weatherDay{font-size: 18px; font-weight:500;}
    #map{height:100%;width:100%;}
    .fc-toolbar-title{padding-left:10px;}
    .historylist{min-height:40px;border:1px solid rgb(194, 191, 191);line-height:40px;}
    .message:hover{cursor:pointer;}
    #calendar_postcode{width:300px;}
    #calendar_postcode~a{position: relative; top:-39px;left:310px;}
    #addresstext{position: relative;left:-130px;}
    .placeName:hover{font-weight:1000;cursor:pointer;}
    .historyBar:hover{font-weight:1000;cursor:pointer;}
    .his
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
  
    <div class="container rounded p-4 pt-5">
        <h1 class="pt-2 pb-4">우리동네 Walking 플래너</h1>
  
        <div class="row mb-4 mt-5" id="body">
            <div class="col-12 col-md-7 p-0 pr-3">
                <div id="calendarBox">
                    <div id="calendar"></div>
                </div>
            </div>
            <div class="col-12 col-md-5 p-0 pl-1">
                <div class="row">
                    <div class="col-12 mb-2 p-2" id="weather">
                        <div class="row m-0">
                            <div class="col-12" id="weatherDay" style="text-align: center;">
                            	👉날짜를 클릭해 날씨를 알아보세요👈
                            </div>
                        </div> 
                        <div class="row m-0 h-100">
                            <div class="col-5 p-0" style="text-align: center;">
                            	<strong id="weatherContents"></strong>
                                <img id="weatherimg" src="" style="height:75px;">
                            </div>
                            <div class="col-7">
                                <div class="row m-0">
                                    <div class="col-12" id="temperature">
                                        <div id="minTemper"></div>
                                        <div id="maxTemper"></div>
                                    </div>
                                </div>
                                <div class="row m-0">
                                    <div class="col-12" id="dust"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row"> <!-- 지도 -->
                    <div class="col-12" id="map" style="width:360px;height:400px;"></div>
                </div>
            </div>
        </div>
        
        <div class="footer">
            <h3 style="text-align:left;">산책 히스토리🐾</h3>
	<c:choose>
		<c:when test="${history == null }">
		 	<div class="rounded historylist">최근 3개월간 산책 히스토리가 없습니다.</div>
		</c:when>
		<c:otherwise>
			<c:forEach var="list" items="${history}">
				<c:choose>
					<c:when test="${list.category == '펫시터 구해요'}"> <!-- 펫시터 해준 사람정보 -->
						<div class="rounded historylist">
		        			<div class="row">
				            	<div class="col-2 placeName">
				            		${list.place_name}
				            		<input type="hidden" class="address" value="${list.address1 }">
				            	</div>
				            	<div class="col-3 day">${list.start }</div>
				            	<div class="col-2 category">${list.category}</div>
				            	<div class="col-2 otherId">${list.other_id }</div>
				            	<div class="col-2 message">쪽지보내기💌</div>
				            	<div class="col-1 historyBar">보기</div>
		            		</div>
	                		<div class="hisinforma p-3" style="display:none;border-top: 1px dashed rgb(180, 180, 180);">
	                			<div class="row">
	                				<div class="col-4 person_name">펫시터 이름 : </div>
	                    			<div class="col-4 person_age">나이대 : ${list.age }</div>
	                    			<div class="col-4 person_gender">성별 : ${list.gender }</div>
	                			</div>
	            			</div>
						</div>
					
					</c:when>
					
					<c:when test="${list.category == null}"> <!-- 나 혼자 산책한 정보 -->
						
						<div class="rounded historylist">
		        			<div class="row">
				            	<div class="col-2 placeName">
				            		${list.place_name}
				            		<input type="hidden" class="address" value="${list.address1 }">
				            	</div>
				            	<div class="col-3 day">${list.start }</div>
				            	<div class="col-2 category">-</div>
				            	<div class="col-2 otherId">-</div>
				            	<div class="col-2 message">-</div>
				            	<div class="col-1 historyBar">-</div>
		            		</div>
	            		</div>
						
					</c:when>
					<c:otherwise> <!-- 같이 동행한 사람,강아지정보 / 펫시터 합니다 : 펫시터 해준  -->
					
						<div class="rounded historylist">
		        			<div class="row">
				            	<div class="col-2 placeName">
				            		${list.place_name}
				            		<input type="hidden" class="address" value="${list.address1 }">
				            	</div>
				            	<div class="col-3 day">${list.start }</div>
				            	<div class="col-2 category">${list.category}</div>
				            	<div class="col-2 otherId">${list.other_id }</div>
				            	<div class="col-2 message">쪽지 보내기💌</div>
				            	<div class="col-1 historyBar">보기</div>
		            		</div>
	                		<div class="hisinforma p-3" style="display:none;">
	                			<div class="row" style="border-top: 1px dashed rgb(180, 180, 180);">
	                				<div class="col-4 person_name">이름 : </div>
	                    			<div class="col-4 person_age">나이대 : </div>
	                    			<div class="col-4 person_gender">성별 : </div>
	                			</div>
	                    		<div class="row" style="border-top: 1px dashed rgb(180, 180, 180);">
	                				<div class="col-4 dog_name">강아지이름 : </div>
	                    			<div class="col-4 dog_age">나이 : </div>
	                    			<div class="col-4 dog_gender">성별 : </div>
	                			</div>
	                			<div class="row">
	                				<div class="col-4 dog_breed">종 : </div>
	                				<div class="col-4 dog_feature">특징 : </div>
	                				<div class="col-4 dog_neutering">중성화여부 : </div>
	                			</div>
	               		 	</div>
	            		</div>
					
					</c:otherwise>
				</c:choose>
			</c:forEach>			    		
		</c:otherwise>
	</c:choose>
		</div>     
    </div>

    <!-- 쪽지 moadal -->
    <div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">쪽지 보내기💌</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                    	<label for="taskId" class="col-form-label">받는 사람</label>
                        <input type="text" class="form-control" name="to_id" id="to_id">
                    
                        <label for="taskId" class="col-form-label">제목</label>
                        <input type="text" class="form-control" id="title" name="title">
                      
                        <label for="taskId" class="col-form-label">내용</label>
                        <textarea class="form-control" rows="8" name="contents" id="contents" placeholder="보내실 쪽지 내용을 입력해주세요."></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" id="sendMessage" data-dismiss="modal">쪽지보내기</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" id="sprintSettingModalClose">취소</button>
                </div>     
            </div>
        </div>
    </div>
	
	<!-- 일정추가 Modal -->
	<div class="modal fade" id="calendarModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">산책 일정 추가하기</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="taskId" class="col-form-label">산책 시작</label>
                        <input type="datetime-local" class="form-control" id="calendar_start_date" name="calendar_start_date">
                        <label for="taskId" class="col-form-label">산책 종료</label>
                        <input type="datetime-local" class="form-control" id="calendar_end_date" name="calendar_end_date">

                        <label for="taskId" class="col-form-label">자치구</label>
                        <select name="local" id="local" class="form-control" onchange="categoryChange(this)"> 
                           <option>거주하는 구를 선택하세요.</option>
                           <option value="강남구">강남구</option>
                           <option value="강동구">강동구</option>
                           <option value="강북구">강북구</option>
                           <option value="강서구">강서구</option>
                           <option value="관악구">관악구</option>
                           <option value="광진구">광진구</option>
                           <option value="구로구">구로구</option>
                           <option value="금천구">금천구</option>
                           <option value="노원구">노원구</option>
                           <option value="도봉구">도봉구</option>
                           <option value="동대문구">동대문구</option>
                           <option value="동작구">동작구</option>
                           <option value="마포구">마포구</option>
                           <option value="서대문구">서대문구</option>
                           <option value="서초구">서초구</option>
                           <option value="성동구">성동구</option>
                           <option value="성북구">성북구</option>
                           <option value="송파구">송파구</option>
                           <option value="양천구">양천구</option>
                           <option value="영등포구">영등포구</option>
                           <option value="용산구">용산구</option>
                           <option value="은평구">은평구</option>
                           <option value="종로구">종로구</option>
                           <option value="중구">중구</option>
                           <option value="중랑구">중랑구</option>
                        </select>

                        <label for="taskId" class="col-form-label">장소 선택</label>
                        <select name="place_name" id="place_name" class="form-control">
                        	<option>장소를 선택해주세요.</option>
                        </select>
                        <script>
                        function categoryChange(e) {
                        	var place_name_강남구 = ["청담근린공원", "대모산자연공원", "양재천"];
                        	var place_name_강동구 = ["일자산 공원", "광나루한강공원", "천호공원"];
                        	var place_name_강북구 = ["북서울꿈의 숲", "우이천", "솥밭공원"];
                        	var place_name_강서구 = ["봉제산 근린공원", "궁산근린공원", "우장산공원"];
                        	var place_name_관악구 = ["관악산 호수공원", "낙성대공원", "도림천"];
                        	var place_name_광진구 = ["아차산생태공원", "뚝섬 한강공원", "광진숲나루"];
                        	var place_name_구로구 = ["푸른수목원", "구로개봉유수지 생태공원", "고척근린공원"];
                        	var place_name_금천구 = ["금천체육공원", "호암늘솔길", "안양천"];
                        	var place_name_노원구 = ["경춘선 숲길", "불암산 힐링타운", "영축산 순환산책로"];
                        	var place_name_도봉구 = ["방학천", "서울 창포원"];
                        	var place_name_동대문구 = ["배봉산둘레길", "답십리공원", "장안벚꽃안길"];
                        	var place_name_동작구 = ["보라매공원", "서달산 동작충효길", "사육신공원"];
                        	var place_name_마포구 = ["상암 하늘공원", "경의선숲길", "망원 한강공원"];
                        	var place_name_서대문구 = ["안산도시자연공원", "불광천", "궁동근린공원"];
                        	var place_name_서초구 = ["몽마르뜨공원", "양재시민의 숲", "우면산"];
                        	var place_name_성동구 = ["서울숲", "응봉근린공원", "달맞이봄공원"];
                        	var place_name_성북구 = ["개운산공원", "정릉천", "오동공원"];
                        	var place_name_송파구 = ["송파둘레길", "아시아공원", "올림픽공원"];
                        	var place_name_양천구 = ["서서울공원", "서울특별시 용왕산 근린공원", "달마을근린공원"];
                        	var place_name_영등포구 = ["여의도 한강공원", "양화한강공원", "선유도공원"];
                        	var place_name_용산구 = ["용산가족공원", "이촌 한강공원", "남산 둘레길"];
                        	var place_name_은평구 = ["봉산 둘레길", "서울혁신파크", "신사근린공원"];
                        	var place_name_종로구 = ["북악스카이웨이", "낙산공원", "숭인근린공원"];
                        	var place_name_중구 = ["남산공원", "서울로 7107", "매봉산공원"];
                        	var place_name_중랑구 = ["중랑천", "봉화산 둘레길", "용마폭포공원"];
                        	
                        	var target = document.getElementById("place_name");
                        	
                        	if(e.value == "강남구") {var place = place_name_강남구;}
                        	else if(e.value == "강동구") {var place = place_name_강동구;}
                        	else if(e.value == "강북구") {var place = place_name_강북구;}
                        	else if(e.value == "강서구") {var place = place_name_강서구;}
                        	else if(e.value == "관악구") {var place = place_name_관악구;}
                        	else if(e.value == "광진구") {var place = place_name_광진구;}
                        	else if(e.value == "구로구") {var place = place_name_구로구;}
                        	else if(e.value == "금천구") {var place = place_name_금천구;}
                        	else if(e.value == "노원구") {var place = place_name_노원구;}
                        	else if(e.value == "도봉구") {var place = place_name_도봉구;}
                        	else if(e.value == "동대문구") {var place = place_name_동대문구;}
                        	else if(e.value == "동작구") {var place = place_name_동작구;}
                        	else if(e.value == "마포구") {var place = place_name_마포구;}
                        	else if(e.value == "서대문구") {var place = place_name_서대문구;}
                        	else if(e.value == "서초구") {var place = place_name_서초구;}
                        	else if(e.value == "성동구") {var place = place_name_성동구;}
                        	else if(e.value == "성북구") {var place = place_name_성북구;}
                        	else if(e.value == "송파구") {var place = place_name_송파구;}
                        	else if(e.value == "양천구") {var place = place_name_양천구;}
                        	else if(e.value == "영등포구") {var place = place_name_영등포구;}
                        	else if(e.value == "용산구") {var place = place_name_용산구;}
                        	else if(e.value == "은평구") {var place = place_name_은평구;}
                        	else if(e.value == "종로구") {var place = place_name_종로구;}
                        	else if(e.value == "중구") {var place = place_name_중구;}
                        	else if(e.value == "중랑구") {var place = place_name_중랑구;}
                        	
                        	target.options.length = 0;
                        	
                        	for (x in place) {
                        		var opt = document.createElement("option");
                        		opt.value = place[x];
                        		opt.innerHTML = place[x];
                        		target.appendChild(opt);
                        	}
                        }
                        </script>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" id="addCalendar" data-dismiss="modal">추가</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" id="sprintSettingModalClose">취소</button>
                </div>     
            </div>
        </div>
    </div>
    
    <!-- 내 일정 수정, 삭제 Modal --> 
    <div class="modal fade" id="myViewModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">일정 상세 보기, 수정하기</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group m-0">
                    	<label for="taskId" class="col-form-label">산책장소</label>
                        <input type="text" class="form-control" id="myview_place_name" name="view_place_name">
                        <label for="taskId" class="col-form-label">시작 날짜</label>
                        <input type="datetime-local" class="form-control" id="myview_start_date" name="view_start_date">
                        <label for="taskId" class="col-form-label">종료 날짜</label>
                        <input type="datetime-local" class="form-control" id="myview_end_date" name="view_end_date">
                        <label for="taskId" class="col-form-label">강아지 정보</label>
                        <textarea class="form-control" rows="6" name="view_contents" id="myview_contents"></textarea>
                    </div>
                </div>
                <div class="modal-footer" id="view_modal_footer">
                	<button type="button" class="btn btn-warning" id="myview_update" data-dismiss="modal">수정</button>
                    <button type="button" class="btn btn-danger" id="myview_delete" data-dismiss="modal">삭제</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" id="sprintSettingModalClose">확인</button>
                </div>     
            </div>
        </div>
    </div>
    
    <!-- 남 일정 Modal --> 
    <div class="modal fade" id="otherViewModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">일정 상세 보기, 수정하기</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group m-0">
                    	<label for="taskId" class="col-form-label">산책장소</label>
                        <input type="text" class="form-control" id="otherview_place_name" name="otherview_place_name">
                        <label for="taskId" class="col-form-label">시작 날짜</label>
                        <input type="datetime-local" class="form-control" id="otherview_start_date" name="otherview_start_date">
                        <label for="taskId" class="col-form-label">종료 날짜</label>
                        <input type="datetime-local" class="form-control" id="otherview_end_date" name="otherview_end_date">
                        <label for="taskId" class="col-form-label">강아지 정보</label>
                        <textarea class="form-control" rows="6" name="otherview_contents" id="otherview_contents"></textarea>
                    </div>
                </div>
                <div class="modal-footer" id="view_modal_footer">
                </div>     
            </div>
        </div>
    </div>
</body>
</html>