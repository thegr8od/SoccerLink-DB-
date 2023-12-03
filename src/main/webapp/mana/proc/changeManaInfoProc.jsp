<%@ page import="classes.SQLx" %>
<%@ page import="classes.SessionConst" %>
<%@ include file="../../common/dbconn.jsp" %><%--
  Created by IntelliJ IDEA.
  User: 황경모
  Date: 2023-12-03
  Time: 오후 7:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String[] userId = new String[1];
    userId[0] = (String) session.getAttribute(SessionConst.USER);
    String job = request.getParameter("job");
    String pw = request.getParameter("pw");
    String account = request.getParameter("account");
    try {
        String changeJobSql = SQLx.Updatex("USERS", "JOB", job, userId);
        pst = conn.prepareStatement(changeJobSql);
        pst.executeQuery();

        String changePwSql = SQLx.Updatex("USERS", "PASSWD", pw, userId);
        pst = conn.prepareStatement(changePwSql);
        pst.executeQuery();

        String changeAccountSql = SQLx.Updatex("MANAGER", "BANK_ACCOUNT", account, userId);
        pst = conn.prepareStatement(changeAccountSql);
        pst.executeQuery();
    }catch(SQLException e){
%>
<script>
    alert("수정에 실패했습니다.");
    history.go(-1);
</script>
<%
    }
%>
<script>
    alert("수정되었습니다.");
    window.location.href = "../manager.jsp";
</script>
