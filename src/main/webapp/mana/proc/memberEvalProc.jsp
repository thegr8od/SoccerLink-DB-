<%@ page import="classes.SQLx" %>
<%@ page import="classes.SessionConst" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ include file="../../common/dbconn.jsp" %>

<%--
  Created by IntelliJ IDEA.
  User: 황경모
  Date: 2023-12-03
  Time: 오후 9:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String[] data = new String[4];
    data[0] = request.getParameter("memberId");
    data[1] = (String) session.getAttribute(SessionConst.USER);
    data[2]= request.getParameter("tier");

    LocalDate currentDate = LocalDate.now();
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    data[3] = currentDate.format(formatter);
    try {
        String checkEvalSql = "select *\n" +
                "from MAN_EVAL_MEM\n" +
                "where MEM_ID = '"+data[0]+"'\n" +
                "      and MAN_ID ='"+data[1]+"'";
        pst = conn.prepareStatement(checkEvalSql);
        rs = pst.executeQuery();
        if(rs.next()){
%>
    <script>
        alert("이미 평가된 플레이어입니다.");
        history.go(-1);
    </script>
<%
        }
        else{
            String memberEvalSql = SQLx.Insertx("MAN_EVAL_MEM", data);
            pst = conn.prepareStatement(memberEvalSql);
            pst.executeQuery();
            %>
<script>
    alert("평가되었습니다.");
    history.go(-1);
</script>
<%
        }
    }catch(SQLException e){
%>
<script>
    alert("평가에 실패했습니다.");
    history.go(-1);
</script>
<%
    }
%>
