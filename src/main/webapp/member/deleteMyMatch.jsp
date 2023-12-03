<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="classes.SQLx" %>
<%@ page import="classes.SessionConst" %>
<%@ include file="../common/dbconn.jsp" %>

<html>
<head>
    <title>내 매치 취소</title>
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
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand" href="index.jsp"><img src="../image/webLogo.png" style ="width: 200px"></a>
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
    <h1>내가 참가한 매치</h1>
    <form method="post">
        <table class="table">
            <tr>
                <th>매치 ID</th>
                <th>선택</th>
            </tr>
            <%
                String userId = (String) session.getAttribute(SessionConst.USER);
                String selectedMatchId = request.getParameter("selectedMatchId");

                if (selectedMatchId != null && !selectedMatchId.isEmpty()) {
                    // 매치 비용 조회
                    String costQuery = SQLx.Selectx("COST_PER_ONE", "MATCH", "MATCH_ID = '" + selectedMatchId + "'", "");
                    PreparedStatement costPstmt = conn.prepareStatement(costQuery);
                    ResultSet costRs = costPstmt.executeQuery();
                    double costPerOne = 0;

                    if (costRs.next()) {
                        costPerOne = costRs.getDouble("COST_PER_ONE");
                    }

                    // MATCH_APP_MEMBER에서 선택된 매치 기록 삭제
                    String deleteQuery = SQLx.Deletex("MATCH_APP_MEMBER", new String[]{selectedMatchId, userId});
                    PreparedStatement deletePstmt = conn.prepareStatement(deleteQuery);
                    int deleteResult = deletePstmt.executeUpdate();

                    if (deleteResult > 0) {
                        // 사용자 잔액에 환불
                        String updateMoneyQuery = "UPDATE MEMBER SET PREPAID_MONEY = PREPAID_MONEY + ? WHERE ID_NUMBER = ?";
                        PreparedStatement updateMoneyPstmt = conn.prepareStatement(updateMoneyQuery);
                        updateMoneyPstmt.setDouble(1, costPerOne);
                        updateMoneyPstmt.setString(2, userId);
                        updateMoneyPstmt.executeUpdate();

                        out.println("<p>매치 취소 및 환불이 완료되었습니다.</p>");
                    } else {
                        out.println("<p>매치 취소에 실패했습니다.</p>");
                    }
                }

                // 현재 참여 중인 매치 목록 표시
                String query = SQLx.Selectx("MATCH_ID", "MATCH_APP_MEMBER", "MEMBER_ID = '" + userId + "'", "");
                PreparedStatement pstmt = conn.prepareStatement(query);
                rs = pstmt.executeQuery();

                while (rs.next()) {
                    String matchId = rs.getString("MATCH_ID");
            %>
            <tr>
                <td><%= matchId %></td>
                <td><input type="radio" name="selectedMatchId" value="<%= matchId %>"></td>
            </tr>
            <%
                }
            %>
        </table>
        <input type="submit" value="매치 취소" class="btn btn-danger">
    </form>
    </table>
    <a href="member.jsp" class="btn btn-primary">뒤로 가기</a>
</div>
</body>
</html>