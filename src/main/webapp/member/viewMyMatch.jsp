<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="classes.SQLx" %>
<%@ page import="classes.SessionConst" %>
<%@ include file="../common/dbconn.jsp" %>

<!DOCTYPE html>
<html>
<head>
  <title>내 매치 보기</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
  <style>
    body, html {
      margin: 0;
      padding: 0;
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #fff;
      color: #333;
    }

    .container {
      margin-top: 20px;
    }

    .navbar {
      background-color: #fff;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .navbar-brand img {
      width: 200px;
      margin-top: 10px;
    }

    .btn {
      background-color: #fff;
      color: #333;
      border: 1px solid #333;
      padding: 10px 20px;
      margin: 5px;
      border-radius: 5px;
      transition: background-color 0.3s ease-in-out, color 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
    }

    .btn:hover, .btn:focus {
      background-color: #ccc;
      color: #333;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }

    table {
      width: 100%;
      border-collapse: collapse;
    }

    table, th, td {
      border: 1px solid #ddd;
      padding: 8px;
      text-align: left;
    }

    th {
      background-color: #f2f2f2;
    }
  </style>
</head>
<body>
<nav class="navbar navbar-expand-lg">
  <div class="container-fluid">
    <a class="navbar-brand" href="../index.jsp"><img src="../image/webLogo.png" style ="width: 200px"></a>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
      </ul>
      <div class="d-flex" role="search">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0 justify-content-end">
          <%
            String user = (String) session.getAttribute(SessionConst.USER);
            if(user==null){

          %>
          <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="../common/login.jsp">login</a>
          </li>
          <%
          }
          else{
            if(user.equals("SOCCERLINK")) {
          %>
          <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="../admin/admin.jsp">My page</a>
          </li>
          <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="../common/logOutProc.jsp">Log out</a>
          </li>
          <%
          }
          else{
            String apx = "\'";
            StringBuilder where = new StringBuilder();
            where.append("ID_NUMBER = " + apx + user + apx);
            String checkMember = SQLx.Selectx("ID_NUMBER", "MEMBER", where.toString(), "");
            pst = conn.prepareStatement(checkMember);
            rs = pst.executeQuery();
            if (rs.next()) {
          %>
          <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="member.jsp">My page</a>
          </li>

          <%
          }
          else {
            // manager table에 존재하는지 확인
            String checkManager = SQLx.Selectx("ID_NUMBER", "MANAGER", where.toString(), "");
            pst = conn.prepareStatement(checkManager);
            rs = pst.executeQuery();
            if (rs.next()) {
          %>
          <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="../mana/manager.jsp">My page</a>
          </li>
          <%
              }
            }
          %>
          <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="../common/logOutProc.jsp">Log out</a>
          </li>
          <%
              }
            }
          %>
        </ul>
      </div>
    </div>
  </div>
</nav>
<hr>
<div class="container">
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
  <table>
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
  </table>
  <a href="match.jsp" class="btn btn-primary">뒤로 가기</a>
</div>
</body>
</html>