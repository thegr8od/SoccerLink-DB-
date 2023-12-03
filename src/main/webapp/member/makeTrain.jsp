<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Random" %>
<%@ page import="classes.SQLx" %>
<%@ include file="../common/dbconn.jsp" %>
<%@ page import="classes.SessionConst" %>

<html>
<head>
    <title>트레이닝 생성</title>
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
    <h1>트레이닝 생성</h1>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String dateTime = request.getParameter("date");
            String subject = request.getParameter("subject");
            String recommendTier = request.getParameter("recommendTier");
            String place = request.getParameter("place");
            int maxNum = Integer.parseInt(request.getParameter("maxNum"));
            double wage = Double.parseDouble(request.getParameter("wage"));
            double costPerOne = Double.parseDouble(request.getParameter("costPerOne"));
            String tutorId = (String) session.getAttribute(SessionConst.USER);  // 세션에서 tutorId 가져오기
            Random rand = new Random();
            String classId = "C" + (100 + rand.nextInt(900)) + "-" + (10 + rand.nextInt(90)) + "-" + (1000 + rand.nextInt(9000));

            if (tutorId != null && !tutorId.isEmpty()) {
                String insertQuery = SQLx.Insertx("TRAINING", new String[]{classId, dateTime, tutorId, recommendTier, subject, place, String.valueOf(maxNum), String.valueOf(wage), String.valueOf(costPerOne)});
                PreparedStatement trainingPst = conn.prepareStatement(insertQuery);
                int result = trainingPst.executeUpdate();

                if (result > 0) {
                    out.println("<p>트레이닝이 성공적으로 생성되었습니다. 클래스 ID: " + classId + "</p>");
                } else {
                    out.println("<p>트레이닝 생성에 실패했습니다.</p>");
                }
            } else {
                out.println("<p>강사 ID가 없습니다. 로그인 상태를 확인하세요.</p>");
            }
        }
    %>

    <form action="makeTrain.jsp" method="post">
        <label for="date">날짜 및 시간:</label>
        <input type="date" id="date" name="date" required><br>

        <label for="subject">주제:</label>
        <input type="text" id="subject" name="subject" required><br>

        <label for="recommendTier">추천 티어:</label>
        <input type="text" id="recommendTier" name="recommendTier" required><br>

        <label for="place">장소:</label>
        <input type="text" id="place" name="place" required><br>

        <label for="maxNum">최대 인원:</label>
        <input type="number" id="maxNum" name="maxNum" required><br>

        <label for="wage">강사 비용:</label>
        <input type="number" id="wage" name="wage" step="0.01" required><br>

        <label for="costPerOne">수강료(1인당):</label>
        <input type="number" id="costPerOne" name="costPerOne" step="0.01" required><br>

        <input type="submit" value="트레이닝 생성">
    </form>
    <a href="training.jsp" class="btn btn-primary">뒤로 가기</a>
</div>
</body>
</html>
