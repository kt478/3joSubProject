<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펫시터 메인</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
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
    #naviSearch{
        width:250px; height:40px;
        position: absolute;
        top:40px;
        left: 30px;
        display: none;
    }
    #searchImg{position: absolute;top:40px;}
    #searchImg:active~#naviSearch{left:0px;}
    #searchBox{width:300px;}
    #loginNavi{min-width: 150px;}
    #loginNavi>a{color:black;}
    #loginNavi>a:link{text-decoration:none;}
    #loginNavi>a:hover{color: #52734D;border-bottom:3px solid #52734D;}
    #loginNavi>a:visited{color: black;}
    #naviSearch{
        width:250px; height:40px;
        position: absolute;
        top:40px;
        left: 30px;
        display: none;
    }
/* 페이지전체 navi Style 부분 끝 */
/* head */
.header{background-color:#91C788; width:100%;height:400px;}
h1{position:relative; top:150px; color:black;}
/* 검색 기능 */
#search{height:40px;}
#keyword{width:300px;}
.box1{display:none;}
.box2{display:none;}
#search2{display:none;}
/* 게시글 */
.category{text-align:center; border:3px solid gray; font-weight:600; font-size:20px}
.period{color:gray;font-weight:600; font-size:20px;}
.local{color:gray;font-weight:600; font-size:20px;}
#body{max-width:1000px;}
.list{border-bottom:1px solid black;}
.footer{color:gray;}
/* 페이징 */
.footerNavi{text-align:center; padding:0px; font-size:20px;}
.footerBtn{text-align:right; padding-top:5px;}
.page{color:black;}
</style>
<script>
    $(function(){
    	// 네비바 검색창 보이게
    	$("#searchImg").on("click", function() {
    		$("#naviSearch").show("slow");
    		$("#naviSearch").focus();
    	})
    	$("#naviSearch").on("blur", function() {
    		$("#naviSearch").hide("slow");
    	})

    	//네비바 검색창에서 검색기능
    	$("#naviSearch").on("keyup",function(e) {
    		if (e.keyCode == 13) {
    			let search = $("#naviSearch").val();
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
         // 로그인 플렸을 때 글쓰기 누르면 백지 아니고 로그인 화면으로 보내 주는 거
        $(".addWrite").on("click",function(){
        	if(${login.id==null}){
        		alert("로그인이 필요한 화면입니다.");
        		location.href = "${pageContext.request.contextPath}/Signup/login.jsp";
        	}else if(${login.id=="admin"}){
        		//alert("관리자 염병");
        		location.href = "${pageContext.request.contextPath}/adminPetWrite.pet";
        	}else{
        		location.href = "${pageContext.request.contextPath}/petBoardWrite.pet";
        	}
         })
        // 검색기능 함수
        $("#search").change(function(){
            if($('select option:selected').val() == "category"){
            $('.box1').hide();
            $('.box2').show();
            $("#search2").show();
        }else if($('select option:selected').val() == "all"){
           $('.box1').hide();
           $('.box2').hide();
           $("#search2").hide();
        }else{
           $('.box1').show();
           $('.box2').show();
           $("#search2").hide();
           $("#keyword").attr("style","width:100%")
        }
        })
        // 검색 컨트롤러
        $("#searchBtn").on("click",function(){
          let search = $("select[name=search]").val();
          let keyword = $("#keyword").val();
          let search2 = $("select[name=search2]").val();
          location.href="${pageContext.request.contextPath}/petBoardList.pet?cpage=1&search="+search+"&search2="+search2+"&keyword="+keyword;
      })
      // 페이지 메인으로 돌아가기
      $(".mainBack").on("click",function(){
         location.href = "${pageContext.request.contextPath}/petBoardList.pet?cpage=1";
      })
      
     // 로그인 풀렸을 때 
	$("#petsitter").on("click", function() {
			let result = confirm("로그인이 필요한 화면입니다 로그인 하시겠습니까?")
				if (result) {
					location.href = "Signup/login.jsp";
					} else {
						location.href = "main.jsp";
					}
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
			                <input type="search" placeholder="원하는구,장소를 검색하세요." class="form-control me-2 ml-3" id="naviSearch">
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
                         <input type="search" placeholder="원하는구,장소를 검색하세요." class="form-control me-2 ml-3" id="naviSearch">
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
			                <input type="search" placeholder="원하는구,장소를 검색하세요." class="form-control me-2 ml-3" id="naviSearch">
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
    <!-- 글쓰기 버튼 -->
       <div class="row">
          <div class="col-12 header" style="background-image: url('petboard/img22.jpg');">
              <h1>Accompany & Pet Sitter</h1>
             </div>
       </div>
    <!-- 검색 기능 -->
      <div class="container p-3">
                <!-- 검색 타입 선택 리스트 -->
           <div class="row">
                <select  id="search" name="search" class="col-12 col-md-2 rounded">
                   <option value="all">전체</option>
                     <option value="category">카테고리</option>
                    <option value="title">제목</option>
                    <option value="id">작성자</option>
                </select>
                <select id="search2" name="search2" class="col-12 col-md-2 rounded">
                   <option value="">--선택--</option>
                  <option value="산책 동행">산책 동행</option>
               <option value="펫시터 구해요">펫시터 구해요</option>
               <option value="펫시터 합니다">펫시터 합니다</option>
                </select>
                <!-- 키워드 입력 부분 -->
               <div class="col-12 col-md-6 box1">
                   <input class="form-control me-2 ml-3" type="text" id="keyword" name="keyword" placeholder="검색할 내용을 입력하세요">
               </div>
                <!-- 검색 버튼 -->
               <div class="col-12 col-md-2 box2">
                   <button type="submit" id="searchBtn" class="btn btn-success">검색</button>
                 </div>
            </div>                  
        </div>
    <!-- 게시글 리스트 -->
    <div class="container p-3" id="body">
         <!-- 이거 box하나가 1개 컨텐츠로 잡고 포리치돌리면 될듯? -->
        <c:forEach var="i" items="${list}" varStatus="s">
           <div class="row m-0 p-4 list" onclick="location.href='${pageContext.request.contextPath}/detailWrite.pet?seq=${i.seq}'" style="cursor:pointer;">
           <div class="col-9 p-0">
                <div class="row m-0">
                    <div class="col-12 col-md-3 p-2 category rounded">${i.category}</div>
                    <c:choose>
                    <c:when test="${i.id==\"admin\"}">
                    </c:when>
                    <c:otherwise>
                    <div class="col-12 col-md-5 pl-4 pt-3 period">${fn:substring(i.start_date,0,10)} ~ ${fn:substring(i.end_date,0,10)}</div>
                    <div class="col-12 col-md-4 pl-4 pt-3 local">${i.local}</div>
                    </c:otherwise>
                    </c:choose>
                </div>
               <div class="row m-0">
                    <div class="col-12 p-3">
                        <h4 class="mb-3">${i.title}</h4>
                    </div>
                </div>
                <div class="row m-0 footer">
                    <div class="col-12 col-md-3">글번호 : ${i.seq}</div>
                    <div class="col-12 col-md-3">작성자 : ${i.id}</div>
                    <div class="col-12 col-md-4">작성일자 : ${i.write_date}</div>
                    <div class="col-12 col-md-2">조회수 : ${i.view_count}</div>
                </div>
            </div>  
            </div>
        </c:forEach>
        <!-- 페이징 3가지 -->
            <c:choose>
               <c:when test="${search==null}">
                     <div class="row">
                        <div class="col-12 col-md-4 p-2"><button class="btn btn-light addWrite">게시판 글 쓰러 가기</button></div>
                        <div class="col-12 col-md-4 p-2 footerNavi">
                  <c:forEach var="i" items="${navi}" varStatus="s">
                     <c:choose>
                        <c:when test="${ i == '>' }">
                           <a href="${pageContext.request.contextPath}/petBoardList.pet?cpage=${navi[s.index-1]+1}" class="page">${i}</a>
                        </c:when>
                        <c:when test="${ i == '<' }">
                           <a href="${pageContext.request.contextPath}/petBoardList.pet?cpage=${navi[s.index+1]-1}" class="page">${i}</a>
                        </c:when>
                        <c:otherwise>
                           <a href="${pageContext.request.contextPath}/petBoardList.pet?cpage=${i}" class="page">${i}</a>
                        </c:otherwise>
                     </c:choose>
                  </c:forEach>
                        </div>
                        <div class="col-12 col-md-4 footerBtn">
                           <button type="button" class="btn btn-light mainBack">게시글 첫 화면으로</button>
                        </div>
                     </div>
               </c:when>
               <c:when test="${search eq 'category' && search2 ne null}">
                     <div class="row">
                        <div class="col-12 col-md-4 p-2"><button class="btn btn-light addWrite">게시판 글 쓰러 가기</button></div>
                        <div class="col-12 col-md-4 p-2 footerNavi">
               <c:forEach var="i" items="${navi}" varStatus="s">
                  <c:choose>
                  <c:when test="${ i == '>' }">
                     <a href="${pageContext.request.contextPath}/petBoardList.pet?cpage=${navi[s.index-1]+1}&search=${search}&search2=${search2}&keyword=">${i}</a>
                  </c:when>
                  <c:when test="${ i == '<' }">
                     <a href="${pageContext.request.contextPath}/petBoardList.pet?cpage=${navi[s.index+1]-1}&search=${search}&search2=${search2}&keyword=">${i}</a>
                  </c:when>
                  <c:otherwise>
                     <a href="${pageContext.request.contextPath}/petBoardList.pet?cpage=${i}&search=${search}&search2=${search2}&keyword=">${i}</a>
                  </c:otherwise>
                  </c:choose>
               </c:forEach>
                        </div>
                        <div class="col-12 col-md-4 p-2 footerBtn">
                           <button type="button" class="btn btn-light mainBack">게시글 첫 화면으로</button>
                        </div>
                     </div>
               </c:when>
               <c:when test="${keyword ne null && search ne null}">
                     <div class="row">
                        <div class="col-12 col-md-4 p-2"><button class="btn btn-light addWrite">게시판 글 쓰러 가기</button></div>
                        <div class="col-12 col-md-4 footerNavi">
               <c:forEach var="i" items="${navi}" varStatus="s">
                  <c:choose>
                  <c:when test="${ i == '>' }">
                     <a href="${pageContext.request.contextPath}/petBoardList.pet?cpage=${navi[s.index-1]+1}&search=${search}&search2=&keyword=${keyword}">${i}</a>
                  </c:when>
                  <c:when test="${ i == '<' }">
                     <a href="${pageContext.request.contextPath}/petBoardList.pet?cpage=${navi[s.index+1]-1}&search=${search}&search2=&keyword=${keyword}">${i}</a>
                  </c:when>
                  <c:otherwise>
                     <a href="${pageContext.request.contextPath}/petBoardList.pet?cpage=${i}&search=${search}&search2=&keyword=${keyword}">${i}</a>
                  </c:otherwise>
                  </c:choose>
               </c:forEach>
                        </div>
                        <div class="col-12 col-md-4 footerBtn">
                           <button type="button" class="btn btn-light mainBack">게시글 첫 화면으로</button>
                        </div>
                     </div>
               </c:when>
            </c:choose>
    </div>
</body>
</html>