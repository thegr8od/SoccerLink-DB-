<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="classes.SessionConst" %>
<%@ page import="classes.SQLx" %>
<%@ include file="../common/dbconn.jsp" %>

<html>
<head>
    <title>팀 신청 처리</title>
</head>
<body>
<%
    String userId = (String) session.getAttribute(SessionConst.USER);
    String teamId = request.getParameter("teamId");
    String[] data = {teamId, userId};
    String insertQuery = SQLx.Insertx("TEAM_MEM", data);

    try {
        PreparedStatement pstmt = conn.prepareStatement(insertQuery);
        int result = pstmt.executeUpdate();

        if (result > 0) {
            out.println("<p>팀 신청이 완료되었습니다.</p>");
        } else {
            out.println("<p>팀 신청에 실패하였습니다.</p>");
        }
    } catch (SQLException e) {
        out.println("<p>오류 발생: " + e.getMessage() + "</p>");
    }
%>
<a href="team.jsp">팀 목록으로 돌아가기</a>
</body>
</html>
