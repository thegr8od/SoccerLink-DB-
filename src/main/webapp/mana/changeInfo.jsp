<%@ page import="classes.SQLx" %>
<%@ page import="classes.SessionConst" %>
<%@ include file="../common/dbconn.jsp" %>
<%--

  Created by IntelliJ IDEA.
  User: 황경모
  Date: 2023-12-03
  Time: 오전 3:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>My information</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" >
</head>
<body>
<jsp:include page="backgroundImage.jsp"/>
<h2 class="text-center">매니저 정보 수정</h2>
<div class="container my-4 d-flex align-items-center justify-content-center">
<%
    String currentJob = new String();
    String currentPw = new String();
    String currentAccount = new String();

    String userId = (String) session.getAttribute(SessionConst.USER);
    String manaInfoSql = "select u.job, u.passwd, m.BANK_ACCOUNT\n" +
            "from users u inner join manager m on u.ID_NUMBER = m.ID_NUMBER\n" +
            "where u.ID_NUMBER = '"+ userId +"'";
    pst = conn.prepareStatement(manaInfoSql);
    rs = pst.executeQuery();
    while(rs.next()){
        currentJob = rs.getString(1);
        currentPw = rs.getString(2);
        currentAccount = rs.getString(3);
    }
%>

    <form action="proc/changeManaInfoProc.jsp" method="post" class = "p-3 border border-black rounded" style ="width: 600px">
        <fieldset>
            <legend></legend>
            <div class="mb-3">
                <label for="job" class="form-label">직업 </label>
                <input type="text" name="job" id="job" class="form-control" placeholder="<%=currentJob%>">
            </div>
            <div class="mb-3">
                <label for="pw" class="form-label">비밀번호</label>
                <input type="password" name ="pw" id="pw" class="form-control">
            </div>
            <div class="mb-3">
                <label for="account" class="form-label">계좌번호</label>
                <input type="text" name ="account" id="account" class="form-control" placeholder="<%=currentAccount%>">
            </div>
            <button type="submit" class="btn btn-primary">수정</button>
        </fieldset>
    </form>
</div>
</body>
</html>
