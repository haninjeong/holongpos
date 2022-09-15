<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="dbcon.View_ReceiptDAO"%>
<%@page import="dto.View_ReceiptDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String id = (String) session.getAttribute("id");
if(id == null){
	out.print("<script>alert('로그인후 이용가능합니다.');location.href = 'login.jsp';</script>");
	
} 

View_ReceiptDAO Dao = new View_ReceiptDAO();

Date date = new Date();

String pattrtn = "yyyyMMdd";
SimpleDateFormat sdf = new SimpleDateFormat(pattrtn);

int startDate = Integer.parseInt(sdf.format(date));

Calendar week = Calendar.getInstance();
week.add(Calendar.DATE, -7);
SimpleDateFormat sdf1 = new SimpleDateFormat(pattrtn);

int lastDate = Integer.parseInt(sdf1.format(week.getTime()));

List<View_ReceiptDTO> popValueList = Dao.popValueList(lastDate,startDate);


pageContext.setAttribute("PopMenu", popValueList);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인기메뉴조회</title>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<style>
#popMenu{
width: 500px;
height: 500px;
text-align: center;
font-size: 25px;
margin: auto;
border: 1px medium black;
border-collapse: collapse;
}



</style>
<script>
	$(function() {
		$("#datepicker1,#datepicker2")
				.datepicker(
						{
							dateFormat : 'yy-mm-dd' //달력 날짜 형태
							,
							showOtherMonths : true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
							,
							showMonthAfterYear : true // 월- 년 순서가아닌 년도 - 월 순서
							,
							changeYear : true //option값 년 선택 가능
							,
							changeMonth : true //option값  월 선택 가능                
							,
							showOn : "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
							,
							buttonImage : "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
							,
							buttonImageOnly : true //버튼 이미지만 깔끔하게 보이게함
							,
							buttonText : "선택" //버튼 호버 텍스트              
							,
							yearSuffix : "년" //달력의 년도 부분 뒤 텍스트
							,
							monthNamesShort : [ '1월', '2월', '3월', '4월', '5월',
									'6월', '7월', '8월', '9월', '10월', '11월', '12월' ] //달력의 월 부분 텍스트
							,
							monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월',
									'7월', '8월', '9월', '10월', '11월', '12월' ] //달력의 월 부분 Tooltip
							,
							dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ] //달력의 요일 텍스트
							,
							dayNames : [ '일요일', '월요일', '화요일', '수요일', '목요일',
									'금요일', '토요일' ] //달력의 요일 Tooltip
							,
							minDate : "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
							,
							maxDate : "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)  
						});
						$('#datepicker1,#datepicker2').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)            

				$("#search").click(function() {
		
					var startDate = $("#datepicker1").val();
					var lastDate = $("#datepicker2").val();
					
		
					$.ajax({
		
						url : "PopmenuList.do",
						type : "get",
						data : {
		
							"startDate" : $("#datepicker1").val(),
							"lastDate" : $("#datepicker2").val(),
		
						},
						dataType : "json",
						success : function(data) {
							
							console.log(data);
		
							$("#popmenuList").empty();
							var sjsonInfo = JSON.stringify(data);
							var jsonInfo = JSON.parse(sjsonInfo);
							var result = '';
		
							for ( var i in jsonInfo.popmenuList) {
		
								var name = jsonInfo.popmenuList[i].name;
								var ea = jsonInfo.popmenuList[i].ea;
								if(ea != 1){
									result += '<tr><td>' + name + '</td>';
									result += '<td>' + ea + '</td></tr>';
									
								}	
								
									
		
								
		
							}
							$("#popmenuList").append(result);
		
						},
						error : function(result) {
							alert("오류");
						}
		
					})

		})

	})
</script>
<body>
<%@include file="header.jsp" %>
	<br><br>
	<div style="text-align: center;">* 팔린 수량이 1 이 아닌 제품만 표시 됩니다.*
	<br> 기존은  현재날짜 :
	<%=startDate%>
	로부터 일주일 전 기준으로 표시됩니다.
	</div>
	<br>
	<div style="text-align: center;">
	<input type="text" id="datepicker1" name="startDate"> &nbsp; &nbsp;
	<input type="text" id="datepicker2" name="lastDate"> &nbsp;&nbsp;
	<button id="search">검색</button>
	</div>
	<br>
	<br>
	
	
	<table border="1" id="popMenu">
		<thead>
			<tr>
				<th>이름</th>
				<th>갯수</th>
			</tr>
		</thead>
		<tbody id="popmenuList">
			<c:forEach var="popMenu" items="${PopMenu }">
				<c:if test="${popMenu.ea ne 1 }">
					<tr>
						<td><c:out value="${popMenu.value }" /></td>
						<td><c:out value="${popMenu.ea }" /></td>
					</tr>
				</c:if>

			</c:forEach>
		</tbody>

	</table>
	
</body>
</html>