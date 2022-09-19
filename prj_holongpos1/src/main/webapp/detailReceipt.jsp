<%@page import="dto.OrderMenuDTO"%>
<%@page import="dbcon.OrderMenuDAO"%>
<%@page import="dto.View_ReceiptDTO"%>
<%@page import="java.util.List"%>
<%@page import="dbcon.View_ReceiptDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%
View_ReceiptDAO viewdao = new View_ReceiptDAO();
OrderMenuDAO orderdao = new OrderMenuDAO();
String num = request.getParameter("num");
int receiptnum=Integer.parseInt(num);
List<View_ReceiptDTO> receiptList = viewdao.receiptList(receiptnum);
List<OrderMenuDTO> orderList = orderdao.orderList(receiptnum);
pageContext.setAttribute("receiptList",receiptList);
 
pageContext.setAttribute("order",orderList);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세영수증페이지</title>
</head>
<style>
  table {
    width: 100%;
    border-top: 1px dotted #444444;
    border-collapse: collapse;
  }
  th, td {
    border-bottom: 1px dotted #444444;
    padding: 10px;
  }
</style>
<body>
<h1 style="text-align: center;">*영수증*</h1>
<hr>
<table >

<thead>
	<tr>
		<th>상품명</th><th>단가</th><th>수량</th><th>매출금액</th>
	</tr>
</thead>
<tbody>

<c:forEach var ="receiptList" items="${receiptList }">
	<tr>
		<td>${receiptList.value }</td>
		<td><fmt:formatNumber value="${receiptList.price }" pattern="#,###" /> </td>
		<td>${receiptList.ea }</td>
		<td><fmt:formatNumber value="${receiptList.totalprice }" pattern="#,###" /></td>
	</tr>
</c:forEach>
<c:forEach var ="order" items="${order}">
	<tr>
		<td>부가세과세물품가액:</td><td></td><td><td><fmt:formatNumber type="number" maxFractionDigits="0"  value="${order.totalprice*100/110}" /></td>
	</tr>
	<tr>
		<td>부가세:</td><td></td><td></td><td><fmt:formatNumber type="number" maxFractionDigits="0"  value="${order.totalprice*10/110}" /></td>
	</tr>
	<tr>
		<td>합계금액:</td><td></td><td></td><td colspan="2"><fmt:formatNumber value="${order.totalprice}" pattern="#,###" /></td>
	</tr>

<c:if test="${order.payment eq '현금'}">
	<tr>
		<td>현금 :</td><td></td><td></td><td><fmt:formatNumber value="${order.totalprice}" pattern="#,###" /></td>
	</tr>
</c:if>
<c:if test="${order.payment eq '카드'}">
	<tr>
		<td>신용카드 :</td><td></td><td></td><td><fmt:formatNumber value="${order.totalprice}" pattern="#,###" /></td>
	</tr>
</c:if>
	<tr>
		<td>거래일시</td><td></td><td></td><td>${order.pay_date}</td>
	</tr>
	<tr>
		<td></td><td><small>건강한 재료로 보답하겟습니다.</small></td><td></td><td></td>
	</tr>
</c:forEach>

</tbody>
</table>



</body>
</html>