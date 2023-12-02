<%--
  Created by IntelliJ IDEA.
  User: 황경모
  Date: 2023-12-01
  Time: 오후 11:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Manager Mypage</title>
</head>
<body>
<%--home 버튼--%>
<a href="../index.jsp">Soccer Link</a>
<hr>
항목을 선택하시오.
</br>
개인정보 변경: <input type="button" onclick = "window.location.href='changeInfo.jsp'" value="ChangeInfo">
</br>
매치 매니저 신청: <input type="button" onclick = "window.location.href='matchAppMana.jsp'" value="Match Apply">
</br>
플레이어 평가: <input type="button" onclick = "window.location.href='memberEval.jsp'" value = "Member Evaluation">
</br>

<%--Secession 버튼--%>
회원 탈퇴: <input type = "button" onclick="secession()" value="Secession">
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

</body>
</html>
