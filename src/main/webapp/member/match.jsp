<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="classes.SQLx" %>
<%@ page import="classes.SessionConst" %>
<%@ include file="../common/dbconn.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>매치 목록</title>
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

        .card {
            background-color: #fff;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
            margin-top: 20px;
            transition: transform 0.3s ease-in-out;
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

        .table {
            width: 100%;
            border-collapse: collapse;
        }

        .table th, .table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        .table th {
            background-color: #f2f2f2;
        }

        .apply-btn {
            display: inline-block;
            padding: 10px 20px;
            border: 1px solid #333;
            border-radius: 5px;
            transition: background-color 0.3s ease-in-out, color 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
        }

        .apply-btn:hover, .apply-btn:focus {
            background-color: #ccc;
            color: #333;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand" href="../index.jsp">
            <img src="../image/webLogo.png" alt="Logo" style="width: 200px; margin-top: 10px">
        </a>
    </div>
</nav>
<hr>

    <a href="viewMyMatch.jsp" class="btn btn-primary">View My Match</a>
    <a href="deleteMyMatch.jsp" class="btn btn-danger">Delete My Match</a>
    <table class="table">
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
        <button type="submit" class="btn btn-sm btn-primary">신청하기</button>
    </form>
<% } else { %>
    인원이 꽉 찼습니다.
<% } %>
    </span>
            </td>

                </span>
            </td>
        </tr>
        <%
            }
        %>
    </table>
    <a href="member.jsp" class="btn btn-primary">뒤로 가기</a>
</div>
</body>
</html>
