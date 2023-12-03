<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="classes.SQLx" %>
<%@ page import="classes.SessionConst" %>
<%@ include file="../common/dbconn.jsp" %>

<html>
<head>
    <title>매치 목록</title>
</head>
<body>
<h1>매치 목록</h1>
<a href="viewMyMatch.jsp"><button>View My Match</button></a>
<a href="deleteMyMatch.jsp"><button>Delete My Match</button></a>
<table border="1">
    <tr>
        <th>매치 ID</th>
        <th>날짜/시간</th>
        <th>장소 이름</th>
        <th>현재 인원/최대 인원</th>
        <th>참가비</th>
        <th>신청</th>
    </tr>
    <%
        String query = "SELECT M.*, F.ADDRESS, (SELECT COUNT(*) FROM MATCH_APP_MEMBER WHERE MATCH_ID = M.MATCH_ID) AS CURRENT_NUM FROM MATCH M INNER JOIN FIELD F ON M.PLACE_ID = F.FIELD_ID";
        PreparedStatement pstmt = conn.prepareStatement(query);
        ResultSet matchResultSet = pstmt.executeQuery();
        while (matchResultSet.next()) {
            String matchId = matchResultSet.getString("MATCH_ID");
            Timestamp dateTime = matchResultSet.getTimestamp("DATE_TIME");
            String placeName = matchResultSet.getString("ADDRESS");
            int maxNum = matchResultSet.getInt("MAX_NUM");
            int currentNum = matchResultSet.getInt("CURRENT_NUM");
            double costPerOne = matchResultSet.getDouble("COST_PER_ONE"); // 참가비 정보를 가져옵니다.
            boolean isFull = currentNum >= maxNum;
    %>
    <tr>
        <td><%= matchId %></td>
        <td><%= dateTime.toString() %></td>
        <td><%= placeName %></td>
        <td><%= currentNum + "/" + maxNum %></td>
        <td><%= costPerOne %>원</td>
        <td>
            <% if (!isFull) { %>
            <form action="matchApply.jsp" method="post">
                <input type="hidden" name="matchId" value="<%= matchId %>">
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
<a href="member.jsp">뒤로 가기</a>
</body>
</html>