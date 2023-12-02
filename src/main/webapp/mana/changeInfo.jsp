<%--
  Created by IntelliJ IDEA.
  User: 황경모
  Date: 2023-12-03
  Time: 오전 3:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
직업 변경:
<input type = "text" name = "job" id = "job">
<input type ="button" onclick = "window.location.href ='changeJobProc.jsp'" value= "Change Job">
</br>
비밀번호 변경:
<input type = "text" name = "pw" id = "pw">
<input type ="button" onclick = "window.location.href ='changePwProc.jsp'" value= "Change Password">
</br>
계좌 변경:
<input type = "text" name = "bankAccount" id = "bankAccount">
<input type ="button" onclick = "window.location.href ='changeAccountProc.jsp'" value= "Change Bank Account">
</br>
</body>
</html>
