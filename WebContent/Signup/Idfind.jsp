<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>


</head>
<body>
					<form action="IdFind.idf" method="post">
                             <input type="text" size="20" name="userName" placeholder="이름을 입력해주세요" required>
                               <br class="clear">
                            <p>전화번호:</p>
                               <input type="text" size="20" name="userNumber" placeholder=" - 를 제외한 번호 전체를 입력해주세요." required>
                                <br class="clear">
                                <p>이메일:</p>
                                <input type="text" size="20" name="userEmail" placeholder=" 이메일을입력해주세요." required>
                                <br class="clear">

                            

                            <input type="submit" value="FIND ID" class="findid">
                                   </form>
                                   
</body>


</html>