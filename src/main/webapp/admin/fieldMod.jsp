
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="proc/loginCtrl.jsp"%>
<html>
<head>
</head>
<body>
<jsp:include page="menu.jsp"/>

<%
    String method = request.getParameter("method");
    if (method == null);
    else if(method.equals("update")){
%>
<div class="d-flex align-items-center justify-content-center">
    <form action="proc/field/update.jsp" method="post" class = "p-3 border border-black rounded" style ="width: 600px ; margin-top:50px">
        <fieldset>
            <legend>필드정보 수정</legend>
            <div class="mb-3">
                <label for="key" class="form-label">필드ID</label>
                <input type="text" name="key" id="key" class="form-control" placeholder="수정할 필드의 ID를 입력하시오." required>
            </div>
            <div class="mb-3">
                <label class="form-label">수정할 속성을 고르시오</label>
                <div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="attr" id="attr1" value="Name" required>
                        <label class="form-check-label" for="attr1">필드명</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="attr" id="attr2" value="Field_HP" required>
                        <label class="form-check-label" for="attr2">핸드폰번호</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="attr" id="attr3" value="Address" required>
                        <label class="form-check-label" for="attr3">주소</label>
                    </div>
                </div>
            </div>
            <div class="mb-3">
                <label for="value" class="form-label">새로운 값</label>
                <input type="text" name="value" id="value" class="form-control" placeholder="새로운 값을 입력하시오." required>
            </div>
            <button type="submit" class="btn btn-primary">submit</button>
        </fieldset>
    </form>
</div>

<%}else if(method.equals("delete")){ %>
<div class="d-flex align-items-center justify-content-center">
    <form action="proc/field/delete.jsp" method="post" class = "p-3 border border-black rounded" style ="width: 600px ; margin-top:50px">
        <fieldset>
            <legend>필드 삭제</legend>
            <div class="mb-3">
                <label for="key3" class="form-label">필드ID</label>
                <input type="text" name="key" id="key3" class="form-control" placeholder="삭제할 필드의 ID_NUMBER을 입력하시오." required>
            </div>
            <button type="submit" class="btn btn-primary">submit</button>
        </fieldset>
    </form>
</div>
<%} else if (method.equals("insert")) {%>
<div class="d-flex align-items-center justify-content-center">
    <form action="proc/field/insert.jsp" method="post" class = "p-3 border border-black rounded" style ="width: 600px ; margin-top:50px">
        <fieldset>
            <legend>필드 등록</legend>
            <div class="mb-3">
                <label for="key4" class="form-label">필드명</label>
                <input type="text" name="Name" id="key4" class="form-control" placeholder="필드명을 입력하시오." required>
            </div>
            <div class="mb-3">
                <label for="key5" class="form-label">필드 전화번호</label>
                <input type="text" name="Field_HP" id="key5" class="form-control" placeholder="필드 전화번호를 입력하시오." required>
            </div>
            <div class="mb-3">
                <label for="key6" class="form-label">필드 주소</label>
                <input type="text" name="Field_HP" id="key6" class="form-control" placeholder="필드 주소를 입력하시오." required>
            </div>
            <button type="submit" class="btn btn-primary">submit</button>
        </fieldset>
    </form>
</div>
<%}%>
</body>
</html>