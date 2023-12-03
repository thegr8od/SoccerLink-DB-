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
    String[] data = new String[5];
    data[1] = request.getParameter("Name");
    data[2] = request.getParameter("Field_HP");
    data[3] = request.getParameter("Owner_HP");
    data[4] = request.getParameter("Address");
    while (true) {
        Random rand = new Random(System.currentTimeMillis());
        StringBuilder sb = new StringBuilder();
        StringBuilder where = new StringBuilder();
        sb.append("F").append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10));
        sb.append("-").append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10));
        sb.append("-").append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10)).append(Math.abs(rand.nextInt() % 10));
        where.append("FIELD_ID = '"+ sb.toString() + "'");
        int rows = 0;
        String check = SQLx.Selectx("FIELD_ID", "FIELD", where.toString(), "");
        pst = conn.prepareStatement(check);
        rs = pst.executeQuery();
        if (rs.next())
            sb.setLength(0);
        else{
            data[0] = sb.toString();
            break;
        }
    }
    String sql = SQLx.Insertx("FIELD", data);
    pst = conn.prepareStatement(sql);
    pst.executeUpdate();
%>
<script>
    alert("성공적으로 삽입되었습니다.")
    window.location.href = "../../admin.jsp"
</script>
</body>
</html>
