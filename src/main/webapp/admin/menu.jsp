<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"rel="stylesheet">
</head>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<nav class="navbar navbar-expand-lg">
<div class="container-fluid">
<a class="navbar-brand"href="../index.jsp"><img src="../image/webLogo.png"style="width: 200px"></a>
<div class="collapse navbar-collapse"id="navbarScroll">
<ul class="navbar-nav me-auto my-2 my-lg-0 navbar-nav-scroll"style="--bs-scroll-height: 100px;">
<li class="nav-item dropdown">
<a class="nav-link dropdown-toggle"href="#"role="button"data-bs-toggle="dropdown"aria-expanded="false">
        사용자
</a>
<ul class="dropdown-menu">
<li><a class="dropdown-item"href="userMod.jsp?method=delete">삭제</a></li>
</ul>
</li>
<li class="nav-item dropdown">
<a class="nav-link dropdown-toggle"href="#"role="button"data-bs-toggle="dropdown"aria-expanded="false">
        팀
</a>
<ul class="dropdown-menu">
<li><a class="dropdown-item"href="teamMod.jsp?method=update">수정</a></li>
<li><a class="dropdown-item"href="teamMod.jsp?method=delete">삭제</a></li>
</ul>
</li>
<li class="nav-item dropdown">
<a class="nav-link dropdown-toggle"href="#"role="button"data-bs-toggle="dropdown"aria-expanded="false">
        소유주
</a>
<ul class="dropdown-menu">
<li><a class="dropdown-item"href="ownerMod.jsp?method=insert">추가</a></li>
<li><a class="dropdown-item"href="ownerMod.jsp?method=update">수정</a></li>
<li><a class="dropdown-item"href="ownerMod.jsp?method=delete">삭제</a></li>
</ul>
</li>
<li class="nav-item dropdown">
<a class="nav-link dropdown-toggle"href="#"role="button"data-bs-toggle="dropdown"aria-expanded="false">
        필드
</a>
<ul class="dropdown-menu">
<li><a class="dropdown-item"href="fieldMod.jsp?method=insert">추가</a></li>
<li><a class="dropdown-item"href="fieldMod.jsp?method=update">수정</a></li>
<li><a class="dropdown-item"href="fieldMod.jsp?method=delete">삭제</a></li>
</ul>
</li>
<li class="nav-item dropdown">
<a class="nav-link dropdown-toggle"href="#"role="button"data-bs-toggle="dropdown"aria-expanded="false">
        매치
</a>
<ul class="dropdown-menu">
<li><a class="dropdown-item"href="matchMod.jsp?method=insert">추가</a></li>
<li><a class="dropdown-item"href="matchMod.jsp?method=update">수정</a></li>
<li><a class="dropdown-item"href="matchMod.jsp?method=delete">삭제</a></li>
</ul>
</li>
<li class="nav-item dropdown">
<a class="nav-link dropdown-toggle"href="#"role="button"data-bs-toggle="dropdown"aria-expanded="false">
        트레이닝
</a>
<ul class="dropdown-menu">
<li><a class="dropdown-item"href="trainMod.jsp?method=update">수정</a></li>
<li><a class="dropdown-item"href="trainMod.jsp?method=delete">삭제</a></li>
</ul>
</li>
<li class="nav-item dropdown">
<a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
        정보확인
</a>
<ul class="dropdown-menu">
<li><a class="dropdown-item" href="checkInfo.jsp?category=Owner">소유주&필드 조회</a></li>
<li><a class="dropdown-item" href="checkInfo.jsp?category=Match">매치 조회</a></li>
<li><a class="dropdown-item" href="checkInfo.jsp?category=Training">트레이닝 조회</a></li>
</ul>
</li>
</ul>
<div class="d-flex"role="search">
<ul class="navbar-nav me-auto mb-2 mb-lg-0 justify-content-end">
<li class="nav-item">
<a class="nav-link active"aria-current="page"href="../common/logOutProc.jsp">Log out</a>
</li>
</ul>
</div>
</div>
</div>
</nav>
