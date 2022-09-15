<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String id = (String) session.getAttribute("id");
if(id==null){
	out.print("<script>alert('로그인후 이용가능합니다.');location.href = 'login.jsp';</script>");
	
}
Date date = new Date();
String pattrtn = "yyyy년 MM월 dd일 [E]";
SimpleDateFormat sdf = new SimpleDateFormat(pattrtn);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개점</title>
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

input{
  display: block;
  width: 300px;
  font-size: 14pt;
  line-height: 14pt * 2;
  font-family: 'Fjalla One';
  margin-bottom: 14pt * 2;
  border: none;
  border-bottom: 3px solid rgba(0,0,0,1);
  margin:0 auto;
  min-width: 250px;
  padding-left: 5px;
  outline: none;
  color: rgba(0,0,0,1);
  text-align: center;
  left: 350px;
}

input:focus{
  border-bottom: 3px solid #ffa580 ;
}

#openshop{


display: block;
  margin: 0 auto;
  line-height: $font-size * 2;
  padding: 20px 20px;
  background: #ffa580;
  letter-spacing: 2px;
  transition: .2s all ease-in-out;
  outline: none;
  border: 1px solid rgba(0,0,0,1);
  border-radius: 10px;
  }
 #openshop:hover{
      background: rgba(0,0,0,1);
    color: white;
    border: 1px solid rgba(0,0,0,1);
    }


</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	$(function() {

		$("#openshop").click(function() {

			var openmoney = uncomma($("#openmoney").val());

			if (openmoney == "") {
				alert("개점금액을 입력해주세요!");
				$("#openmoney").focus();

			} else {

				$.ajax({

					url : "ShopCalculate.do",
					type : 'post',
					dataType : 'text',

					data : {
						"openmoney" : openmoney,

					},

					success : function(result) {

						if (result == 1) {
							alert("정상적으로 등록되었습니다.");
							window.location.href = "main.jsp"

						} else if (result == 0) {
							alert("서버오류로 인해 되지않았어요")

						}

					},
					error : function(data) {
						alert("오류");
					}
				})

			}

		})

	})
	function inputNumberFormat(obj) {
		obj.value = comma(uncomma(obj.value));
	}

	function comma(str) {
		str = String(str);
		return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	}

	function uncomma(str) {
		str = String(str);
		return str.replace(/[^\d]+/g, '');
	}
</script>
<body>
<h1>HOLONGPOS</h1>
	<p>
		개점 영업일자 :<%=sdf.format(date)%>
	</p>
	<p>
		개점 준비금  <br><input type="text" id="openmoney"
			onkeyup="inputNumberFormat(this)" placeholder="금액을 입력해주세요"><br>


		<button id="openshop">개점처리</button>
</body>
</html>