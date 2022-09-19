<%@page import="java.text.DecimalFormat"%>
<%@page import="dbcon.SalesDAO"%>
<%@page import="dto.OrderMenuDTO"%>
<%@page import="java.util.List"%>
<%@page import="dbcon.OrderMenuDAO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String id = (String) session.getAttribute("id");
if(id==null){
	out.print("<script>alert('로그인후 이용가능합니다.');location.href = 'login.jsp';</script>");
	
} 
Date date = new Date();

String pattrtn = "yyyyMMdd";
SimpleDateFormat sdf = new SimpleDateFormat(pattrtn);

int startDate = Integer.parseInt(sdf.format(date));
SalesDAO salesDao = new SalesDAO();

int result = salesDao.selectclose(startDate);

OrderMenuDAO dao = new OrderMenuDAO();

int openMoney = salesDao.openMoney(startDate);

DecimalFormat decFormat = new DecimalFormat("###,###");

List<OrderMenuDTO> cashlist = dao.closecash(startDate);

List<OrderMenuDTO> cardlist = dao.closecard(startDate);

pageContext.setAttribute("cashlist", cashlist);
pageContext.setAttribute("cardlist", cardlist);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마감</title>
<link rel="stylesheet" type="text/css" href = "CSS/closeShopCSS.css?var=5">
<link href='https://fonts.googleapis.com/css?family=Oswald:300' rel='stylesheet' type='text/css'>

</head>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">


$(function(){
	
	
	let ea = 0;
	
		$("#cals").on("click",function(event){
			
			let total = 0;
			var money_arr = new Array();
			var money = $(".money");
			  $('.money').each(function() {
				money_arr.push(this.value);
				
			})
			
			console.log(money_arr);
			
			if(money_arr[0] != ''){
				total += parseInt(money_arr[0])*parseInt(50000);
				console.log("5만합계:"+total);
			}
			if(money_arr[1] != ''){
				total += parseInt(money_arr[1])*parseInt(10000);
				console.log("1만합계:"+total);
			}
			if(money_arr[2] != ''){
				total += parseInt(money_arr[2])*parseInt(5000);
				console.log("합계:"+total);
			}
			if(money_arr[3] != ''){
				total += parseInt(money_arr[3])*parseInt(1000);
				console.log("합계:"+total);
			}
			if(money_arr[4] != ''){
				total += parseInt(money_arr[4])*parseInt(500);
				console.log("합계:"+total);
			}
			if(money_arr[5] != ''){
				total += parseInt(money_arr[5])*parseInt(100);
				console.log("합계:"+total);
			}
			if(money_arr[6] != ''){
				total += parseInt(money_arr[6])*parseInt(50);
				console.log("합계:"+total);
			}
			if(money_arr[7] != ''){
				total += parseInt(money_arr[7])*parseInt(10);
				console.log("합계:"+total);
			}
			
			
			console.log("합계:"+total);
			let comma = total.toLocaleString('ko-KR');
			$("#moneysum").html(comma);
			
			var openMoney = <%=openMoney%>;
			
			var totalMoney = parseInt(openMoney)-parseInt(total);
			let comma1 = totalMoney.toLocaleString("ko-KR");
			$("#totalcash").html(comma1);
			
	
	
	
	});
	
	$("#closeshop").click(function(){
		
		var totalcash = $("#totalcash").html();
		var result = <%=result%>;
		
		var msg = "기존 정산건이 있습니다.\n 기존등록건을 취소 하시겠습니까?"
		
		 if (result == 1){
			if(confirm(msg) == true){
				
				var closedate = <%=startDate%>;
				$.ajax({

					url : "DelectCloseShop.do",
					type : 'post',
					dataType : 'text',

					data : {
						"closedate" : closedate,
						

					},

					success : function(result) {

						if (result == 1) {
							alert("정상적으로 마감건이 취소처리되었습니다.");
							
							

						} else if (result == 0) {
							alert("서버오류로 인해 되지않았어요")

						}

					},
					error : function(data) {
						alert("오류");
					}
				})
			
			}else if(confirm(msg) == false){
				return;
			}
		 }else{
			 

				if(totalcash != "0"){
					alert("현금 시재가 맞지않습니다.")
				}else{
					
					var message = "정말로 마감하시겠습니까??";
					
				    result = window.confirm(message);
				    console.log(result);
				    if(result){
				    	
				    	
				    	var cashsales = uncomma($("#cashsales").html());
						var cardsales = uncomma($("#cardsales").html());
						console.log("현금"+cashsales+"카드"+cardsales);
						
						$.ajax({
		
							url : "ShopCalculate.do",
							type : 'post',
							dataType : 'text',
		
							data : {
								"cashsales" : cashsales,
								"cardsales" : cardsales,
		
							},
		
							success : function(result) {
		
								if (result == 1) {
									alert("정상적으로 마감처리되었습니다.");
									window.location.href = "login.jsp"
									
		
								} else if (result == 0) {
									alert("서버오류로 인해 되지않았어요")
		
								}
		
							},
							error : function(data) {
								alert("오류");
							}
						})
						
						
						
				       
				    }else{
				        console.log("취소 되었습니다.");
				    }
					
				}
			 
		 	}
			 
		});
			
			
		
});
			

function uncomma(str) {
		str = String(str);
		return str.replace(/[^\d]+/g, '');
	}









</script>
<body>
<%@include file="header.jsp" %>
<div class="container">
  <div class="middle">
	<div class="middle-left">
			<ul>
				<li class="pettycash"><h2>현금시재</h2> <button id="cals">합계확인</button></li>
				<li class="pettycash">오만원권 <input type="number" class="money"></li>
				<li class="pettycash">만원권 <input type="number" class="money"></li>
				<li class="pettycash">오천원권 <input type="number" class="money"></li>
				<li class="pettycash">천원권 <input type="number" class="money"></li>
				<li class="pettycash">오백원 <input type="number" class="money"></li>
				<li class="pettycash">백 원 <input type="number" class="money"></li>
				<li class="pettycash">오십원 <input type="number" class="money"></li>
				<li class="pettycash">십원 <input type="number" class="money"></li>
				
				<li>시제 합계 : <span id="moneysum"></span>원
				</li>
		
			</ul>
	</div>
	<div class="middle-right">
		<div class="middle-right-1">
			<ul>
				<c:forEach var="cardlist" items="${cardlist }">
					<li><h2>마감 카드</h2></li>
					<li>카드 매출액 : <span id="cardsales"><fmt:formatNumber
								value="${cardlist.totalprice}" pattern="#,###" /></span>원
					</li>
					<li>카드 매출건수 : ${cardlist.totalno}건</li>
				</c:forEach>
			</ul>
		</div>
		<div class="middle-right-2">
			<ul>
				<c:forEach var="cashlist" items="${cashlist }">
					<li><h2>마감현금정산</h2></li>
					<li>준비금 : <%=decFormat.format(openMoney)%>원
					</li>
		
					<li>현금 매출액 : <span id="cashsales"><fmt:formatNumber
								value="${cashlist.totalprice}" pattern="#,###" /></span>원
					</li>
		
					<li>현금 매출 건수 : ${cashlist.totalno}건</li>
					<li>합계 : <span id="totalcash"></span>원
					</li>
				</c:forEach>
			</ul>
		</div>
		<div class="middle-right-3">
			<button id="closeshop" class="shiny-btn">영업마감</button>
		</div>
	 </div>
	 
	</div>	
</div>	 
</body>
</html>