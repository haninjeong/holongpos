<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HOLONG POS 로그인</title>
</head>
<style>


body{


 height: 100%;
 width: 100%;

 
  
}
body::after{

 height: 100%;
 width: 100%;
 content: "";
background-image: url('CSS/title.jpg');
  position: absolute;
  top: 0;
  left: 0;
  z-index: -1;
  opacity: 0.5;
}

.login-wrapper{
    text-align: center;
    margin:auto;
    margin-top:225px;
    width: 400px;
    height: 400px;
    border:solid 3px rgb(45, 133, 233);
    border-radius: 10%;
    background: rgb(224,235,249);
}

}
.login-wrapper >h1 {
      font-size: 24px;
    color: #6A24FE;
    margin-bottom: 20px;
}
input{
idth: 100%;
    height: 48px;
    padding: 0 10px;
    box-sizing: border-box;
    margin-bottom: 16px;
    border-radius: 6px;
    background-color: white;
     width:225px;
    height:30px;
    border: none;


}
input::placeholder {
 color: #D2D2D2;
	
}
#login{
	width: 225px;
    height: 50px;
    background-color: rgb(45, 133, 233);
 	border-radius: 10%;
    font-size: 18px;
    font-weight: bold;
    border-radius: 10%;
    

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

<div class="login-wrapper">
<h1>로그인</h1>
<input type="text" id="id" placeholder="아이디"><br>
<input type="password" id="pw" placeholder="비밀번호"><br>
<br>
<button id="login">Log In</button>
<br>
<br>
<a href="explansation.jsp"><small>HOLONG POS가 처음이세요?</small></a>
</div>

</body>
</html>