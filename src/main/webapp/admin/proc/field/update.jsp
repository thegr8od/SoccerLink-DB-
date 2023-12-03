<%@ page import="classes.SQLx" %><%--
  Created by IntelliJ IDEA.
  User: dongh
  Date: 2023-12-03
  Time: 오후 2:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../../common/dbconn.jsp" %>
<html>
<head>
    <title>DeleteProc</title>
</head>
<body>
<%
    String[] key = new String[1];
    key[0] = request.getParameter("key");
    String check = SQLx.Selectx("FIELD_ID", "FIELD", "WHERE FIELD_ID = '"+key[0]+"'");
    pst = conn.prepareStatement(check);
    rs = pst.executeQuery();
    if(!rs.next()){
%>
<script>
    alert("존재하지 않는 FIELD_ID입니다.")
    window.location.href = "../../fieldMod.jsp"
</script>
<%
    }
    String target = request.getParameter("attr");
    String value = request.getParameter("value");
    String sql = SQLx.Updatex("FIELD", target, value, key);
    pst = conn.prepareStatement(sql);
    pst.executeUpdate();
%>
<script>
    alert("성공적으로 업데이트되었습니다.")
    window.location.href = "../../admin.jsp"
</script>
</body>
</html>
