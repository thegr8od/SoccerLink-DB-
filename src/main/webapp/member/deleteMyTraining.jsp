<%--
  Created by IntelliJ IDEA.
  User: 김승준
  Date: 2023-12-05
  Time: 오전 9:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="classes.SQLx" %>
<%@ page import="classes.SessionConst" %>
<%@ include file="../common/dbconn.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>내 트레이닝 취소</title>
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

        form {
            display: inline;
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
                        if(user == null || user.equals("")){
                    %>
                    <script>
                        alert("세션이 만료되었습니다.");
                        window.location.href = "../common/login.jsp";
                    </script>
                    <%
                            return; // 페이지의 나머지 처리를 중단
                        }
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
    <h1>내가 참가한 트레이닝</h1>
    <form method="post">
        <table class="table">
            <tr>
                <th>클래스 ID</th>
                <th>선택</th>
            </tr>
            <%
                String userId = (String) session.getAttribute(SessionConst.USER);
                String selectedClassId = request.getParameter("selectedClassId");

                if (selectedClassId != null && !selectedClassId.isEmpty()) {
                    // 트레이닝 비용 조회
                    String costQuery = SQLx.Selectx("COST_PER_ONE", "TRAINING", "CLASS_ID = '" + selectedClassId + "'", "");
                    PreparedStatement costPstmt = conn.prepareStatement(costQuery);
                    ResultSet costRs = costPstmt.executeQuery();
                    double costPerOne = 0;

                    if (costRs.next()) {
                        costPerOne = costRs.getDouble("COST_PER_ONE");
                    }

                    // TRAIN_ENROLLS에서 선택된 트레이닝 기록 삭제
                    String deleteQuery = SQLx.Deletex("TRAIN_ENROLLS", new String[]{selectedClassId, userId});
                    PreparedStatement deletePstmt = conn.prepareStatement(deleteQuery);
                    int deleteResult = deletePstmt.executeUpdate();

                    if (deleteResult > 0) {
                        // 사용자 잔액에 환불
                        String updateMoneyQuery = "UPDATE MEMBER SET PREPAID_MONEY = PREPAID_MONEY + ? WHERE ID_NUMBER = ?";
                        PreparedStatement updateMoneyPstmt = conn.prepareStatement(updateMoneyQuery);
                        updateMoneyPstmt.setDouble(1, costPerOne);
                        updateMoneyPstmt.setString(2, userId);
                        updateMoneyPstmt.executeUpdate();

                        out.println("<p>트레이닝 취소 및 환불이 완료되었습니다.</p>");
                    } else {
                        out.println("<p>트레이닝 취소에 실패했습니다.</p>");
                    }
                }

                // 현재 참여 중인 트레이닝 목록 표시
                String query = SQLx.Selectx("CLASS_ID", "TRAIN_ENROLLS", "TUTEE_ID = '" + userId + "'", "");
                PreparedStatement pstmt = conn.prepareStatement(query);
                rs = pstmt.executeQuery();

                while (rs.next()) {
                    String classId = rs.getString(1);
            %>
            <tr>
                <td><%= classId %></td>
                <td><input type="radio" name="selectedClassId" value="<%= classId %>"></td>
            </tr>
            <%
                }
            %>
        </table>
        <input type="submit" value="트레이닝 취소" class="btn btn-danger">
    </form>
    <a href="training.jsp" class="btn btn-primary">뒤로 가기</a>
</div>
</body>
</html>

