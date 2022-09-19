
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
<link rel="stylesheet" type="text/css" href="CSS/selcss1.css?ver=33">
<script src="JS/selJavaScript1.js?ver=13"></script>

</head>
<body>
	<%@include file="header.jsp"%>
	<br>
	<br>
	<div>
		<span> 판매일자 :<%=sdf.format(date)%></span> &nbsp;&nbsp;&nbsp; <span>현재시간:<span
			id="clock"></span>
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

					<input type="button" id="orderout" class="item2" value="전체취소">
					<input type="button" id="onedeleteorder" class="item2" value="선택취소">
					<input type="button" id="sale" class="item2" value="단가변경">
					<input type="button" id="changeamount" class="item2" value="수량변경">
					<input type="button" id="btn_sub" class="item2" value="수량뺴기">
					<input type="button" id="btn_add" class="item2" value="수량더하기">

				</div>

				<div class="middle-left-3">
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
								<td colspan="3"><input type="number" class="box1"
									name="box1"></td>
							</tr>
							<tr>
								<td class="box">9</td>
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
								<input type="button" class="button"
									onclick="pos.addorder('${menuList.name }', ${menuList.price })"
									value="${menuList.name }(${menuList.price })">



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

	<button id="why">
		<svg viewBox="0 0 24 24">
					<path
				d="M11 18h2v-2h-2v2zm1-16C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8zm0-14c-2.21 0-4 1.79-4 4h2c0-1.1.9-2 2-2s2 .9 2 2c0 2-3 1.75-3 5h2c0-2.25 3-2.5 3-5 0-2.21-1.79-4-4-4z"
				style="fill:currentColor;" />
				</svg>
	</button>
	<section id="section">
		<input type="button" id="close" style="color: black; font-size: 20px;"
			value="x">
		<form>
			<div id="digit1">
				<input type="checkbox" id="d1-1" class="number1"> <input
					type="checkbox" id="d1-2" class="number2"> <input
					type="checkbox" id="d1-3" class="number3"> <input
					type="checkbox" id="d1-4" class="number4"> <input
					type="checkbox" id="d1-5" class="number5"> <input
					type="checkbox" id="d1-6" class="number6"> <input
					type="checkbox" id="d1-7" class="number7"> <input
					type="checkbox" id="d1-8" class="number8"> <input
					type="checkbox" id="d1-9" class="number9">
				<div id="digit2">
					<input type="checkbox" id="d2-0" class="number0"> <input
						type="checkbox" id="d2-1" class="number1"> <input
						type="checkbox" id="d2-2" class="number2"> <input
						type="checkbox" id="d2-3" class="number3"> <input
						type="checkbox" id="d2-4" class="number4"> <input
						type="checkbox" id="d2-5" class="number5"> <input
						type="checkbox" id="d2-6" class="number6"> <input
						type="checkbox" id="d2-7" class="number7"> <input
						type="checkbox" id="d2-8" class="number8"> <input
						type="checkbox" id="d2-9" class="number9">
					<div id="digit3">
						<input type="checkbox" id="d3-0" class="number0"> <input
							type="checkbox" id="d3-1" class="number1"> <input
							type="checkbox" id="d3-2" class="number2"> <input
							type="checkbox" id="d3-3" class="number3"> <input
							type="checkbox" id="d3-4" class="number4"> <input
							type="checkbox" id="d3-5" class="number5"> <input
							type="checkbox" id="d3-6" class="number6"> <input
							type="checkbox" id="d3-7" class="number7"> <input
							type="checkbox" id="d3-8" class="number8"> <input
							type="checkbox" id="d3-9" class="number9">
						<div id="digit4">
							<input type="checkbox" id="d4-0" class="number0"> <input
								type="checkbox" id="d4-1" class="number1"> <input
								type="checkbox" id="d4-2" class="number2"> <input
								type="checkbox" id="d4-3" class="number3"> <input
								type="checkbox" id="d4-4" class="number4"> <input
								type="checkbox" id="d4-5" class="number5"> <input
								type="checkbox" id="d4-6" class="number6"> <input
								type="checkbox" id="d4-7" class="number7"> <input
								type="checkbox" id="d4-8" class="number8"> <input
								type="checkbox" id="d4-9" class="number9">
							<div id="digit5">
								<input type="checkbox" id="d5-0" class="number0"> <input
									type="checkbox" id="d5-1" class="number1"> <input
									type="checkbox" id="d5-2" class="number2"> <input
									type="checkbox" id="d5-3" class="number3"> <input
									type="checkbox" id="d5-4" class="number4"> <input
									type="checkbox" id="d5-5" class="number5"> <input
									type="checkbox" id="d5-6" class="number6"> <input
									type="checkbox" id="d5-7" class="number7"> <input
									type="checkbox" id="d5-8" class="number8"> <input
									type="checkbox" id="d5-9" class="number9">
								<div id="digit6">
									<input type="checkbox" id="d6-0" class="number0"> <input
										type="checkbox" id="d6-1" class="number1"> <input
										type="checkbox" id="d6-2" class="number2"> <input
										type="checkbox" id="d6-3" class="number3"> <input
										type="checkbox" id="d6-4" class="number4"> <input
										type="checkbox" id="d6-5" class="number5"> <input
										type="checkbox" id="d6-6" class="number6"> <input
										type="checkbox" id="d6-7" class="number7"> <input
										type="checkbox" id="d6-8" class="number8"> <input
										type="checkbox" id="d6-9" class="number9">
									<div id="digit7">
										<input type="checkbox" id="d7-0" class="number0"> <input
											type="checkbox" id="d7-1" class="number1"> <input
											type="checkbox" id="d7-2" class="number2"> <input
											type="checkbox" id="d7-3" class="number3"> <input
											type="checkbox" id="d7-4" class="number4"> <input
											type="checkbox" id="d7-5" class="number5"> <input
											type="checkbox" id="d7-6" class="number6"> <input
											type="checkbox" id="d7-7" class="number7"> <input
											type="checkbox" id="d7-8" class="number8"> <input
											type="checkbox" id="d7-9" class="number9">
										<div id="digit8">
											<input type="checkbox" id="d8-0" class="number0"> <input
												type="checkbox" id="d8-1" class="number1"> <input
												type="checkbox" id="d8-2" class="number2"> <input
												type="checkbox" id="d8-3" class="number3"> <input
												type="checkbox" id="d8-4" class="number4"> <input
												type="checkbox" id="d8-5" class="number5"> <input
												type="checkbox" id="d8-6" class="number6"> <input
												type="checkbox" id="d8-7" class="number7"> <input
												type="checkbox" id="d8-8" class="number8"> <input
												type="checkbox" id="d8-9" class="number9">
											<div id="operations">
												<input type="checkbox" id="add"> <input
													type="checkbox" id="subtract"> <input
													type="checkbox" id="multiply"> <input
													type="checkbox" id="divide"> <input type="checkbox"
													id="equals">
												<main>
													<div id="screen">
														<div id="input"></div>
														<div id="output"></div>
													</div>
													<div id="buttons">
														<button type="button">
															<label for="d8-7" class="digit8"></label> <label
																for="d7-7" class="digit7"></label> <label for="d6-7"
																class="digit6"></label> <label for="d5-7" class="digit5"></label>
															<label for="d4-7" class="digit4"></label> <label
																for="d3-7" class="digit3"></label> <label for="d2-7"
																class="digit2"></label> <label for="d1-7" class="digit1"></label>
															7
														</button>
														<button type="button">
															<label for="d8-8" class="digit8"></label> <label
																for="d7-8" class="digit7"></label> <label for="d6-8"
																class="digit6"></label> <label for="d5-8" class="digit5"></label>
															<label for="d4-8" class="digit4"></label> <label
																for="d3-8" class="digit3"></label> <label for="d2-8"
																class="digit2"></label> <label for="d1-8" class="digit1"></label>
															8
														</button>
														<button type="button">
															<label for="d8-9" class="digit8"></label> <label
																for="d7-9" class="digit7"></label> <label for="d6-9"
																class="digit6"></label> <label for="d5-9" class="digit5"></label>
															<label for="d4-9" class="digit4"></label> <label
																for="d3-9" class="digit3"></label> <label for="d2-9"
																class="digit2"></label> <label for="d1-9" class="digit1"></label>
															9
														</button>
														<button type="button">
															<label for="divide"></label>&divide;
														</button>
														<button type="button">
															<label for="d8-4" class="digit8"></label> <label
																for="d7-4" class="digit7"></label> <label for="d6-4"
																class="digit6"></label> <label for="d5-4" class="digit5"></label>
															<label for="d4-4" class="digit4"></label> <label
																for="d3-4" class="digit3"></label> <label for="d2-4"
																class="digit2"></label> <label for="d1-4" class="digit1"></label>
															4
														</button>
														<button type="button">
															<label for="d8-5" class="digit8"></label> <label
																for="d7-5" class="digit7"></label> <label for="d6-5"
																class="digit6"></label> <label for="d5-5" class="digit5"></label>
															<label for="d4-5" class="digit4"></label> <label
																for="d3-5" class="digit3"></label> <label for="d2-5"
																class="digit2"></label> <label for="d1-5" class="digit1"></label>
															5
														</button>
														<button type="button">
															<label for="d8-6" class="digit8"></label> <label
																for="d7-6" class="digit7"></label> <label for="d6-6"
																class="digit6"></label> <label for="d5-6" class="digit5"></label>
															<label for="d4-6" class="digit4"></label> <label
																for="d3-6" class="digit3"></label> <label for="d2-6"
																class="digit2"></label> <label for="d1-6" class="digit1"></label>
															6
														</button>
														<button type="button">
															<label for="multiply"></label>&times;
														</button>
														<button type="button">
															<label for="d8-1" class="digit8"></label> <label
																for="d7-1" class="digit7"></label> <label for="d6-1"
																class="digit6"></label> <label for="d5-1" class="digit5"></label>
															<label for="d4-1" class="digit4"></label> <label
																for="d3-1" class="digit3"></label> <label for="d2-1"
																class="digit2"></label> <label for="d1-1" class="digit1"></label>
															1
														</button>
														<button type="button">
															<label for="d8-2" class="digit8"></label> <label
																for="d7-2" class="digit7"></label> <label for="d6-2"
																class="digit6"></label> <label for="d5-2" class="digit5"></label>
															<label for="d4-2" class="digit4"></label> <label
																for="d3-2" class="digit3"></label> <label for="d2-2"
																class="digit2"></label> <label for="d1-2" class="digit1"></label>
															2
														</button>
														<button type="button">
															<label for="d8-3" class="digit8"></label> <label
																for="d7-3" class="digit7"></label> <label for="d6-3"
																class="digit6"></label> <label for="d5-3" class="digit5"></label>
															<label for="d4-3" class="digit4"></label> <label
																for="d3-3" class="digit3"></label> <label for="d2-3"
																class="digit2"></label> <label for="d1-3" class="digit1"></label>
															3
														</button>
														<button type="button">
															<label for="subtract"></label>-
														</button>
														<button type="button">
															<input type="reset" value="AC">
														</button>
														<button type="button">
															<label for="d8-0" class="digit8"></label> <label
																for="d7-0" class="digit7"></label> <label for="d6-0"
																class="digit6"></label> <label for="d5-0" class="digit5"></label>
															<label for="d4-0" class="digit4"></label> <label
																for="d3-0" class="digit3"></label> <label for="d2-0"
																class="digit2"></label> <label for="d1-0" class="digit1"></label>
															0
														</button>
														<button type="button">
															<label for="equals"></label>=
														</button>
														<button type="button">
															<label for="add"></label>+
														</button>
													</div>
												</main>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</section>














</body>
</html>