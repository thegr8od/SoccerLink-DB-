<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="classes.SessionConst" %>
<%@ page import="classes.SQLx" %>
<%@ include file="../common/dbconn.jsp" %>

<html>
<head>
    <title>나의 팀 정보</title>
</head>
<body>
<h1>나의 팀 정보</h1>
<%
    String userId = (String) session.getAttribute(SessionConst.USER);
    String query = SQLx.Selectx("T.TEAM_ID, T.TEAM_NAME", "TEAM_MEM TM INNER JOIN TEAM T ON TM.TEAM_ID = T.TEAM_ID", "TM.MEM_ID = '" + userId + "'", "");
    PreparedStatement pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();

    if (rs.next()) {
        String teamId = rs.getString("TEAM_ID");
        String teamName = rs.getString("TEAM_NAME");
%>
<p>팀 ID: <%= teamId %></p>
<p>팀 이름: <%= teamName %></p>
<%
    } else {
        out.println("<p>가입된 팀이 없습니다.</p>");
    }
%>
<a href="team.jsp">뒤로 가기</a>
</body>
</html>
