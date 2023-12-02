<%@ page import="classes.SQLx" %>
<%@ page import="classes.SessionConst" %>
<%@ include file="dbconn.jsp" %>
<%--
  Created by IntelliJ IDEA.
  User: 황경모
  Date: 2023-12-02
  Time: 오전 2:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<%
    String userId = (String) session.getAttribute(SessionConst.USER);
    String[] userIdArr = {userId};
    String secessionUser = SQLx.Deletex("USERS",userIdArr);
    pst = conn.prepareStatement(secessionUser);
    rs = pst.executeQuery();
%>
<script>
    alert("성공적으로 탈퇴되었습니다.")
    window.location.href = "index.jsp"
</script>
</body>
</html>
