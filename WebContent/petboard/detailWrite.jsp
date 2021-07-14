<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글상세페이지</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Sunflower:wght@300&display=swap" rel="stylesheet">
<style>
/* 글씨체 적용 */
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
/* 글 */
#wapper{position: relative; top:100px; max-width: 1000px;}
#category {text-align:center; border:3px solid black; font-weight:600; font-size:20px; line-height: 40px;}
#title{margin:0px; line-height: 40px; text-align:center; font-weight:600;}
.col-12>button{width:100%;}
#person_info{font-weight:600;}
.sub_title{font-weight:600;}
</style>
<script>
$(function(){
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
	
    // 펫시터 스크립트
	$("#delete").on("click", function(){
		let result = confirm("정말로 글을 삭제하시겠습니까? 한번 삭제된 글은 복구 할 수 없습니다.")
		if(result){
			location.href="${pageContext.request.contextPath}/deleteProc.pet?seq=${dto.seq}"
		}
	})
	$(".back").on("click",function(){
		location.href="${pageContext.request.contextPath}/petBoardList.pet?cpage=1";
	})
	$("#update").on("click",function(){
		if(${dto.id == "admin"}){
			location.href="${pageContext.request.contextPath}/adminUpdateWrite.pet?seq=${dto.seq}"
		}else{
			location.href="${pageContext.request.contextPath}/updateWrite.pet?seq=${dto.seq}"
		}
		
	})
	// 쪽지보내기
	$("#sendMsg").on("click",function(){
		$.ajax({
			url:"check.message",
				type:"get",
				data:{"pb_seq":${dto.seq}}
		}).done(function(resp){
			if(resp=='true'){
				alert("이미 일정이 생성된 게시글입니다.");
			}else{
				$("#messageModal").modal("show");
			}
		});
	})
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
	
	<div class="container p-4 mt-5 rounded shadow-lg bg-white" id="wapper">
		<div class="row p-2">
			<div class="col-12 col-md-3 rounded" id="category">${dto.category}</div>
			<div class="col-12 col-md-9">
				<h4 id="title">${dto.title}</h4>
			</div>
		</div>
		<hr>
		<div class="row p-2">
			<div class="col-3">글번호 : ${dto.seq}</div>
			<div class="col-3">작성자 : ${dto.id}</div>
			<div class="col-3">작성 일자 : ${dto.write_date}</div>
			<div class="col-3">조회수 : ${dto.view_count}</div>
		</div>
		<c:choose>
		<c:when test="${dto.id==\"admin\"}">
			<hr>
		</c:when>
		<c:otherwise>
		<div class="row p-2" id="person_info">
			<div class="col-12 col-md-3">지역 : ${dto.local}</div>
			<div class="col-12 col-md-3">이름 : ${dto.person_name}</div>
			<div class="col-12 col-md-3">나이 : ${dto.person_age}</div>
			<div class="col-12 col-md-3">성별 : ${dto.person_gender}</div>
		</div>
		<c:choose>
		<c:when test="${dto.pet_name!=null}">
		<div class="row p-2">
			<div class="col-12 col-md-3 sub_title">강아지 정보</div>
			<div class="col-12 col-md-3">${dto.pet_name}</div>
			<div class="col-12 col-md-3">${dto.pet_breed}</div>
			<div class="col-12 col-md-3">${dto.pet_age}</div>
		</div>
		<div class="row p-2">
			<div class="col-12 col-md-3"></div>
			<div class="col-12 col-md-3">${dto.pet_gender}</div>
			<div class="col-12 col-md-3">${dto.pet_feature}</div>
			<div class="col-12 col-md-3">강아지 중성화 여부 : ${dto.pet_neutering}</div>
		</div>
		</c:when>
		</c:choose>
		<div class="row p-2">
			<div class="col-12 col-md-3 sub_title">날짜</div>
			<div class="col-12 col-md-4">시작날짜 :
				${fn:substring(dto.start_date,0,10)}</div>
			<div class="col-12 col-md-4">끝나는 날짜 :
				${fn:substring(dto.end_date,0,10)}</div>
		</div>
		<div class="row p-2">
			<div class="col-12 col-md-3 sub_title">시간</div>
			<div class="col-12 col-md-4">시작시간 :
				${fn:substring(dto.start_date,10,16)}</div>
			<div class="col-12 col-md-4">끝나는 시간 :
				${fn:substring(dto.end_date,10,16)}</div>
		</div>
			<div class="row p-2">
			<div class="col-12 col-md-4">약속 장소</div>
			<div class="col-12 col-md-8">${dto.place_name}</div>
		</div>
		
		<hr>
		</c:otherwise>
		</c:choose>
		<div class="row p-2">
			<div class="col-12"><h5>${dto.contents}</h5></div>
		</div>
		<!-- 아이디 값으로 다른 것 들  -->
		<hr>
		<c:choose>
		<c:when test="${dto.id!=login.id&&login.id!=\"admin\"&&dto.id!=\"admin\"}">
		<div class="row p-2">
			<div class="col-12 col-md-6">
				<button type="button" id="sendMsg" class="btn btn-success">요청 보내기💌</button>
			</div>
			<div class="col-12 col-md-6">
				<button type="button" class="btn btn-success back">목록으로 돌아가기</button>
			</div>
		</div>
		</c:when>
		<c:when test="${dto.id!=\"admin\"&&login.id==\"admin\"}">
		<div class="row p-2">
			<div class="col-12 col-md-6">
				<button type="button" id="delete" class="btn btn-success">게시글 삭제하기</button>
			</div>
			<div class="col-12 col-md-6">
				<button type="button" class="btn btn-success back">목록으로 돌아가기</button>
			</div>
		</div>
		</c:when>
		<c:when test="${login.id!=\"admin\"&&dto.id==\"admin\"}">
			<div class="col-12 col-md-12">
				<button type="button" class="btn btn-success back">목록으로 돌아가기</button>
			</div>
		</c:when>
		<c:otherwise>
		<div class="row p-2">
			<div class="col-12 col-md-4">
				<button type="button" id="update" class="btn btn-success">게시글 수정하기</button>
			</div>
			<div class="col-12 col-md-4">
				<button type="button" id="delete" class="btn btn-success">게시글 삭제하기</button>
			</div>
			<div class="col-12 col-md-4">
				<button type="button" class="btn btn-success back">목록으로 돌아가기</button>
			</div>
		</div>
		</c:otherwise>
		</c:choose>
		<!-- 쪽지 moadal -->
		<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<form action="${pageContext.request.contextPath}/petboardAdd.message?pb_seq=${dto.seq}" method="post">
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
								<label for="taskId" class="col-form-label">받는 사람 : ${dto.id}</label><br>
								<input type="hidden" class="form-control" name="to_id" id="to_id" value="${dto.id}">
								<label for="taskId" class="col-form-label">제목</label> 
								<input type="text" class="form-control" id="title" name="title">
								<label for="taskId" class="col-form-label">내용</label>
								<textarea class="form-control" rows="8" name="contents" id="contents" placeholder="보내실 쪽지 내용을 입력해주세요."></textarea>
							</div>
						</div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-warning" id="sendMessage">쪽지보내기</button>
							<button type="button" class="btn btn-secondary" data-dismiss="modal" id="sprintSettingModalClose">취소</button>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>