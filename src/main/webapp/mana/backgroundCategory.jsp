<%@ page import="javax.websocket.Session" %>
<%@ page import="classes.SessionConst" %>
<%@ include file="../common/dbconn.jsp" %><%--
  Created by IntelliJ IDEA.
  User: 황경모
  Date: 2023-12-03
  Time: 오후 7:11
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
    String nameSql = "select name from users where id_number = '"+userId+"\'";
    pst = conn.prepareStatement(nameSql);
    rs = pst.executeQuery();
    rs.next();
    String name = rs.getString(1);
%>
<%--고정 화면 버튼--%>
<a href="../index.jsp">Soccer Link</a><input type="button" value="log out" onclick = "window.location.href='../common/logOutProc.jsp'">
<span><%=name%> 님 반갑습니다.</span>
<hr>
<input type="button" onclick = "window.location.href='changeInfo.jsp'" value="ChangeInfo">
<input type="button" onclick = "window.location.href='matchAppMana.jsp'" value="Match Apply">
<input type="button" onclick = "window.location.href='memberEval.jsp'" value = "Member Evaluation">
<input type = "button" onclick="secession()" value="Secession">
<hr>
<script>
    function secession(){
        const askTwice = prompt("정말로 탈퇴를 원하시면 '탈퇴'를 입력하십시오.");
        if(askTwice==='탈퇴'){
            window.location.href = "../common/secessionProc.jsp"
        }
        else{
            alert("잘못 입력했습니다.");
        }
    }
</script>

<%--고정 화면 버튼 end--%>
