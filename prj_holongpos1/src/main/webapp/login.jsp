<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
* { box-sizing: border-box; }
@import url('https://fonts.googleapis.com/css?family=Rubik:400,500&display=swap');


body {
  font-family: 'Rubik', sans-serif;
}

.container {
  display: flex;
  height: 100vh;
}

.left {
  overflow: hidden;
  display: flex;
  flex-wrap: wrap;
  flex-direction: column;
  justify-content: center;
  animation-name: left;
  animation-duration: 1s;
  animation-fill-mode: both;
  animation-delay: 1s;
}

.right {
  flex: 1;
  background-color: black;
  transition: 1s;
  background-image: url('CSS/main.png');
  background-size: cover;
  background-repeat: no-repeat;
  background-position: center;
  
}



.header > h2 {
  margin: 0;
  color: #4f46a5;
}

.header > h4 {
  margin-top: 10px;
  font-weight: normal;
  font-size: 15px;
  color: rgba(0,0,0,.4);
}

.form {
  max-width: 80%;
  display: flex;
  flex-direction: column;
}

.form > p {
  text-align: right;
}

.form > p > a {
  color: #000;
  font-size: 14px;
}

.form-field {
  height: 46px;
  padding: 0 16px;
  border: 2px solid #ddd;
  border-radius: 4px;
  font-family: 'Rubik', sans-serif;
  outline: 0;
  transition: .2s;
  margin-top: 20px;
}

.form-field:focus {
  border-color: #0f7ef1;
}

.form > button {
  padding: 12px 10px;
  border: 0;
  background: linear-gradient(to right, #de48b5 0%,#0097ff 100%); 
  border-radius: 3px;
  margin-top: 10px;
  color: #fff;
  letter-spacing: 1px;
  font-family: 'Rubik', sans-serif;
}

.animation {
  animation-name: move;
  animation-duration: .4s;
  animation-fill-mode: both;
  animation-delay: 2s;
}

.a1 {
  animation-delay: 2s;
}

.a2 {
  animation-delay: 2.1s;
}

.a3 {
  animation-delay: 2.2s;
}

.a4 {
  animation-delay: 2.3s;
}

.a5 {
  animation-delay: 2.4s;
}

.a6 {
  animation-delay: 2.5s;
}

@keyframes move {
  0% {
    opacity: 0;
    visibility: hidden;
    transform: translateY(-40px);
  }

  100% {
    opacity: 1;
    visibility: visible;
    transform: translateY(0);
  }
}

@keyframes left {
  0% {
    opacity: 0;
    width: 0;
  }

  100% {
    opacity: 1;
    padding: 20px 40px;
    width: 440px;
  }
}

</style>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript">

$(function(){
	
	
	$("#login").click(function(){
		
		
		var id = $("#id").val();
		var pw = $("#pw").val();
		
		if(id == ""){
			alert("아이디를 입력해주세요");
			$("#id").focse();
			
		}
		if(pw == ""){
			
			alert("비밀번호를 입력해주세요");
			$("#pw").focus();
			
		}
		
		if(id != "" && pw != "" ){
			
			
			$.ajax({

				url: "LoginCheck.do",
				type: 'post',
				dataType: 'text',

				data: {
					"id": id,
					"pw": pw,
				},

				success: function(result) {

					if (result == 2) {
						window.location.href = "main.jsp";

					} else if (result == 1) {
						window.location.href = "openShopMoney.jsp";

					} else if (result == 0){
						alert("로그인에 실패했습니다.")
					}

				},
				error: function(data) {
					alert("오류");
				}
			});
			
			
			
			
			
		}
		
	
	
	
	
	
	
	})
	







})


</script>
<body>
<div class="container">
  <div class="left">
    <div class="header">
      <h2 class="animation a1">HOLONG POS</h2>
      <h4 class="animation a2">아이디와 비밀번호를 입력해주세요</h4>
    </div>
    <div class="form">
      <input type="text" class="form-field animation a3" id="id" placeholder="아이디">
      <input type="password"  id="pw" class="form-field animation a4" placeholder="비밀번호">
      <p class="animation a5"><a href="explansation.jsp">HOLONG POS가 처음이세요?</a></p>
      <button class="animation a6" id="login">LOGIN</button>
    </div>
  </div>
  <div class="right"></div>
</div>
</body>
</html>