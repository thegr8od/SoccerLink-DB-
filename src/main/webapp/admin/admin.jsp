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
    <a href="../index.jsp">Soccer Link</a>
    <a href="../common/logOutProc.jsp">Log Out</a>
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
        out.println("트레이닝 지불금액 : "+rs.getInt(1));
    %>
</head>
<body>
<br>
<input type="button" value="User" name="1" onclick="location.href='userMod.jsp'"/>
<input type="button" value="Team" name="2" onclick="location.href='teamMod.jsp'"/>
<input type="button" value="Owner" name="3" onclick="location.href='ownerMod.jsp'"/>
<input type="button" value="Field" name="4" onclick="location.href='fieldMod.jsp'"/>
<input type="button" value="Match" name="5" onclick="location.href='matchMod.jsp'"/>
<input type="button" value="Training" name="6" onclick="location.href='trainMod.jsp'"/>
<input type="button" value="Check Information" onclick="location.href='checkInfo.jsp'"/>
<br>
<%
    out.println("안녕하세요, 관리자님");
    out.println("상단 메뉴를 통해 관리할 DB를 선택해주시길 바랍니다.");
%>
</body>
</html>