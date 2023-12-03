<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ include file="../common/dbconn.jsp" %>
<%@ page import="classes.SessionConst" %>

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
        <a class="navbar-brand" href="../index.jsp">
            <img src="../image/webLogo.png" alt="Logo" style="width: 200px; margin-top: 10px">
        </a>
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

        if (userId != null) {
            String query = "SELECT NAME, SEX, YOB, JOB, PREPAID_MONEY FROM USERS JOIN MEMBER ON USERS.ID_NUMBER = MEMBER.ID_NUMBER WHERE USERS.ID_NUMBER = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                name = rs.getString("NAME");
                sex = rs.getString("SEX");
                yob = rs.getString("YOB");
                job = rs.getString("JOB");
                prepaidMoney = rs.getInt("PREPAID_MONEY");
            }
            rs.close();
            pstmt.close();
        }
    %>

    <div class="card">
        <div class="card-body">
            <p class="card-text">이름: <%= name %></p>
            <p class="card-text">성별: <%= sex %></p>
            <p class="card-text">생년월일: <%= yob %></p>
            <p class="card-text">직업: <%= job %></p>
            <p class="card-text">충전된 금액: <%= prepaidMoney %>원</p>
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
