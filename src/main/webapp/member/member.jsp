<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ include file="../common/dbconn.jsp" %>
<%@ page import="classes.SessionConst" %>
<%@ page import="classes.SQLx" %>
<!DOCTYPE html>
<html>
<head>

    <title>마이 페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="../style/main.css" rel="stylesheet">
    <style>


        body, html {
            margin: 0;
            padding: 0;
            font-family: 'Noto Sans KR', sans-serif; /* Noto Sans KR 글꼴 적용 */
            background-color: #fff;
            color: #333;
        }


        .card {
            background-color: #fff;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
            margin-top: 20px;
            transition: transform 0.3s ease-in-out;
        }

        .btn {
            background-color: #fff; /* 흰색 배경 */
            color: #333; /* 텍스트 색상을 어두운 색상으로 설정 */
            border: 1px solid #333; /* 테두리 색상을 어두운 색상으로 설정 */
            padding: 10px 20px;
            margin: 5px;
            border-radius: 5px;
            transition: background-color 0.3s ease-in-out, color 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
        }

        /* 클릭 또는 호버 시 배경색과 텍스트 색상 변경 */
        .btn:hover, .btn:focus {
            background-color: #ccc; /* 클릭 또는 호버 시 배경색을 어두운 회색으로 변경 */
            color: #333; /* 클릭 또는 호버 시 텍스트 색상을 어두운 색상으로 유지 */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 클릭 또는 호버 시 그림자 효과 추가 */
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

<div class="container my-4">
    <h2 class="text-center">내 정보</h2>
    <%
        String userId = (String) session.getAttribute(SessionConst.USER);
        String name = "";
        String sex = "";
        String yob = "";
        String job = "";
        int prepaidMoney = 0;
        String tier = ""; // 티어 정보를 저장할 변수

        if (userId != null) {
            String userInfoQuery = "SELECT NAME, SEX, YOB, JOB, PREPAID_MONEY FROM USERS JOIN MEMBER ON USERS.ID_NUMBER = MEMBER.ID_NUMBER WHERE USERS.ID_NUMBER = ?";
            PreparedStatement userInfoPstmt = conn.prepareStatement(userInfoQuery);
            userInfoPstmt.setString(1, userId);
            rs = userInfoPstmt.executeQuery();

            if (rs.next()) {
                name = rs.getString(1);
                sex = rs.getString(2);
                yob = rs.getString(3);
                job = rs.getString(4);
                prepaidMoney = rs.getInt(5);
            }

            // 사용자의 평균 티어를 조회하는 쿼리
            String tierQuery = "SELECT TIER FROM MEMBER_EVAL_VIEW WHERE MEM_ID = ?";
            PreparedStatement tierPstmt = conn.prepareStatement(tierQuery);
            tierPstmt.setString(1, userId);
            ResultSet tierRs = tierPstmt.executeQuery();

            if (tierRs.next()) {
                tier = tierRs.getString("TIER"); // 티어 정보 저장
            }

            rs.close();
            userInfoPstmt.close();
            tierRs.close();
            tierPstmt.close();
        }
    %>

    <div class="card">
        <div class="card-body">
            <p class="card-text">이름: <%= name %></p>
            <p class="card-text">성별: <%= sex %></p>
            <p class="card-text">생년월일: <%= yob %></p>
            <p class="card-text">직업: <%= job %></p>
            <p class="card-text">충전된 금액: <%= prepaidMoney %>원</p>
            <p class="card-text">티어: <%= tier %></p> <!-- 티어 정보를 표시 -->
        </div>
    </div>

    <div class="my-3">
        <a href="match.jsp" class="btn btn-primary">Match</a>
        <a href="training.jsp" class="btn btn-success">Training</a>
        <a href="team.jsp" class="btn btn-warning">Team</a>
        <a href="cashCharge.jsp" class="btn btn-danger">Cashcharge</a>
        <a href="changeInfo.jsp" class="btn btn-primary">Changeinfo</a>
        <button type="button" class="btn btn-danger" onclick="secession()">Secession</button>
    </div>
</div>

<script>
    function secession() {
        const askTwice = prompt("정말로 탈퇴를 원하시면 '탈퇴'를 입력하십시오.");
        if (askTwice === '탈퇴') {
            window.location.href = "../common/secessionProc.jsp";
        } else {
            alert("잘못 입력했습니다.");
        }
    }
</script>
</body>
</html>
