<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="classes.SessionConst" %>
<%@ page import="classes.SQLx" %>
<%@ include file="../common/dbconn.jsp" %>

<html>
<head>
    <title>팀 탈퇴</title>
</head>
<body>


<%
    String userId = (String) session.getAttribute(SessionConst.USER);
    String[] keys = {userId};


    String deleteQuery = SQLx.Deletex("TEAM_MEM", keys);
    try {
        PreparedStatement pstmt = conn.prepareStatement(deleteQuery);
        int result = pstmt.executeUpdate();

        if (result > 0) {
            out.println("<p>팀 탈퇴가 완료되었습니다.</p>");
        } else {
            out.println("<p>팀 탈퇴에 실패하였습니다.</p>");
        }
    } catch (SQLException e) {
        out.println("<p>오류 발생: " + e.getMessage() + "</p>");
    }
%>
</body>
</html>
