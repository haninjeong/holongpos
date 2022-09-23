<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>HOLONGPOS 로그인</title>
</head>
<link rel="stylesheet" type="text/css" href="CSS/login.css">
<script src="JS/login.js"></script>

<body>
<section>
<div class="container">
  <div class="left">
    <div class="header">
      <h2 class="animation a1">HOLONG POS</h2>
      <h4 class="animation a2">아이디와 비밀번호를 입력해주세요</h4>
    </div>
    <div class="form">
      <input type="text" class="form-field animation a3" id="id" placeholder="아이디">
      <input type="password"  id="pw" class="form-field animation a4" placeholder="비밀번호">
      <p class="animation a5"><a href="explansation">HOLONG POS가 처음이세요?</a></p>
      <button class="animation a6" id="login">LOGIN</button>
    </div>
  </div>
  <div class="right"></div>
</div>
</section>
</body>
</html>