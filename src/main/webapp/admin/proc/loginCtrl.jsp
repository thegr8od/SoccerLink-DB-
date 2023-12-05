<%@ page import="classes.SessionConst" %><%--
  Created by IntelliJ IDEA.
  User: dongh
  Date: 2023-12-05
  Time: 오후 12:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        String userId = (String) session.getAttribute(SessionConst.USER);
        if(userId == null || userId.equals("")){
    %>
    <script>
        alert("세션이 만료되었습니다.")
        window.location.href = "../../common/login.jsp"
    </script>
    <%}%>
</head>
<body>

</body>
</html>
