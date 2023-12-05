<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="classes.SessionConst" %>
<%@ page import="classes.SQLx" %>
<%@ include file="../common/dbconn.jsp" %>

<%
    String userId = (String) session.getAttribute(SessionConst.USER);
    String errorMessage = "";

    if (request.getParameter("updateInfo") != null) {
        String selectedField = request.getParameter("selectedField");
        String newValue = request.getParameter("newValue");

        try {
            String updateQuery = "";
            if (selectedField.equals("sex")) {
                if (newValue.equals("M") || newValue.equals("F")) {
                    updateQuery = SQLx.Updatex("USERS", "SEX", newValue, new String[]{userId});
                } else {
                    errorMessage = "올바른 성별 값을 입력하세요 (M 또는 F).";
                }
            } else if (selectedField.equals("yob")) {
                int yob = Integer.parseInt(newValue);
                if (yob >= 1900 && yob <= 2023) {
                    updateQuery = SQLx.Updatex("USERS", "YOB", newValue, new String[]{userId});
                } else {
                    errorMessage = "출생년도는 1900년에서 2023년 사이여야 합니다.";
                }
            } else if (selectedField.equals("job")) {
                updateQuery = SQLx.Updatex("USERS", "JOB", newValue, new String[]{userId});
            } else if (selectedField.equals("passwd")) {
                if (newValue.length() > 8) {
                    updateQuery = SQLx.Updatex("USERS", "PASSWD", newValue, new String[]{userId});
                } else {
                    errorMessage = "비밀번호는 9자리 이상이어야 합니다.";
                }
            } else {
                errorMessage = "올바른 필드를 선택하세요.";
            }

            if (!updateQuery.isEmpty()) {
                PreparedStatement pstmt = conn.prepareStatement(updateQuery);
                int updateCount = pstmt.executeUpdate();
                if (updateCount > 0) {
                    errorMessage = "사용자 정보가 업데이트되었습니다.";
                } else {
                    errorMessage = "업데이트할 데이터가 없습니다.";
                }
            }
        } catch (SQLException e) {
            errorMessage = "오류 발생: " + e.getMessage();
        } catch (NumberFormatException e) {
            errorMessage = "출생연도는 숫자여야 합니다.";
        }
    }
    // 사용자 정보 조회 SQL
    String selectQuery = SQLx.Selectx("NAME, SEX, YOB, JOB", "USERS", "ID_NUMBER='" + userId + "'", "");
    PreparedStatement selectPstmt = conn.prepareStatement(selectQuery);
    rs = selectPstmt.executeQuery();

    String name = "";
    String sex = "";
    String yob = "";
    String job = "";

    if (rs.next()) {
        name = rs.getString(1);
        sex = rs.getString(2);
        yob = rs.getString(3);
        job = rs.getString(4);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>사용자 정보 수정</title>
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
    <h1>사용자 정보 수정</h1>

    <!-- 에러 메시지 출력 -->
    <% if (!errorMessage.isEmpty()) { %>
    <p style="color: red;"><%= errorMessage %></p>
    <% } %>

    <!-- 사용자 정보 입력 폼 -->
    <form method="post" class="mt-4">
        <div class="form-group">
            <label for="name">이름:</label>
            <input type="text" name="name" id="name" value="<%= name %>" disabled class="form-control">
        </div>

        <div class="form-group">
            <label for="selectedField">수정할 항목 선택:</label>
            <select name="selectedField" id="selectedField" class="form-control">
                <option value="sex">성별</option>
                <option value="yob">출생년도</option>
                <option value="job">직업</option>
                <option value="passwd">비밀번호</option>
            </select>
        </div>

        <div class="form-group">
            <label for="newValue">새로운 값:</label>
            <input type="text" name="newValue" id="newValue" required class="form-control">
        </div>

        <input type="submit" name="updateInfo" value="정보 수정" class="btn btn-primary">
    </form>

    <!-- 뒤로 가기 버튼 -->
    <a href="member.jsp" class="btn btn-primary">뒤로 가기</a>
</div>
</body>
</html>
