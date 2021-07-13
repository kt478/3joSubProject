<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<link
	href="https://fonts.googleapis.com/css2?family=Sunflower:wght@300&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<style>
	*{font-family:Sunflower;}
	 #navibar{
        background-color:rgba(255, 255, 255, 0.945);
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

	.container{margin-top:100px; }
	#keyword{background-color:#ddd; height:60px;  line-height:60px; text-align:center; margin-bottom:20px;}
	.menu{border:1px solid #ddd; height:100px;   margin:auto; width:600px; padding: 15px 0px 0px 15px; position:relative;}
	.menu:hover{background-color:#ddd;}
	.menu>div{float:left;}
	.cosName{ font-weight:bold; font-size:18px; margin-bottom:10px;}
	.cosName>a{text-decoration:none; color:darkblue;}
	.img{ height:80px; width:100px; position:absolute; right:20px; top:10px;}
	.img>img{width:100%; height:100%;}
	#pageList{text-align:center; margin: 30px 0px 60px 0px;}
	#pageList>a{color:black; font-size:17px;}
	#page{padding:3px;}
	#text{text-align:center; margin-top:40px; font-size:20px; font-weight:bold; border:1px solid #ddd; height:180px; line-height:180px;}
</style>
	<script>
		$(function(){
			$("#searchImg").on("click",function(){
                $("#search").show("slow");
                $("#search").focus();
            })
            $("#search").on("blur",function(){
               $("#search").hide("slow");
            })
			// 펫시터
			$("#petsitter").on("click",function(){
					let result = confirm("로그인이 필요한 화면입니다 로그인 하시겠습니까?")
					if(result){
						location.href="signup/login.jsp";
					}
			})
			
			//네비바 검색창에서 검색기능
        	$("#search").on("keyup",function(e){
        		if(e.keyCode==13){
        			let search = $("#search").val();
        			location.href="${pageContext.request.contextPath}/search.cos?cpage=1&keyWord="+search;
        		}
        	})
			
			
		})
	</script>
</head>
<body>
	<!--네비바  -->
	<c:choose>
		<c:when test="${login.id==null}">
			<div class="container-fluid p-0" id="navibar">
				<div class="row m-0">
					<div class="col-12 col-lg-3 col-xl-2 p-0">
						<a href="${pageContext.request.contextPath}/main.jsp"><img src="project_logo.jpg"></a>
					</div>
					<div class="col-3 col-lg-2 col-xl-1 p-0 navitext">
						<a href="${pageContext.request.contextPath}/getCourse.cos?course_area=종로구">산책장소</a>
					</div>
					<div class="col-3 col-lg-2 col-xl-1 p-0 navitext" >
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
						<a href="#">회원가입</a>
					</div>
					<div class="col-6 col-lg-4 col-xl-1 p-0 navitext">
						<a href="signup/login.jsp">로그인</a>
					</div>
				</div>

			</div>
		</c:when>
		<c:otherwise>
			<div class="container-fluid p-0" id="navibar">
				<div class="row m-0">
					<div class="col-12 col-lg-3 col-xl-2 p-0">
						<a href="${pageContext.request.contextPath}/main.jsp"><img src="project_logo.jpg"></a>
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
						<a href="${pageContext.request.contextPath}/logout.mem">로그아웃</a>
					</div>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
    <!-- END nav -->


	<div class=container>
		<div id=keyword>"${keyWord}"를 검색하였습니다.</div>
		<c:forEach var="list" items="${list}">
		<c:choose>
			<c:when test="${list!=null }">
				<div class=menu>
				<div>
					<div class=cosName>
						<a
							href="${pageContext.request.contextPath}/getCourse.cos?course_name=${list.course_name}">${list.course_name }</a>
					</div>
					<div class=add1>${list.address1 }</div>
				</div>
				<div class=img>
					<img src="map/img/${list.oriName }">
				</div>
			</div>
			</c:when>
		</c:choose>
			
		</c:forEach>
		<c:choose>
			<c:when test="${listSize =='0' }">
				<div id=text>검색된 내용이 없습니다.</div>
			</c:when>
		</c:choose>
		
		<div id="pageList">
		<c:forEach var="i" items="${navi}" varStatus="s">
			<c:choose>
				<c:when test="${i =='>' }">
					<a
						href="${pageContext.request.contextPath}/search.cos?cpage=${navi[s.index-1]+1}&keyWord=${keyWord}">${i }</a>
				</c:when>
				<c:when test="${i =='<' }">
					<a
						href="${pageContext.request.contextPath}/search.cos?cpage=${navi[s.index+1]-1}&keyWord=${keyWord}">${i }</a>
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${i==cpage }">
							<a
						href="${pageContext.request.contextPath}/search.cos?cpage=${i}&keyWord=${keyWord}" id=page  style="color:blue;">${cpage}</a>
						</c:when>
						<c:otherwise>
							<a
						href="${pageContext.request.contextPath}/search.cos?cpage=${i}&keyWord=${keyWord}" id=page>${i}</a>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		</div>
	</div>
</body>
</html>