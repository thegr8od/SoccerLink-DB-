<%@ page import="java.sql.ResultSet" %>
<%--
  Created by IntelliJ IDEA.
  User: 황경모
  Date: 2023-12-01
  Time: 오후 10:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<!--홈화면-->
<a href="/index.jsp">Soccer Link</a>
</br>
<form action="signUpProc.jsp" method="post">
    <!--비밀번호-->
    <label>Password : </label>
    <input type="password" name="pw" id="pw" minlength="9" maxlength="20" required>
    </br>
    <!--이름-->
    <label>Name : </label>
    <input type="text" name="name" id="name" maxlength="30" required>
    </br>
    <!--성별-->
    <label>Sex : </label>
    <select name="sex">
        <option value="M">Male</option>
        <option value="F">Female</option>
    </select>
    </br>
    <!--연도-->
    <label for="year">Year of Birth :</label>
    <input type="text" id="year" name="year" pattern="\d{4}" title="연도 형식은 YYYY여야 합니다." maxlength="4" required>
    </br>
    <!--직업-->
    <label>Job : </label>
    <input type="text" name="job" id="job" maxlength="100" required>
    </br>
    <!--매니저 or 멤버-->
    <label>Role : </label>
    <select name="role">
        <option value="manager">Manager</option>
        <option value="member">Member</option>
    </select>
    </br>
    <label>Bank accout (manager only) : </label>
    <input type = "text" name = "bankAccount" id = "bankAccout">
    </br>
    <input type="submit" value="signIn">
</form>

</body>
</html>
