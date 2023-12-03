<%--
  Created by IntelliJ IDEA.
  User: 황경모
  Date: 2023-12-01
  Time: 오후 10:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.Random" %>
<%@ page import="classes.SQLx" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="dbconn.jsp" %>

<html>
<head>
    <title></title>
</head>
<body>
<%
    char apx = '\'';
    String ID="";
    String pw = request.getParameter("pw");
    String name = request.getParameter("name");
    String sex = request.getParameter("sex");
    String year = request.getParameter("year");
    String job = request.getParameter("job");
    String role = request.getParameter("role");
    while (true) {
        Random rand = new Random(System.currentTimeMillis());
        StringBuilder sb = new StringBuilder();
        StringBuilder where = new StringBuilder();
        sb.append("U").append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10));
        sb.append("-").append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10));
        sb.append("-").append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10));
        ID = sb.toString();
        where.append("ID_NUMBER = " + apx + ID + apx);
        int rows = 0;

        String duplicateCheckSql = SQLx.Selectx("ID_NUMBER", "USERS", where.toString(), "");
        pst = conn.prepareStatement(duplicateCheckSql);
        rs = pst.executeQuery();
        if (rs.next())
            sb.setLength(0);
        else
            break;
    }
    String[] data = {ID, name, sex, year, job, pw};
    String userInsertSql = SQLx.Insertx("USERS", data);
    pst = conn.prepareStatement(userInsertSql);
    pst.executeQuery();

    String[] userSubsection = new String[2];
    if (role.equals("manager")) {
        userSubsection[0] = ID;
        userSubsection[1] = request.getParameter("bankAccount");
        String managerInsertSql = SQLx.Insertx("MANAGER", userSubsection);
        pst = conn.prepareStatement(managerInsertSql);
        pst.executeQuery();
    } else if (role.equals("member")) {
        userSubsection[0] = ID;
        userSubsection[1] = "0";
        String memberInsertSql = SQLx.Insertx("MEMBER", userSubsection);
        pst = conn.prepareStatement(memberInsertSql);
        pst.executeQuery();
    }
%>
<script>
    alert("당신의 ID는 <%=ID%> 입니다.");
    window.location.href ="login.jsp";
</script>



</body>
</html>
