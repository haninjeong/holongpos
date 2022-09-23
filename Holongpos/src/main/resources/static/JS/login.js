window.onload = function(){
	var login = document.getElementById("login");
	login.addEventListener("click",LoginCheck);
	
}







function LoginCheck (){

	var id = document.getElementById("id").value;
	var pw = document.getElementById("pw").value;



		var xhr = new XMLHttpRequest();

        //요청을 보낼 방식, 주소, 비동기여부 설정
        xhr.open('POST', '/ajax/loginCheck', true);

        //HTTP 요청 헤더 설정
        xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');

	
        //요청 전송
       
        xhr.send("id="+id+"&&pw="+pw);
       

        //통신후 작업
        xhr.onload = () => {
            //통신 성공
            if (xhr.status == 200) {
                console.log(xhr.response);
                console.log("통신 성공");
                if(xhr.response == 1){
                    alert("로그인되었어요");
						window.location.href = "main";
                    }
            } else {
                //통신 실패
                console.log("통신 실패");
            }




		}
	

	
}

