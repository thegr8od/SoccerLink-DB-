<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="classes.SessionConst" %>
<%@ page import="classes.SQLx" %>
<%@ include file="../common/dbconn.jsp" %>

<html>
<head>
  <title>내 매치 보기</title>
</head>
<body>
<h1>내 매치</h1>
<%
  String userId = (String) session.getAttribute(SessionConst.USER);
  String selectQuery = SQLx.Selectx(
          "M.MATCH_ID, M.DATE_TIME, F.ADDRESS, M.TYPE, M.MAX_NUM, M.WAGE, M.COST_PER_ONE",
          "MATCH M INNER JOIN FIELD F ON M.PLACE_ID = F.FIELD_ID",
          "M.MATCH_ID IN (SELECT MATCH_ID FROM MATCH_APP_MEMBER WHERE MEMBER_ID = ?)",
          "");

  try {
    PreparedStatement selectPstmt = conn.prepareStatement(selectQuery);
    selectPstmt.setString(1, userId);
    rs = selectPstmt.executeQuery();

    if (rs.next()) {
%>
<!-- 내 매치를 표시할 테이블 생성 -->
<table border="1">
  <tr>
    <th>매치 ID</th>
    <th>날짜/시간</th>
    <th>장소 이름</th>
    <th>유형</th>
    <th>참가 인원</th>
    <th>급여</th>
    <th>인당 비용</th>
  </tr>
  <%
    do {
      String matchId = rs.getString("MATCH_ID");
      Timestamp dateTime = rs.getTimestamp("DATE_TIME");
      String placeName = rs.getString("ADDRESS");
      String type = rs.getString("TYPE");
      int maxNum = rs.getInt("MAX_NUM");
      double wage = rs.getDouble("WAGE");
      double costPerOne = rs.getDouble("COST_PER_ONE");
  %>
  <tr>
    <td><%= matchId %></td>
    <td><%= dateTime.toString() %></td>
    <td><%= placeName %></td>
    <td><%= type %></td>
    <td><%= maxNum %></td>
    <td><%= wage %></td>
    <td><%= costPerOne %></td>
  </tr>
  <%
    } while (rs.next());
  %>
</table>
<%
    } else {
      out.println("<p>참가한 매치가 없습니다.</p>");
    }
    rs.close();
    selectPstmt.close();
  } catch (SQLException e) {
    e.printStackTrace();
  }
%>
<a href="match.jsp">뒤로 가기</a>
</body>
</html>
