<%--
  Created by IntelliJ IDEA.
  User: dongh
  Date: 2023-12-03
  Time: 오후 2:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.Random" %>
<%@ page import="classes.SQLx" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../../common/dbconn.jsp" %>
<html>
<head>
    <title>InsertProc</title>
</head>
<body>
<%
    String[] data = new String[2];
    data[0] = request.getParameter("Owner_HP");
    data[1] = request.getParameter("Name");
    String sql = SQLx.Insertx("OWNER", data);
    pst = conn.prepareStatement(sql);
    pst.executeUpdate();
%>
<script>
    alert("성공적으로 삽입되었습니다.")
    window.location.href = "../../admin.jsp"
</script>
</body>
</html>
