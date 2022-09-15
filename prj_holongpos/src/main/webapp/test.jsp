<%@page import="dto.OrderMenuDTO"%>
<%@page import="java.util.List"%>
<%@page import="dbcon.OrderMenuDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%
 
OrderMenuDAO orderdao =new OrderMenuDAO();
List<OrderMenuDTO> orderList =orderdao.orderList(7001);
pageContext.setAttribute("order",orderList);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:forEach var ="order" items="${order}">
합계금액:${order.totalprice}
</c:forEach>
</body>
</html>