<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="classes.SQLx" %>
<%@ page import="classes.SessionConst" %>
<%@ include file="../common/dbconn.jsp" %>

<html>
<head>
    <title>트레이닝 목록</title>
</head>
<body>
<h1>트레이닝 목록</h1>
<a href="viewMyTraining.jsp"><button>View My Training</button></a>
<a href="makeTraining.jsp"><button>Make Training</button></a>
<table border="1">
    <tr>
        <th>트레이닝 ID</th>
        <th>날짜/시간</th>
        <th>주제</th>
        <th>현재 인원/최대 인원</th>
        <th>비용</th>
        <th>신청</th>
    </tr>
    <%
        String query = "SELECT T.*, (SELECT COUNT(*) FROM TRAIN_ENROLLS WHERE CLASS_ID = T.CLASS_ID) AS CURRENT_NUM FROM TRAINING T";
        PreparedStatement pstmt = conn.prepareStatement(query);
        ResultSet trainingResultSet = pstmt.executeQuery();
        while (trainingResultSet.next()) {
            String classId = trainingResultSet.getString("CLASS_ID");
            Timestamp dateTime = trainingResultSet.getTimestamp("DATE_TIME");
            String subject = trainingResultSet.getString("SUBJECT");
            int maxNum = trainingResultSet.getInt("MAX_NUM");
            int currentNum = trainingResultSet.getInt("CURRENT_NUM");
            double costPerOne = trainingResultSet.getDouble("COST_PER_ONE");
            boolean isFull = currentNum >= maxNum;
    %>
    <tr>
        <td><%= classId %></td>
        <td><%= dateTime.toString() %></td>
        <td><%= subject %></td>
        <td><%= currentNum + "/" + maxNum %></td>
        <td><%= costPerOne %>원</td>
        <td>
            <% if (!isFull) { %>
            <form action="enrollTrain.jsp" method="post">
                <input type="hidden" name="classId" value="<%= classId %>">
                <input type="submit" value="신청하기">
            </form>
            <% } else { %>
            인원이 꽉 찼습니다.
            <% } %>
        </td>
    </tr>
    <%
        }
    %>
</table>
</body>
</html>