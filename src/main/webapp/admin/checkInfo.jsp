<%--
  Created by IntelliJ IDEA.
  User: dongh
  Date: 2023-12-02
  Time: 오후 4:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin page - Check information</title>
    <a href="../index.jsp">Soccer Link</a>
    <a href="../index.jsp">Log Out</a>
</head>
<body>
조회할 것을 선택해 주세요.
<a href="admin.jsp">Back</a><br>
<form action="checkProc.jsp" method="post" target="procFrame">
<label>
    <select name="checker">
        <option value="1">소유주 및 구장</option>
        <option value="2">소셜매치</option>
        <option value="3">트레이닝</option>
    </select>
</label>
<input type="submit" value="submit"><br>
</form>
<iframe name = "procFrame" src="checkProc.jsp" width="100%" height="3000">
</iframe>
</body>
</html>
