<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="classes.SQLx" %>
<%@ page import="classes.SessionConst" %>
<%@ include file="../common/dbconn.jsp" %>

<html>
<head>
    <title>팀 삭제</title>   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        body, html {
            margin: 0;
            padding: 0;
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #fff;
            color: #333;
        }

        .navbar {
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .navbar-brand img {
            width: 200px;
            margin-top: 10px;
        }

        .container {
            margin-top: 20px;
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

        .btn {
            margin: 5px;
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
    <h1>나의 팀 삭제</h1>
    <form method="post">
        <table class="table">
            <tr>
                <th>팀 ID</th>
                <th>팀 이름</th>
                <th>선택</th>
            </tr>
            <%
                String userId = (String) session.getAttribute(SessionConst.USER);
                String selectedTeamId = request.getParameter("selectedTeamId");

                if (selectedTeamId != null && !selectedTeamId.isEmpty()) {
                    // TEAM_MEM에서 선택된 팀 기록 삭제
                    String deleteQuery = SQLx.Deletex("TEAM_MEM", new String[]{selectedTeamId, userId});
                    PreparedStatement deletePstmt = conn.prepareStatement(deleteQuery);
                    int deleteResult = deletePstmt.executeUpdate();

                    if (deleteResult > 0) {
                        out.println("<p>팀 탈퇴가 완료되었습니다.</p>");
                    } else {
                        out.println("<p>팀 탈퇴에 실패했습니다.</p>");
                    }
                }

                // 현재 속한 팀 목록 표시
                String query = SQLx.Selectx("T.TEAM_ID, T.TEAM_NAME", "TEAM_MEM TM INNER JOIN TEAM T ON TM.TEAM_ID = T.TEAM_ID", "TM.MEM_ID = ?", "");
                PreparedStatement pstmt = conn.prepareStatement(query);
                pstmt.setString(1, userId);
                rs = pstmt.executeQuery();

                while (rs.next()) {
                    String teamId = rs.getString(1);
                    String teamName = rs.getString(2);
            %>
            <tr>
                <td><%= teamId %></td>
                <td><%= teamName %></td>
                <td><input type="radio" name="selectedTeamId" value="<%= teamId %>"></td>
            </tr>
            <%
                }
            %>
        </table>
        <input type="submit" value="팀 삭제" class="btn btn-danger">
    </form>
    <a href="team.jsp" class="btn btn-primary">뒤로 가기</a>
</div>
</body>
</html>