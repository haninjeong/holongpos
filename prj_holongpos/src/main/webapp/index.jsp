
<%@page import="dto.MenuDTO"%>
<%@page import="dbcon.MenuDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String id = (String) session.getAttribute("id");
if (id == null) {
	out.print("<script>alert('로그인후 이용가능합니다.');location.href = 'login.jsp';</script>");

}
Date date = new Date();
String pattrtn = "yy년 MM월 dd일 [E]";

SimpleDateFormat sdf = new SimpleDateFormat(pattrtn);

MenuDAO menuDao = new MenuDAO();
String typebread = "단과자";
List<MenuDTO> menuList = menuDao.menuList(typebread);
pageContext.setAttribute("menuList", menuList);

List<MenuDTO> breadList = menuDao.breadList();
pageContext.setAttribute("breadList", breadList);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="CSS/selcss1.css?ver=26">
<script src="JS/selJavaScript1.js?ver=11"></script>

</head>
<body>
	<%@include file="header.jsp"%>
	<br>
	<br>
	<div>
		<span> 판매일자 :<%=sdf.format(date)%></span> &nbsp;&nbsp;&nbsp; <span>현재시간:<span id="clock"></span>
		</span>
	</div>
	
	<div class="container">
		<div class="middle">
			<div class="middle-left">
				<div class="middle-left-1">
					<table id="ordermenu" border="1">
						<thead>
							<tr>
								<th></th>
								<th>*</th>
								<th>메뉴명</th>
								<th>단가</th>
								<th>수량</th>
								<th>금액</th>
								<th>비고</th>
							</tr>
						</thead>
						<tbody class="orderBoard">

						</tbody>

					</table>
				</div>
				<div class="middle-left-2">
					
						<button id="orderout" class="item2">전체취소</button>
						<button id="onedeleteorder" class="item2">선택취소</button>
						<button id="sale" class="item2">단가변경</button>
						<button id="changeamount" class="item2">수량변경</button>
						<button id="btn_sub" class="item2">수량뺴기</button>
						<button id="btn_add" class="item2">수량더하기</button>
					
				</div>

				<div class="middle-left-3" >
					<table id="Paymentinformation" border="1">
						<thead>
							<tr>
								<th>결제정보</th>
								<th>결제금액</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>총금액</td>
								<td><span class="totalPrice">0</span></td>
							</tr>

							<tr>
								<td>받을금액</td>
								<td><span class="totalPrice">0</span></td>
							</tr>

						</tbody>
					</table>
					
					<div style="float: right; top: -10px;">
						<table border="1" class="boxs">
							<tr>
								<td colspan="3"><input type="number" class="box1" name="box1"></td>
							</tr>
							<tr>
								<td class="box" >9</td>
								<td class="box">8</td>
								<td class="box">7</td>
							</tr>
							<tr>
								<td class="box">6</td>
								<td class="box">5</td>
								<td class="box">4</td>
							</tr>
							<tr>
								<td class="box">3</td>
								<td class="box">2</td>
								<td class="box">1</td>
							</tr>
							<tr>
								<td class="box">0</td>
								<td class="box">00</td>
								<td class="box2">C</td>
								
							</tr>
							<tr>
								<td colspan="3" class="box4">AC</td>
								
								
							</tr>
							
							
						</table>  
					 </div>
				  </div>
					
					
				</div>
			
			<br>
			<div class="middle-right">
				<div class="middle-right-1">
					<div id="menuList">
						<c:forEach var="bread" items="${breadList }">
							<input type="button" class="bread" name="typebread"
								value="${bread.typebread }" class="button">
						</c:forEach>
						<div id="menuviewList">
							<c:forEach var="menuList" items="${menuList }">
								<button class="button"
									onclick="pos.addorder('${menuList.name }', ${menuList.price })">${menuList.name }<br>(${menuList.price })</button>


							</c:forEach>
						</div>
					</div>
				</div>	
					<div class="middle-right-2">

						<button id="cash" value="현금" class="Calculation">현금</button>
						<button id="card" value="카드" class="Calculation">카드</button>
						<br> <br> <br>

					</div>
					
	 
					
				</div>
			</div>
		</div>
		
	
</body>
</html>