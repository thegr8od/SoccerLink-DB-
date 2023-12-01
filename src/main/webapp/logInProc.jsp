<%@ page import="classes.SQLx" %><%--
  Created by IntelliJ IDEA.
  User: 황경모
  Date: 2023-12-01
  Time: 오후 11:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="dbconn.jsp" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    String apx = "\'";
    String id = request.getParameter("id");
    String pw = request.getParameter("pw");
    // admin인지 먼저 확인
    if(id.equals("SOCCERLINK") && pw.equals("ADMIN!")){
        HttpSession session1 = request.getSession();
        session1.setAttribute("user","SOCCERLINK");
        response.sendRedirect("admin.jsp");
    }
    else{
        // USER table에 ID랑 PW가 동시에 일치하는 User가 있는지 체크
        StringBuilder whereForUser = new StringBuilder();
        whereForUser.append("ID_NUMBER = "+apx+id+apx);
        whereForUser.append(" AND PASSWD = "+apx+pw+apx);
        String checkUser = SQLx.Selectx("ID_NUMBER", "USERS", whereForUser.toString(), "");
        pst = conn.prepareStatement(checkUser);
        rs = pst.executeQuery();

        if(rs.next()) {
            // member table에 존재하는지 확인
            StringBuilder where = new StringBuilder();
            where.append("ID_NUMBER = " + apx + id + apx);
            String checkMember = SQLx.Selectx("ID_NUMBER", "MEMBER", where.toString(), "");
            pst = conn.prepareStatement(checkMember);
            rs = pst.executeQuery();
            if (rs.next()) {
                HttpSession session1 = request.getSession();
                session1.setAttribute("user",id);
                response.sendRedirect("member.jsp");
            }
            else {
                // manager table에 존재하는지 확인
                String checkManager = SQLx.Selectx("ID_NUMBER", "MANAGER", where.toString(), "");
                pst = conn.prepareStatement(checkManager);
                rs = pst.executeQuery();
                if (rs.next()) {
                    HttpSession session1 = request.getSession();
                    session1.setAttribute("user",id);
                    response.sendRedirect("manager.jsp");
                }
            }

        }
        else{
%>
<script>
    alert("ID 또는 PW가 일치하지 않습니다.")
    history.go(-1);
</script>
<%
        }
    }
%>

</body>
</html>
