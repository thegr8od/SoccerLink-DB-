<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="classes.SQLx" %>
<%@ page import="classes.SessionConst" %>
<%@ include file="../common/dbconn.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>트레이닝 목록</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        body, html {
            margin: 0;
            padding: 0;
            background-color: #fff; /* 흰색 배경 적용 */
            font-family: 'Noto Sans KR', sans-serif;
            color: #333;
        }

        .container {
            margin-top: 20px;
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
        }

        .btn {
            padding: 10px 20px;
            margin: 5px;
            border-radius: 5px;
        }

        .btn-primary {
            background-color: #007bff;
            color: #fff;
            border: 1px solid #007bff;
        }

        .btn-primary:hover, .btn-primary:focus {
            background-color: #0056b3;
            border: 1px solid #0056b3;
        }

        .btn-danger {
            background-color: #dc3545;
            color: #fff;
            border: 1px solid #dc3545;
        }

        .btn-danger:hover, .btn-danger:focus {
            background-color: #c82333;
            border: 1px solid #c82333;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: #fff;
            border: 1px solid #6c757d;
        }

        .btn-secondary:hover, .btn-secondary:focus {
            background-color: #545b62;
            border: 1px solid #545b62;
        }

        .navbar {
            background-color: #fff; /* 흰색 배경 적용 */
            padding: 10px 0;
            margin-bottom: 20px;
        }

        .navbar-brand img {
            width: 200px;
            margin-top: 10px;
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
    <h1>트레이닝 목록</h1>
    <a href="viewMyTraining.jsp" class="btn btn-primary">View My Training</a>
    <a href="makeTrain.jsp" class="btn btn-danger">Make Training</a>
    <table border="1">
        <tr>
            <th>트레이닝 ID</th>
            <th>날짜/시간</th>
            <th>주제</th>
            <th>현재 인원/최대 인원</th>
            <th>비용</th>
            <th>신청</th>
        </tr>
        <% String query = "SELECT T.*, (SELECT COUNT(*) FROM TRAIN_ENROLLS WHERE CLASS_ID = T.CLASS_ID) AS CURRENT_NUM FROM TRAINING T";
            PreparedStatement pstmt = conn.prepareStatement(query);
            ResultSet trainingResultSet = pstmt.executeQuery();
            while (trainingResultSet.next()) {
                String classId = trainingResultSet.getString(1);
                Timestamp dateTime = trainingResultSet.getTimestamp(2);
                String subject = trainingResultSet.getString(5);
                int maxNum = trainingResultSet.getInt(7);
                int currentNum = trainingResultSet.getInt(10);
                double costPerOne = trainingResultSet.getDouble(9);
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
                    <input type="submit" class="btn btn-secondary" value="신청하기">
                </form>
                <% } else { %>
                인원이 꽉 찼습니다.
                <% } %>
            </td>
        </tr>
        <% }
        %>
    </table>
    <a href="member.jsp" class="btn btn-primary">뒤로 가기</a>
</div>
</body>
</html>
