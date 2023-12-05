<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Random" %>
<%@ page import="classes.SQLx" %>
<%@ include file="../common/dbconn.jsp" %>
<%@ page import="classes.SessionConst" %>

<html>
<head>
    <title>새 팀 만들기</title>
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

        label {
            font-weight: bold;
        }

        input[type="date"],
        input[type="text"],
        input[type="number"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        input[type="submit"] {
            background-color: #333;
            color: #fff;
            border: none;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #555;
        }
    </style>
</head>
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
    <h1>새 팀 만들기</h1>
    <form action="makeTeam.jsp" method="post">
        <div class="mb-3">
            <label for="teamName" class="form-label">팀 이름</label>
            <input type="text" class="form-control" id="teamName" name="teamName" required>
        </div>
        <button type="submit" class="btn btn-primary">팀 만들기</button>
    </form>
    <a href="team.jsp" class="btn btn-secondary">돌아가기</a>
</div>

<%
    if(request.getMethod().equals("POST")) {
        String teamName = request.getParameter("teamName");
        // 팀 ID 생성 (예시: 고유한 값을 기반으로 생성)
        Random rand = new Random();
        String teamId = "T" + (100 + rand.nextInt(900)) + "-" + (10 + rand.nextInt(90)) + "-" + (1000 + rand.nextInt(9000));

        // 데이터베이스에 팀 추가
        String[] data = {teamId, teamName};
        String sql = SQLx.Insertx("TEAM", data);
        try {
            Statement stmt = conn.createStatement();
            stmt.executeUpdate(sql);
            out.println("<script>alert('팀이 성공적으로 생성되었습니다. 팀 ID: " + teamId + "'); location.href='team.jsp';</script>");
        } catch (SQLException e) {
            out.println("<script>alert('팀 생성에 실패하였습니다.');</script>");
            e.printStackTrace();
        }
    }
%>

</body>
</html>