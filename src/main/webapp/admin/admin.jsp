<%--
  Created by IntelliJ IDEA.
  User: 황경모
  Date: 2023-12-01
  Time: 오후 10:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="classes.SQLx" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/dbconn.jsp" %>
<html>
<head>
    <title>Admin page</title>
    <a href="../index.jsp">Soccer Link</a><br>
    <%
        String sqlIncome = SQLx.Selectx("SUM(PREPAID_MONEY)", "MEMBER");
        String sqlOutMatch = SQLx.Selectx("SUM(WAGE)", "MATCH");
        String sqlOutTrain = SQLx.Selectx("SUM(WAGE)", "TRAINING");
        pst = conn.prepareStatement(sqlIncome);
        rs = pst.executeQuery();
        rs.next();
        out.println("총 예치금 : "+rs.getInt(1));
        pst = conn.prepareStatement(sqlOutMatch);
        rs = pst.executeQuery();
        rs.next();
        out.println("소셜매치 지불금액 : "+rs.getInt(1));
        pst = conn.prepareStatement(sqlOutTrain);
        rs = pst.executeQuery();
        rs.next();
        out.println("트레이닝 지블금액 : "+rs.getInt(1));
    %>
</head>
<body>
<br>
<a href="userMod.jsp">User</a>
<a href="teamMod.jsp">Team</a>
<a href="ownerMod.jsp">Owner</a>
<a href="fieldMod.jsp">Field</a>
<a href="matchMod.jsp">Match</a>
<a href="trainMod.jsp">Training</a>
<a href="checkInfo.jsp">Check Info</a>
<br>
<%
    out.println("안녕하세요, 관리자님");
    out.println("상단 메뉴를 통해 관리할 DB를 선택해주시길 바랍니다.");
%>
</body>
</html>