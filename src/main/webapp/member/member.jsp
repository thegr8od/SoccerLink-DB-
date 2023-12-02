<%--
  Created by IntelliJ IDEA.
  User: 황경모
  Date: 2023-12-01
  Time: 오후 11:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<%--home 버튼--%>
<a href="../index.jsp">Soccer Link</a>

<%--Secession 버튼--%>
<input type = "button" onclick="secession()" value="Secession">
<script>
    function secession(){
        const askTwice = prompt("정말로 탈퇴를 원하시면 '탈퇴'를 입력하십시오.");
        if(askTwice==='탈퇴'){
            window.location.href = "../common/secessionProc.jsp"
        }
        else{
            alert("잘못 입력했습니다.");
        }
    }
</script>

</body>
</html>
