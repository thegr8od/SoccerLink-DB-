<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Random" %>
<%@ page import="classes.SQLx" %>
<%@ include file="../common/dbconn.jsp" %>
<%@ page import="classes.SessionConst" %>
<html>
<head>
    <title>트레이닝 신청 처리</title>
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
    </style>
</head>
<body>
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
<%
    String userId = (String) session.getAttribute(SessionConst.USER);
    String classId = request.getParameter("classId");

    if (userId != null && classId != null) {
        // 이미 트레이닝에 등록되었는지 확인
        String checkEnrollmentQuery = SQLx.Selectx("*", "TRAIN_ENROLLS", "CLASS_ID = '" + classId + "' AND TUTEE_ID = '" + userId + "'", "");
        PreparedStatement checkEnrollmentPstmt = conn.prepareStatement(checkEnrollmentQuery);
        ResultSet checkEnrollmentRs = checkEnrollmentPstmt.executeQuery();

        if (checkEnrollmentRs.next()) {
%>
<script type="text/javascript">
    alert('이미 참가한 트레이닝입니다.');
    window.location.href = 'training.jsp';
</script>
<%
} else {
    // 트레이닝 비용 조회
    String costQuery = SQLx.Selectx("COST_PER_ONE", "TRAINING", "CLASS_ID = '" + classId + "'", "");
    PreparedStatement costPstmt = conn.prepareStatement(costQuery);
    ResultSet costRs = costPstmt.executeQuery();
    int costPerOne = 0;

    if (costRs.next()) {
        costPerOne = costRs.getInt(1);
    }

    // 사용자의 현재 잔액 확인
    String balanceQuery = SQLx.Selectx("PREPAID_MONEY", "MEMBER", "ID_NUMBER = '" + userId + "'", "");
    PreparedStatement balancePstmt = conn.prepareStatement(balanceQuery);
    ResultSet balanceRs = balancePstmt.executeQuery();
    int currentBalance = 0;

    if (balanceRs.next()) {
        currentBalance = balanceRs.getInt(1);
    }

    // 잔액 확인 후 처리
    if (currentBalance >= costPerOne) {
        // 사용자 잔액 차감
        String updateMoneyQuery = "UPDATE MEMBER SET PREPAID_MONEY = PREPAID_MONEY - ? WHERE ID_NUMBER = ?";
        PreparedStatement updateMoneyPstmt = conn.prepareStatement(updateMoneyQuery);
        updateMoneyPstmt.setInt(1, costPerOne);
        updateMoneyPstmt.setString(2, userId);
        int moneyUpdateResult = updateMoneyPstmt.executeUpdate();

        if (moneyUpdateResult > 0) {
            // TRAIN_ENROLLS에 신청 데이터 추가
            String enrollQuery = SQLx.Insertx("TRAIN_ENROLLS", new String[]{classId, userId});
            PreparedStatement enrollPstmt = conn.prepareStatement(enrollQuery);
            int enrollResult = enrollPstmt.executeUpdate();

            if (enrollResult > 0) {
%>
<script type="text/javascript">
    alert('트레이닝 신청이 완료되었습니다.');
    window.location.href = 'training.jsp';
</script>
<%
} else {
%>
<script type="text/javascript">
    alert('트레이닝 신청에 실패했습니다.');
    window.location.href = 'training.jsp';
</script>
<%
    }
} else {
%>
<script type="text/javascript">
    alert('트레이닝 신청 중 오류가 발생했습니다.');
    window.location.href = 'training.jsp';
</script>
<%
    }
} else {
%>
<script type="text/javascript">
    alert('잔액이 부족합니다.');
    window.location.href = 'training.jsp';
</script>
<%
            }
        }
    }
%>
<a href="training.jsp" class="btn btn-secondary">돌아가기</a>
</body>
</html>