<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="classes.SQLx" %>
<%@ page import="classes.SessionConst" %>
<%@ include file="../common/dbconn.jsp" %>

<html>
<head>
    <title>팀 삭제</title>
</head>
<body>
<h1>나의 팀 삭제</h1>
<form method="post">
    <table border="1">
        <tr>
            <th>팀 ID</th>
            <th>팀 이름</th>
            <th>선택</th>
        </tr>
        <%
            String userId = (String) session.getAttribute(SessionConst.USER);
            String selectedTeamId = request.getParameter("selectedTeamId");

            if (selectedTeamId != null && !selectedTeamId.isEmpty()) {
                // TEAM_MEM에서 선택된 팀 기록 삭제
                String deleteQuery = SQLx.Deletex("TEAM_MEM", new String[]{selectedTeamId, userId});
                PreparedStatement deletePstmt = conn.prepareStatement(deleteQuery);
                int deleteResult = deletePstmt.executeUpdate();

                if (deleteResult > 0) {
                    out.println("<p>팀 탈퇴가 완료되었습니다.</p>");
                } else {
                    out.println("<p>팀 탈퇴에 실패했습니다.</p>");
                }
            }

            // 현재 속한 팀 목록 표시
            String query = SQLx.Selectx("T.TEAM_ID, T.TEAM_NAME", "TEAM_MEM TM INNER JOIN TEAM T ON TM.TEAM_ID = T.TEAM_ID", "TM.MEM_ID = '" + userId + "'", "");
            PreparedStatement pstmt = conn.prepareStatement(query);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                String teamId = rs.getString("TEAM_ID");
                String teamName = rs.getString("TEAM_NAME");
        %>
        <tr>
            <td><%= teamId %></td>
            <td><%= teamName %></td>
            <td><input type="radio" name="selectedTeamId" value="<%= teamId %>"></td>
        </tr>
        <%
            }
        %>
    </table>
    <input type="submit" value="팀 삭제">
</form>
<a href="team.jsp">뒤로 가기</a>
</body>
</html>
