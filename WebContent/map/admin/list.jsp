<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>산책 관리자 페이지</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<title>Document</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
	<style>
		.wrapper>div{float:left;}
		#side{margin-top:100px; width:250px; border:1px solid black;}
		#side>div{border:1px solid black;}
		#side a{text-decoration:none; color:black; }
		.container{width:1000px; margin-top:100px; margin-left:40px;}
		div{text-align:center;}
		.menu{height:60px; line-height:60px;}
		div[class*=col]{border:1px solid black; padding:0px;}
		.img>img{width:100%; height:100%;}
		.img{width:100px; height:100px;}
		.title{text-align:center; height:70px; line-height:70px;}
		#keyWord{width:250px;}
		.search>div{ text-align:right; padding:20px 0 20px 0px;}
		#pageList{text-align:center; margin: 30px 0px 60px 0px;}
		#pageList>a{color:black; font-size:17px;}
	</style>
	<script>
		$(function(){
			$(".delete").on("click",function(){
				
			})
			$(".update").on("click",function(){
				let course_name = $(this).parent().siblings(".course_name").text();
				location.href="${pageContext.request.contextPath}/detail.cos?course_name="+course_name;
			})
		})
	</script>
</head>
<body>
	<div class=wrapper>
		<div id=side>
			<div style="height:100px; line-height:100px;">산책 관리자 페이지</div>
			<div style="height:40px; line-height:40px;"><a href="${pageContext.request.contextPath}/map/admin/input.jsp">산책장소 추가하기</a></div>
			<div style="height:40px; line-height:40px;"><a href="${pageContext.request.contextPath}/cosList.cos?cpage=1">산책장소 목록</a></div>
			<div style="height:40px; line-height:40px;"><a href="${pageContext.request.contextPath}/getCourse.cos?course_area=종로구">산책사이트로 가기</a></div>
		</div>
		<div class="container p-0">
			<div class="row m-0 ">
					<div class="col-12 title">산책 정보 목록</div>
				</div>
			<form action="${pageContext.request.contextPath}/cosList.cos" method="get">
				<div class="row m-0 search">
					<div class="col-12"><input type=text name=keyWord id=keyWord> <input type=submit value=검색 id=search></div>
					<input type=hidden name=cpage value="1">
				</div>
			</form>
			<div class="row m-0 menu">
				<div class="col-1">자치구</div>
				<div class="col-2">장소이름</div>
				<div class="col-3">주소</div>
				<div class="col-2">우편번호</div>
				<div class="col-2">사진</div>
				<div class="col-2">기능</div>
			</div>
			
			<c:forEach var="i" items="${list}">
			<form action="${pageContext.request.contextPath}/delete.cos" method="post" class="adminF" enctype="multipart/form-data" >
			<div class="row m-0">
				<div class="col-1 pt-4">${i.course_area }</div>
				<div class="col-2 pt-4 course_name">${i.course_name }</div>
				<div class="col-3 pt-4">${i.address1 }</div>
				<div class="col-2 pt-4">${i.postcode }</div>
				<div class="col-2 img"><img src="map/img/${i.oriName }"></div>
				<div class="col-2 pt-4">
					<input type=submit value="삭제" class=delete>
					<input type=button value="수정" class=update>
					<input type=hidden value="${i.course_name }" name="course_name">
				</div>
			</div>
			</form>
		</c:forEach>
		
		<div id="pageList">
			<c:forEach var="i" items="${navi}" varStatus="s">
				<c:choose>
					<c:when test="${i =='>' }">
						<a
							href="${pageContext.request.contextPath}/cosList.cos?cpage=${navi[s.index-1]+1}&keyWord=${keyWord}">${i }</a>
					</c:when>
					<c:when test="${i =='<' }">
						<a
							href="${pageContext.request.contextPath}/cosList.cos?cpage=${navi[s.index+1]-1}&keyWord=${keyWord}">${i }</a>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${i==cpage }">
								<a
							href="${pageContext.request.contextPath}/cosList.cos?cpage=${i}&keyWord=${keyWord}" id=page  style="color:blue;">${cpage}</a>
							</c:when>
							<c:otherwise>
								<a
							href="${pageContext.request.contextPath}/cosList.cos?cpage=${i}&keyWord=${keyWord}" id=page>${i}</a>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			</div>
	
	
	
	</div>
	</div>
	
	
</body>
</html>