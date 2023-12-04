<%@ page import="classes.SessionConst" %><%--
  Created by IntelliJ IDEA.
  User: 황경모
  Date: 2023-12-04
  Time: 오후 8:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
