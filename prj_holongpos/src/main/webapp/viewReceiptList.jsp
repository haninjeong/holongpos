<%@page import="dto.PageVO"%>
<%@page import="dto.OrderMenuDTO"%>
<%@page import="java.util.List"%>
<%@page import="dbcon.OrderMenuDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri= "http://java.sun.com/jsp/jstl/fmt" %>
<%
String id = (String) session.getAttribute("id");
if(id==null){
	out.print("<script>alert('로그인후 이용가능합니다.');location.href = 'login.jsp';</script>");
	 
}
OrderMenuDAO dao = new OrderMenuDAO();
String pagenum = request.getParameter("pagenum");
if(pagenum == null ){
	
	 pagenum = "1";
}
int num = Integer.parseInt(pagenum);
int amount = 5;
List<OrderMenuDTO> receiptList = dao.receiptList(num,amount);

pageContext.setAttribute("receiptList", receiptList);

int total = dao.totalOrderMenu();

PageVO pageing = new PageVO(num,amount,total);

pageContext.setAttribute("pageing",pageing);

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영수증관리</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href = "CSS/viewReceiptListCSS.css?var=9">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="JS/viewReceiptListScript.js?ver=13"></script>
</head>
<body>
<%@include file="header.jsp" %>

<div class="search-box">
<select  id="select">
	<option value="">선택</option>
	<option value="receiptno">영수증번호</option>
	<option value="payment">결제수단</option>
	
</select>
<input type="text" name="searchtext" id="searchtext">
<button id="search"><i class="fas fa-search"></i></button>
</div>
<br>
<br>
<div style="text-align: center;">
<table border="1" id="receiptList">
<thead>
	<tr>
		<th>*</th><th>영수증번호</th><th>결제날짜</th><th>총결제금액</th><th>결제수단</th><th>결제시간</th><th>거래구분</th>
	</tr>
</thead>
<tbody id="list">
<c:forEach var="receiptList" items="${receiptList }">
	<tr>
		<td><input type="radio" class="index" name="index"></td>
		<td class="receipt_no" onclick="openlist(${receiptList.receipt_no });">${receiptList.receipt_no }</td>
		<td><fmt:formatDate value="${receiptList.pay_date }" pattern="yy/MM/dd"/> 
		</td>
		<td><fmt:formatNumber value="${receiptList.totalprice}"  pattern="#,###"/></td>
		<td>${receiptList.payment}</td>
		<td>
		<fmt:formatDate value="${receiptList.pay_date }" pattern="HH:mm:ss"/> 
		</td>
		
		<c:if test="${receiptList.totalprice gt 0}">
		<td><c:out value="정상거래건"></c:out></td>
		</c:if>
		<c:if test="${receiptList.totalprice lt 0}">
		<td style="color: red"><c:out value="취소거래건"></c:out></td>
		</c:if>
	</tr>
</c:forEach>

</tbody>
</table>
</div>
<div id="noresult" style="text-align: center;"></div>
<br>
<div id="pageul" >
<c:forEach begin="${pageing.startPage }" end="${pageing.endPage }" var="num">

	<ul class="pagination">
		<li class="page-item" name="pageNum">${num }</li>
	</ul>

</c:forEach>
</div>
<br>
<button class="button" id="return">반품처리</button>

    <div id="modal" class="modal-overlay">
        <div class="modal-window">
            <div class="title">
            </div>
            <div class="close-area">X</div>
            <div class="content">
                
            </div>
        </div>
    </div>
</body>
</html>