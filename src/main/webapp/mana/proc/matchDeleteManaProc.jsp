<%@ page import="classes.SQLx" %>
<%@ page import="classes.SessionConst" %>
<%@ include file="../../common/dbconn.jsp" %>
<%--
  Created by IntelliJ IDEA.
  User: 황경모
  Date: 2023-12-05
  Time: 오후 1:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    String[] matchId = {request.getParameter("matchId")};
    String userId = (String) session.getAttribute(SessionConst.USER);
    try {
        String appManaMatchSql = SQLx.Updatex("MATCH", "MANAGER_ID", "", matchId);
        pst = conn.prepareStatement(appManaMatchSql);
        pst.executeQuery();
    }catch(SQLException e){
%>
<script>
    alert("취소에 실패했습니다.");
    history.go(-1);
</script>
<%
    }
//    System.out.println(matchId);
%>
<script>
    alert("<%=matchId[0]%> 경기가 취소되었습니다.");
    window.location.href = "../manager.jsp";
</script>

</body>
</html>
