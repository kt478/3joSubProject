<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Message List</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Sunflower:wght@300&display=swap" rel="stylesheet">
    <script>
        $(function(){
            // 네비바 검색창
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
            
            // 펫시터 게시글 보기
            $(".petboard").on("click",function(){
            	let petboard = $(this).siblings(".pb_seq").val();
            	$.ajax({ 
					url:"check.message",
	        			type:"get",
	        			data:{"pb_seq":petboard}
     			}).done(function(resp){
     				if(resp == 'true'){
     					alert("이미 일정이 생성되어 만료된 게시글 입니다.");
     				}else{
     					location.href = "${pageContext.request.contextPath}/detailWrite.pet?seq=" + petboard;
     				}
     			})
            })
            
            // 수락보내기
			$(".accept2").on("click",function(){
				let seq = $(this).siblings(".seq").val();
				let pb_seq = $(this).siblings(".pb_seq").val();
				let other_id = $(this).siblings(".other_id").val();
				$.ajax({ 
					url:"check.message",
	        		type:"get",
	        		data:{"pb_seq":$(this).siblings(".pb_seq").val()}
     			}).done(function(resp){
     				if(resp == 'true'){
     					alert("이미 일정이 생성된 쪽지 입니다.");
     				}else{
     					if(confirm("이 일정을 수락 하시겠습니까?")){
     	            		 $.ajax({ 
     	 	           			url:"accept.message",
     	 	        			type:"get",
     	 	        			data:{"seq":seq,"pb_seq":pb_seq,"other_id":other_id}
     	         			}).done(function(resp){
     	             			if(resp == "1"){
     	             				alert("쪽지가 수락되어 일정이 생성되었습니다.");
     	             			}
     	            	 	}) 
     	            	 } 
     				}
     			})
            })
            
            // 취소하기
            $(".accept1").on("click",function(){
            	if(confirm("보낸쪽지를 취소 하시겠습니까?")){
            		location.href = "cancel.message?seq=" + $(this).siblings(".seq").val();
            	}
            })
        })    
    </script>
    <style>
    * {font-family: 'Sunflower';}
    body{background-color: #91C788;}
    #navibar{
        background-color:white;
        text-align: center;
        line-height:98px;
        min-height:100px;
        height:auto;
        font-weight: 600;
        font-size: large;
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
	.container{
        background-color: white;
        border:1px solid #ddd;
        margin:auto;
        text-align:center;
        position:relative;
        top:40px;
        max-width:1000px;
    }
    #box{width:100%;border-bottom:1px solid #184D47;}
    #other_id{text-align:center;border:1px solid rgb(180, 180, 180);font-weight: 600;}
    #period{color:gray;font-weight:600;}
    .btns{width:100%;height:100%;}
    h1{color:#feffe4e3;position: relative; top:320px; left:50px;}
    #addWrite{position:fixed;top:350px; left:93%;}
    .btns>button{position: relative;top:120px}
    </style>
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

    <div class="container rounded p-4 pt-5">
        <div class="row">
            <ul class="nav nav-tabs col-12" id="myTab" role="tablist">
                <li class="nav-item col-3" role="presentation">
                    <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">받은 쪽지함</a>
                </li>
                <li class="nav-item col-3" role="presentation">
                    <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">보낸쪽지함</a>
                </li>
            </ul>
            
        </div>
        <div class="tab-content row" id="myTabContent">
       		<div class="tab-pane fade show active col-12 pl-5 pr-5" id="home" role="tabpanel" aria-labelledby="home-tab"> 
                <c:forEach var="to" items="${tos}" varStatus="s"> <!-- 받은 쪽지함 -->
                <div class="row m-0 p-4" id="box">
                    <div class="col-8 p-0">
                        <div class="row m-0">
                            <div class="col-12 col-md-4 p-2 rounded" id="other_id">
                                ${to.send_id}
                            </div>
                        </div>
                        <div class="row m-0">
                            <div class="col-12 p-3" style="text-align: left;">
                                <h4 class="mb-3">${to.title }</h4>
                                <p>${to.contents }</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="btns">
                        	<c:choose>
                        		<c:when test="${to.pb_seq != 0 }">
                        			<button type="button" class="btn btn-outline-secondary petboard">내가 올린 글보기</button>
                            		<button type="button" class="btn btn-outline-success accept2">수락하기</button>
                            		<input type="hidden" class="seq" name="seq" value="${to.seq}">
                            		<input type="hidden" class="pb_seq" name="pb_seq" value="${to.pb_seq}">
                            		<input type="hidden" class="other_id" name="other_id" value="${to.send_id}">
                        		</c:when>
                        		<c:otherwise>
                        			<button type="button" class="btn btn-outline-success accept2">수락하기</button>
                            		<input type="hidden" class="seq" name="seq" value="${to.seq}">
                            		<input type="hidden" class="pb_seq" name="pb_seq" value="${to.pb_seq}">
                        		</c:otherwise>
                        	</c:choose>
                        </div>
                    </div>
                </div> 
                </c:forEach>			
            </div>
			<div class="tab-pane fade col-12 pl-5 pr-5" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                 <c:forEach var="send" items="${sends}" varStatus="s"> <!-- 보낸쪽지함 -->
                	<div class="row m-0 p-4" id="box">
                    	<div class="col-8 p-0">
                        	<div class="row m-0">
                            	<div class="col-12 col-md-4 p-2 rounded" id="other_id">
                                	${send.to_id}
                            	</div>
                        	</div>
                        	<div class="row m-0">
                            	<div class="col-12 p-3" style="text-align:left;">
                                	<h4 class="mb-3">${send.title }</h4>
                                	<p>${send.contents }</p>
                            	</div>
                        	</div>
                    	</div>
                    	<div class="col-4">
                        	<div class="btns">
                        	<c:choose>
                        		<c:when test="${send.pb_seq != 0 }">
                        			<button type="button" class="btn btn-outline-secondary petboard">게시글 보기</button>
                            		<button type="button" class="btn btn-outline-success accept1">취소하기</button>
                            		<input type="hidden" class="seq" name="seq" value="${send.seq}">
                            		<input type="hidden" class="pb_seq" name="pb_seq" value="${send.pb_seq}">
                        		</c:when>
                        		<c:otherwise>
                        			<button type="button" class="btn btn-outline-success accept1">취소하기</button>
                            		<input type="hidden" class="seq" name="seq" value="${send.seq}">
                            		<input type="hidden" class="pb_seq" name="pb_seq" value="${send.pb_seq}">
                        		</c:otherwise>
                        	</c:choose>
                        	</div>
                    	</div>
                	</div>
                </c:forEach>
            </div>			
        </div>
    </div>
</body>
</html>