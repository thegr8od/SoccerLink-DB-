<%--
  Created by IntelliJ IDEA.
  User: dongh
  Date: 2023-12-02
  Time: 오후 4:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="classes.SQLx" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/dbconn.jsp" %>
<html>
<head>
    <title>Admin page - Check information</title>
</head>
<body>
조회할 것을 선택해 주세요.
<form action="checkProc.jsp" method="post"></form>
<select name="checker">
    <option value="1">구장 및 소유주</option>
    <option value="2">소셜매치</option>
    <option value="3">트레이닝</option>
</select>
<input type="submit" value="submit">

</body>
</html>
