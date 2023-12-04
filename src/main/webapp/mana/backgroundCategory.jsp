<%@ page import="javax.websocket.Session" %>
<%@ page import="classes.SessionConst" %>
<%@ include file="../common/dbconn.jsp" %><%--
  Created by IntelliJ IDEA.
  User: 황경모
  Date: 2023-12-03
  Time: 오후 7:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
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
<%
    String userId = (String) session.getAttribute(SessionConst.USER);
    if(userId == null || userId.equals("")){
%>
<script>
    alert("세션이 만료되었습니다.")
    window.location.href = "../common/login.jsp"
</script>
<%
    }

%>
<%--고정 화면 버튼--%>
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand" href="../index.jsp"><img src="../image/webLogo.png" style ="width: 200px"></a>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
            </ul>
            <div class="d-flex" role="search">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0 justify-content-end">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="../common/logOutProc.jsp">Log out</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</nav>
<hr>
<div class="container my-4">
    <h2 class="text-center">내 정보</h2>
    <%
        String name = "";
        String sex = "";
        String yob = "";
        String job = "";
        String bankAccount="";
        int prepaidMoney = 0;

        if (userId != null) {
            String query = "SELECT u.NAME, u.SEX, u.YOB, u.JOB, m.BANK_ACCOUNT FROM USERS u JOIN MANAGER m ON u.ID_NUMBER = m.ID_NUMBER WHERE u.ID_NUMBER = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                name = rs.getString(1);
                sex = rs.getString(2);
                yob = rs.getString(3);
                job = rs.getString(4);
                bankAccount = rs.getString(5);
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
            <p class="card-text">계좌번호: <%= bankAccount %></p>
        </div>
    </div>

    <div class="my-3">
        <a href="changeInfo.jsp" class="btn btn-primary">개인정보 변경</a>
        <a href="matchAppMana.jsp" class="btn btn-success">매치 매니지 신청</a>
        <a href="memberEval.jsp" class="btn btn-warning">플레이어 평가</a>
        <button type="button" class="btn btn-danger" onclick="secession()">Secession</button>
    </div>
</div>
<script>
    function secession(){
        const askTwice = prompt("정말로 탈퇴를 원하시면 '탈퇴'를 입력하십시오.");
        if(askTwice==='탈퇴'){
            window.location.href = "../common/secessionProc.jsp"
        }
        else{
            alert("잘못 입력했습니다.");
        }
    }
</script>

<%--고정 화면 버튼 end--%>
