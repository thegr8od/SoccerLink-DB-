<%--
  Created by IntelliJ IDEA.
  User: dongh
  Date: 2023-12-03
  Time: 오후 2:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.Random" %>
<%@ page import="classes.SQLx" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../../common/dbconn.jsp" %>
<html>
<head>
    <title>InsertProc</title>
</head>
<body>
<%
    String[] data = new String[9];
    data[1] = request.getParameter("Date_Time");
    data[2] = request.getParameter("Place_id");
    data[3] = request.getParameter("TYPE");
    data[4] = request.getParameter("Max_num");
    data[5] = request.getParameter("Sex_constraint");
    data[6] = "null";
    data[7] = request.getParameter("Wage");
    data[8] = request.getParameter("Cost_per_one");
    while (true) {
        Random rand = new Random(System.currentTimeMillis());
        StringBuilder sb = new StringBuilder();
        StringBuilder where = new StringBuilder();
        sb.append("M").append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10));
        sb.append("-").append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10));
        sb.append("-").append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10));
        where.append("MATCH_ID = '"+ sb.toString() + "'");
        int rows = 0;
        String check = SQLx.Selectx("MATCH_ID", "MATCH", where.toString(), "");
        pst = conn.prepareStatement(check);
        rs = pst.executeQuery();
        if (rs.next())
            sb.setLength(0);
        else{
            data[0] = sb.toString();
            break;
        }
    }
    String sql = SQLx.Insertx("MATCH", data);
    pst = conn.prepareStatement(sql);
    pst.executeUpdate();
%>
<script>
    alert("성공적으로 삽입되었습니다.")
    window.location.href = "../../admin.jsp"
</script>
</body>
</html>
