<%--
  Created by IntelliJ IDEA.
  User: 황경모
  Date: 2023-12-01
  Time: 오후 10:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<a href="/index.jsp">Soccer Link</a>
</br>
<form action="logInProc.jsp" method="post">
    <label>ID : </label>
    <input type="text" name="id" id="id">
    </br>
    <label>PW : </label>
    <input type="text" name="pw" id="pw">
    </br>
    <input type="submit"value="Log in">
    </br>
    <input type="button"value="Sign Up" onclick="window.location.href='signUp.jsp'">
</form>

</body>
</html>
