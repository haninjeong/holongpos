<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link href='https://fonts.googleapis.com/css?family=Oswald:300' rel='stylesheet' type='text/css'>

<style>
* {
	-webkit-transition-property: all;
	-webkit-transition-duration: .2s;
  -moz-transition-timing-function: cubic-bezier(100,50,21,6);
	-moz-transition-property: all;
  -moz-transition-timing-function: cubic-bezier(100,50,21,6);
}

body{
  background:white;
  
  text-align:center;
  font-family: 'Oswald', sans-serif;
}

h1{
  color:#0a080d;
  font-weight:100;
}

.btn{
  color:#0a080d;
  background:#F1F5F7;
  padding:10px 20px;
  font-size:12px;
  text-decoration:none;
  letter-spacing:2px;
  text-transform:uppercase;
}

.btn:hover{
  border:none;
  background:rgba(0, 0, 0, 0.4);
  background:#fff;
  padding:20px 20px; #000;
  color:#1b1b1b;
}

.footer{
  font-size:8px;
  color:#fff;
  clear:both;
  display:block;
  letter-spacing:5px;
  border:1px solid #fff;
  padding:5px;
  text-decoration:none;
  width:210px;
  margin:auto;
  margin-top:400px;
}

</style>
<body>
<h1>HOLONGPOS</h1>
	<a href="main.jsp" class="btn">홈</a>
    <a href="index.jsp" class="btn">판매</a>
    <a href="closeShop.jsp" class="btn">영업마감</a>
    <a href="menuManageMent.jsp" class="btn">메뉴관리</a>
    <a href="viewReceiptList.jsp" class="btn">영수증관리</a>
    <a href="salesInquiry.jsp" class="btn">매출조회</a>
    <a href="popmenu.jsp" class="btn">인기메뉴조회</a>
  
</body>
</html>