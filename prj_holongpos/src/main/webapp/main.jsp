<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

String id = (String) session.getAttribute("id");
if(id==null){
	out.print("<script>alert('로그인후 이용가능합니다.');location.href = 'login.jsp';</script>");
	
}

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>

  a {
  	  text-decoration: none;
  	  font-size:50px;
  	  margin: 0 auto;
  	  line-height: 300px;
  	  color: #b72f42;
  }


 

  .container {
 	display: grid;
	grid-template-columns: repeat(3, 430px);
	grid-template-rows: repeat(2, 430px);
	column-gap: 30px;
	row-gap: 30px;

	text-align: center;
	
}
.item{


 width: 350px;
  height: 350px;
  text-align: center;
 color: #565656; 
 background: #ffeaea; 
 box-shadow: 0px 0px 0px 10px #ffeaea;
  border: dashed 2px #ffc3c3; 
  border-radius: 8px;


}  
body{
	background-color:  #FFF8E8; 
	display: flex;
  justify-content: center;
  flex-shrink: 0;
  
 	
  

}  
  
  
  
  
  
  
</style>
<body>

<div class="container">
<div class="item"><a href="index.jsp"> 판매</a></div>
<div class="item"><a href="closeShop.jsp">영업마감</a></div>
<div class="item"><a href="menuManageMent.jsp">메뉴관리</a></div>
<div class="item"><a href="viewReceiptList.jsp">영수증관리</a></div>
<div class="item"><a href="salesInquiry.jsp">매출조회</a></div>
<div class="item"><a href="popmenu.jsp">인기메뉴조회</a></div>
</div>
</body>
</html>