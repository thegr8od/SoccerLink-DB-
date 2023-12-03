<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ include file="../common/dbconn.jsp" %>
<%@ page import="classes.SQLx" %>

<html>
<head>
    <title>팀 목록 및 신청</title>
</head>
<body>
<a href="viewMyTeam.jsp"><button>View My Team</button></a>
<a href="deleteMyTeam.jsp"><button>Delete My Team</button></a>
<h1>팀 목록 및 신청</h1>

<table border="1">
    <tr>
        <th>팀 ID</th>
        <th>팀 이름</th>
        <th>신청</th>
    </tr>
    <%
        String query = SQLx.Selectx("TEAM_ID, TEAM_NAME", "TEAM", "");
        PreparedStatement pstmt = conn.prepareStatement(query);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            String teamId = rs.getString("TEAM_ID");
            String teamName = rs.getString("TEAM_NAME");
    %>
    <tr>
        <td><%= teamId %></td>
        <td><%= teamName %></td>
        <td>
            <form action="processTeamApplication.jsp" method="post">
                <input type="hidden" name="teamId" value="<%= teamId %>">
                <input type="submit" value="신청하기">
            </form>
        </td>
    </tr>
    <%
        }
    %>ㅁ
</table>
<a href="member.jsp">뒤로 가기</a>
</body>
</html>