<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에러페이지</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<style>
.container{position: relative; top:100px;text-align: center;}
.Btn{width:40%; position:absolute; left:460px;}
</style>
<body>
<body>
    <div class="container">
        <div class="row">
            <h3 class="col-12 p-2">요청하신 페이지를 찾을 수 없습니다.</h3>
            <p class="col-12">- 홈페이지 주소가 정확한지 확인 바랍니다.</p>
            <p class="col-12">- 에러가 계속 된다면 관리자(admin@naver.com)에게 문의 바랍니다.
        </div>
            <img src="404.png">
        <div class="row p-4 Btn">
            <a href="${pageContext.request.contextPath}/main.jsp"><button class="btn btn-light col-12">메인페이지로 돌아가기</button></a>
        </div>
    </div>
</body>
</html>