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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
	
<style>

section {
  	font-size: 16px;
	position: fixed;
	box-sizing: border-box;
	width: 450px;
	
	top: 12px;
	right: -700px;
	max-width: calc(100vw - 24px);
	max-height: calc(100vh - 24px);
	background-color: white;
	transform-origin: 95% 5%;
	transform: scale(0.8);
	
	box-shadow: 0 4px 10px 2px rgba(0, 0, 0, 0.1),
		0 5px 20px 5px rgba(0, 0, 0, 0.08),
		0 10px 30px 10px rgba(0, 0, 0, 0.08);
	
	background-color: #f7f5eb;
	padding: 2em;
}




button#why {
	color: rgba(0, 0, 0, 0.3);
	width: 40px;
	height: 40px;
	padding: 16px;
	box-sizing: content-box;
	position: fixed;
	top: 0;
	right: 0;
}



</style>
<script type="text/javascript">

$(function(){
	
	$("#why").click(focus);
	$("#close").click(focusout);





})


function focus(){
	alert("클릭");
	var why = document.getElementById('why');
	var section = document.getElementById('section');

	
	var px = "12px";
	why.style.right = px;
	section.style.right = px;


	
	
}

function focusout(){
	alert("클릭");
	
	var px = "";
	why.style.right = px;
	section.style.right = px;


	
	
}




</script>
<body>

<button id="why" >hi</button>
	<section id="section">
		<input type="button" id="close" 
		style="color: black; font-size: 20px;" value="x">
	
		hi
	</section>


</body>


</html>