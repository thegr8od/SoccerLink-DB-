<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="classes.SQLx" %>
<%@ page import="classes.SessionConst" %>
<%@ include file="../common/dbconn.jsp" %>

<html>
<head>
    <title>내 트레이닝 보기</title>
</head>
<body>
<h1>내 트레이닝 목록</h1>
<table border="1">
    <tr>
        <th>트레이닝 ID</th>
        <th>날짜/시간</th>
        <th>주제</th>
        <th>강사</th>
    </tr>
    <%
        String userId = (String) session.getAttribute(SessionConst.USER);
        String query = "SELECT T.CLASS_ID, T.DATE_TIME, T.SUBJECT, U.NAME FROM TRAINING T INNER JOIN TRAIN_ENROLLS E ON T.CLASS_ID = E.CLASS_ID INNER JOIN USERS U ON T.TUTOR_ID = U.ID_NUMBER WHERE E.TUTEE_ID = '" + userId + "'";
        PreparedStatement pstmt = conn.prepareStatement(query);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            String classId = rs.getString("CLASS_ID");
            Timestamp dateTime = rs.getTimestamp("DATE_TIME");
            String subject = rs.getString("SUBJECT");
            String tutorName = rs.getString("NAME");
    %>
    <tr>
        <td><%= classId %></td>
        <td><%= dateTime.toString() %></td>
        <td><%= subject %></td>
        <td><%= tutorName %></td>
    </tr>
    <%
        }
    %>
</table>
<a href="training.jsp">뒤로 가기</a>
</body>
</html>
