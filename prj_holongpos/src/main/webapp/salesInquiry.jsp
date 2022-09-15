<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dto.OrderMenuDTO"%>
<%@page import="java.util.List"%>
<%@page import="dbcon.OrderMenuDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String id = (String) session.getAttribute("id");
if (id == null) {
	out.print("<script>alert('로그인후 이용가능합니다.');location.href = 'login.jsp';</script>");

}
Date date = new Date();
String pattrtn = "yyyyMMdd";
SimpleDateFormat sdf = new SimpleDateFormat(pattrtn);

int startDate = Integer.parseInt(sdf.format(date));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매출조회</title>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

</head>
<style>
.chart {
	top: 500px;
}
</style>
<script type="text/javascript">
		$(function() {

			$(document).ready(function() {

				getGraph();

			})
			$("#search").click(getGraph);

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
								monthNamesShort : [ '1월', '2월', '3월', '4월',
										'5월', '6월', '7월', '8월', '9월', '10월',
										'11월', '12월' ] //달력의 월 부분 텍스트
								,
								monthNames : [ '1월', '2월', '3월', '4월', '5월',
										'6월', '7월', '8월', '9월', '10월', '11월',
										'12월' ] //달력의 월 부분 Tooltip
								,
								dayNamesMin : [ '일', '월', '화', '수', '목', '금',
										'토' ] //달력의 요일 텍스트
								,
								dayNames : [ '일요일', '월요일', '화요일', '수요일', '목요일',
										'금요일', '토요일' ] //달력의 요일 Tooltip
								,
								minDate : "-5Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
								,
								maxDate : "+5y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)  
							});
			$('#datepicker1,#datepicker2').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)            

			function getGraph() {

				let total = [];
				let day = [];

				$.ajax({
					url : "SalPriceList.do",
					type : "get",
					data : {

						"startDate" : $("#datepicker1").val(),
						"lastDate" : $("#datepicker2").val(),

					},
					dataType : "json",
					success : function(data) {
						console.log(data);
						var sjsonInfo = JSON.stringify(data);
						var jsonInfo = JSON.parse(sjsonInfo);
						for ( var i in data.totalList) {

							total.push(jsonInfo.totalList[i].totalprice);
							day.push(jsonInfo.totalList[i].pay_date);

						}

						console.log(total);
						console.log(day);

					}

				});

				var context = document.getElementById('myChart').getContext(
						'2d');
				if(window.chartObj != undefined){
					window.chartObj.destroy();
				}
				
				 window.chartObj = new Chart(context, {
					type : 'bar', // 차트의 형태
					data : { // 차트에 들어갈 데이터
						labels : day
						//x 축
						,
						datasets : [
								{ //데이터
									label : '매출', //차트 제목
									fill : false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
									data : total,
									//x축 label에 대응되는 데이터 값

									backgroundColor : [
									//색상
									'rgba(255, 99, 132, 0.2)',
											'rgba(54, 162, 235, 0.2)',
											'rgba(255, 206, 86, 0.2)',
											'rgba(75, 192, 192, 0.2)',
											'rgba(153, 102, 255, 0.2)',
											'rgba(255, 159, 64, 0.2)' ],
									borderColor : [
									//경계선 색상
									'rgba(255, 99, 132, 1)',
											'rgba(54, 162, 235, 1)',
											'rgba(255, 206, 86, 1)',
											'rgba(75, 192, 192, 1)',
											'rgba(153, 102, 255, 1)',
											'rgba(255, 159, 64, 1)' ],
									borderWidth : 1
									

								//경계선 굵기
								},

						]
					},
					options : {
						
					    
			            maintainAspectRatio: false,
						
		
						scales : {
							yAxes : [ {
								ticks : {
									beginAtZero : true
								}
							} ]
						}
					}
				});

			}

		})
	</script>
<body>
	<%@include file="header.jsp"%>
	<br>
	<br>
	 조회기준은 현재날짜 :
	<%=startDate%>
	로부터 일주일 전 기준으로 표시됩니다.
	<br>
	<br>
	<input type="text" id="datepicker1" name="startDate"> &nbsp;
	&nbsp;
	<input type="text" id="datepicker2" name="lastDate">
	&nbsp;&nbsp;
	<button id="search">검색</button>
	<br>
	<br>
	<canvas id="myChart"></canvas>


	
</body>
</html>