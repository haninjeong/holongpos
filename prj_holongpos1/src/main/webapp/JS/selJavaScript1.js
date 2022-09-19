


var total = 0;
var clientno = 1;

/* var script = document.createElement('script');
script.src = 'http://code.jquery.com/jquery-latest.min.js';
script.type = 'text/javascript';
document.getElementsByTagName('head')[0].appendChild(script);   */


numberWithCommas = function(x) {
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}



var pos = {
	addAmount: function(prdName) {
		console.log("조회되는닉네임:" + prdName);
		var rows = $('.orderBoard').find('tr').length;
		console.log(rows);
		var names = new Array;
		for (var i = 0; i < rows; i++) {

			var cells = $('.orderBoard').find('tr').find('td:eq(2)').eq(i).text();

			names.push(cells);

			if (names[i] == prdName) {
				var amount = $('.orderBoard').find('tr').find('td:eq(4)').eq(i).text();
				console.log("갯수:" + amount);
				var price = $('.orderBoard').find('tr').find('td:eq(3)').eq(i).text();
				var plus = parseInt(amount) + 1;
				var prices = parseInt(price) * parseInt(plus);
				$('.orderBoard').find('tr').find('td:eq(4)').eq(i).text(plus);
				$('.orderBoard').find('tr').find('td:eq(5)').eq(i).text(prices);
				total = parseInt(total) + parseInt(price);
				var num2 = numberWithCommas(parseInt(total));
				$(".totalPrice").html(num2);


			}

		}


	},
	onedeleteorder: function() {
		if ($('input:radio[name=index]').is(':checked') == false) {
			alert("삭제할 메뉴를 먼저 선택해주세요!");
		} else {
			var index = $('input:radio[name=index]:checked').index('input:radio[name=index]');
			console.log("index : " + index);
			var price = $('.orderBoard').find('tr').find('td:eq(5)').eq(index).text();
			var num = parseInt($('.orderBoard').find('tr').find('td:eq(1)').eq(index).text());
			total = parseInt(total) - parseInt(price);
			if (total >= 0) {
				var num2 = numberWithCommas(parseInt(total));
				$(".totalPrice").html(num2);

			}

			let no = $('.orderBoard').find('tr').length;
			for (i = 0; i < no; i++) {
				var num1 = $('.orderBoard').find('tr').find('td:eq(1)').eq(i).text();
				console.log("값:" + num1);
				if (num1 > num) {
					var nos = parseInt($('.orderBoard').find('tr').find('td:eq(1)').eq(i).text()) - 1;
					$('.orderBoard').find('tr').find('td:eq(1)').eq(i).text(nos);
				}
			}

			$('.orderBoard').find('tr').eq(index).remove();


		}
	},

	orderout: function() {

		if (confirm("전체취소 처리하시겠습니까?") == true) {
			$('.orderBoard').find('tr').remove();
			$(".totalPrice").html(0);
		} else {
			return;
		}



	},

	changeamount: function() {
		let check = /^[0-9]+$/;
		if ($('input:radio[name=index]').is(':checked') == false) {
			alert("수량변경할 메뉴를 먼저 선택해주세요!");
		} else {

			var index = $('input:radio[name=index]:checked').index('input:radio[name=index]');

			var amount = $('.orderBoard').find('tr').find('td:eq(4)').eq(index).text();
			console.log("갯수:" + amount);
			var changeamount = $(".box1").val();
			console.log("변경할갯수:" + changeamount);
			if (changeamount == "") {
				alert("입력된값이 없습니다.");

			} else if (!check.test(changeamount)) {
				alert("수량은 정수의숫자로만 입력해주세요");
			} else {
				$('.orderBoard').find('tr').find('td:eq(4)').eq(index).text(changeamount);
				var price = $('.orderBoard').find('tr').find('td:eq(3)').eq(index).text();
				console.log("가격:" + price);
				var prices = parseInt(price) * parseInt($('.orderBoard').find('tr').find('td:eq(4)').eq(index).text());
				console.log("가격.5:" + prices);
				$('.orderBoard').find('tr').find('td:eq(5)').eq(index).text(prices);

				total = 0;
				let no = $('.orderBoard').find('tr').length
				for (i = 0; i < no; i++) {
					total = parseInt(total) + parseInt($('.orderBoard').find('tr').find('td:eq(5)').eq(i).text());
					console.log("합계는:" + total);

				}
				var num2 = numberWithCommas(parseInt(total));
				$(".totalPrice").html(num2);

			}

		}

	},

	sale: function() {
		let check = /^[0-9]+$/;
		if ($('input:radio[name=index]').is(':checked') == false) {
			alert("단가변경할 메뉴를 먼저 선택해주세요!");
		} else {
			var index = $('input:radio[name=index]:checked').index('input:radio[name=index]');
			var amountInput = $(".box1").val();
			if (amountInput == "") {
				alert("변경할 금액이 입력되지않았습니다.");
				$(".box1").focus();
			} else if (!check.test(amountInput)) {
				alert("가격은 정수의숫자로만 입력해주세요")

			} else {
				$('.orderBoard').find('tr').find('td:eq(3)').eq(index).text(amountInput);
				$('.orderBoard').find('tr').find('td:eq(6)').eq(index).text("단가변경");
				var price = $('.orderBoard').find('tr').find('td:eq(3)').eq(index).text();
				var amount = $('.orderBoard').find('tr').find('td:eq(4)').eq(index).text();
				var prices = parseInt(price) * parseInt(amount);
				$('.orderBoard').find('tr').find('td:eq(5)').eq(index).text(prices);
				total = 0;

				let no = $('.orderBoard').find('tr').length
				for (i = 0; i < no; i++) {
					console.log("가격들은:" + $('.orderBoard').find('tr').find('td:eq(5)').eq(i).text());
					total = parseInt(total) + parseInt($('.orderBoard').find('tr').find('td:eq(5)').eq(i).text());
					console.log("합계는:" + total);

				}
				var num2 = numberWithCommas(parseInt(total));
				$(".totalPrice").html(num2);

			}

		}


	},
	add: function() {

		if ($('input:radio[name=index]').is(':checked') == false) {
			alert("수량변경할 메뉴를 먼저 선택해주세요!");
		} else {

			var index = $('input:radio[name=index]:checked').index('input:radio[name=index]');
			var amount = $('.orderBoard').find('tr').find('td:eq(4)').eq(index).text();
			var price = $('.orderBoard').find('tr').find('td:eq(3)').eq(index).text();
			var plus = parseInt(amount) + 1;
			$('.orderBoard').find('tr').find('td:eq(4)').eq(index).text(plus);
			var prices = parseInt(price) * parseInt(plus);
			$('.orderBoard').find('tr').find('td:eq(4)').eq(index).text(plus);
			$('.orderBoard').find('tr').find('td:eq(5)').eq(index).text(prices);
			total = parseInt(total) + parseInt(price);
			var num2 = numberWithCommas(parseInt(total));
			$(".totalPrice").html(num2);



		}


	},

	sub: function() {

		if ($('input:radio[name=index]').is(':checked') == false) {
			alert("수량변경할 메뉴를 먼저 선택해주세요!");
		} else {

			var index = $('input:radio[name=index]:checked').index('input:radio[name=index]');
			var amount = $('.orderBoard').find('tr').find('td:eq(4)').eq(index).text();
			var price = $('.orderBoard').find('tr').find('td:eq(3)').eq(index).text();
			var plus = parseInt(amount) - 1;
			if (plus < 0) {
				alert("수량이 0입니다");
			} else {
				$('.orderBoard').find('tr').find('td:eq(4)').eq(index).text(plus);
				var prices = parseInt(price) * parseInt(plus);
				$('.orderBoard').find('tr').find('td:eq(4)').eq(index).text(plus);
				$('.orderBoard').find('tr').find('td:eq(5)').eq(index).text(prices);
				total = parseInt(total) - parseInt(price);
				var num2 = numberWithCommas(parseInt(total));

				$(".totalPrice").html(num2);


			}

		}

	},




	addorder: function(name, price) {
		// 포스기 사용자가 고른 상품 이름
		console.log(name);
		// 상품 가격
		console.log(price);

		let prdName = name;
		
		let product = '';
		var amount = 1;
		
		
		let no = $('.orderBoard').find('tr').length + 1;
		product +='<tr>';
		product += '<td><input type="radio" class="radio" name="index"></td>';
		product += '<td>' + no + '</td>';
		product += '<td class="prdName">' + prdName + '</td>';
		product += '<td class="prdprice">' + price + '</td>';
		product += '<td><span class="amount">' + amount + '</span></td>';
		product += '<td class="price">' + price + '</td><td></td>';
		product +='</tr>';
		if (pos.searchOrderBoard(prdName)) {
			// 있다면 수량을 증가시키는 함수 호출
			pos.addAmount(prdName);

		} else {
			// 없으면 도큐먼트에 노드를 추가한다.
			$('.orderBoard').append(product);

			total = parseInt(total) + parseInt(price) * parseInt(amount);
			var num2 = numberWithCommas(parseInt(total));
			$(".totalPrice").html(num2);

		}
	},
	searchOrderBoard: function(searchTarget) {
		let threshold = false;

		console.log('조회대상 : ' + searchTarget);

		$('.orderBoard').children().each(function(index, tr) {
			let trHTML = tr;
			let prdName = $(trHTML).find('.prdName').text();

			console.log('tr' + $(trHTML).html());
			console.log('prdName : ' + prdName);

			// 조회대상을 찾으면 
			if (prdName == searchTarget) {
				// 리턴값이 될 변수를 변경하고 조회를 종료함.
				threshold = true;
			}
		});

		return threshold;
	},

}
function Time() {

	var clock = document.getElementById("clock");
	var now = new Date();
	var h = now.getHours();

	var m = now.getMinutes();
	var s = now.getSeconds();
	if (h > 12) {
		h = h - 12
		clock.innerHTML = "오후 " + h + "시 " + m + "분 " + s + "초 ";
	} else if (h < 12) {

		clock.innerHTML = "오전 " + h + "시 " + m + "분 " + s + "초 ";
	}
	setTimeout("Time()", 1000);
}
window.onload = function() {
	Time();
};














const events = function() {
	console.log('이벤트 기다리는 중!');

	// 수량 추가 버튼이 누르면 호출되는 이벤트.
	$("#onedeleteorder").click(pos.onedeleteorder);
	$("#orderout").click(pos.orderout);
	$("#changeamount").click(pos.changeamount);
	$("#btn_add").click(pos.add);
	$("#btn_sub").click(pos.sub);
	$("#sale").click(pos.sale);
	$("#cash").click(orderMenu);
	$("#card").click(orderMenu);
	$("#why").click(focus);
	$("#close").click(focusout);
	
};


$(function() {
	//var num=$(e.target).prop("tagName");

	$(".box").on("click", function(e) {
		
		var num1 = $(".box1").val();
		var name = $(e.target).prop("tagName");
		if (name == "TD") {
			$(".box1").val(num1 + $(e.target).text());
		}
	});
	$(".box2").on("click", function(e) {
		var num = $(".box1").val();
		var num1 = $(".box1").val().substring(0, num.length - 1);
		$(".box1").val(num1);

	});
	$(".box4").on("click", function(e) {
		$(".box1").val("");

	});

	$(document).ready(function() {
		// document가 준비되면 호출할 함수들
		events();
		
		
	});

	$(".bread").click(function(e) {

		var typebread = e.target.value;
		

		$.ajax({
			url: "MenuList.do",
			type: "get",
			data: {

				"typebread": typebread,
			},
			dataType: 'json',
			success: function(data) {
			console.log( data);
			$('#menuviewList').empty();
			var sjsonInfo = JSON.stringify(data);
			console.log( sjsonInfo);
			var jsonInfo = JSON.parse(sjsonInfo);
			var result='';
			for( var i in jsonInfo.menuList ){
				
			var prdname =jsonInfo.menuList[i].name;
			var price= jsonInfo.menuList[i].price;
			result+='<input type="button" class="button" onclick="pos.addorder(\''+prdname+ '\','+price+')" value ="'+prdname+'('+price+')">';
				
			}
			$('#menuviewList').append(result);
			
			
	

			},
			error: function(result) {
				alert("오류");
			}

		})

	});
	$('#ordermenu td').attr("style","word-break:break-all");
	
	
})

function orderMenu (e){
	
	
	
		var menus_arr=new Array();
		var menusprice_arr=new Array();
		var menus_no_arr =new Array();
		var menus_totalprice_arr =new Array();
		var totalno=0;
		
		var payment = e.target.value;
	
		let no = $('.orderBoard').find('tr').length ;
		for (var i=0;i<no;i++){
			menus_arr.push($('.orderBoard').find('tr').find('td:eq(2)').eq(i).text());
			menusprice_arr.push($('.orderBoard').find('tr').find('td:eq(3)').eq(i).text());
			 menus_no_arr.push($('.orderBoard').find('tr').find('td:eq(4)').eq(i).text()); 
			 menus_totalprice_arr.push($('.orderBoard').find('tr').find('td:eq(5)').eq(i).text())
			totalno =parseInt(totalno)+parseInt($('.orderBoard').find('tr').find('td:eq(4)').eq(i).text());
			
		}
		
		console.log("메뉴이름:"+menus_arr);
		console.log("메뉴가격:"+menusprice_arr);
		console.log("메뉴갯수:"+menus_no_arr);
		console.log("메뉴총각각가격:"+menus_totalprice_arr);
		console.log("메뉴총갯수:"+totalno);
		console.log('결제수단:'+payment);
		
		
					$.ajax({

						url : "OrderList.do",
						type : 'post',
						dataType : 'json',
						traditional: true,

						data : {
							"menus" : menus_arr,
							"menusprice" : menusprice_arr,
							"menusno" : menus_no_arr,
							"menustotalprice":menus_totalprice_arr,
							"totalno" : totalno,
							"totalprice":total,
							"payment" :payment,
							
							

						},
						
						success : function(result) {

							if (result == 1) {
								alert("결제완료되었습니다.");
								$('.orderBoard').find('tr').remove();
								$(".totalPrice").html(0);
								total=0;
								

							} else {
								alert("결제오류!")

							}

						},
						error : function(data) {
							alert("오류");
						}
					})
	
	
	
}

function focus(){
	
	var why = document.getElementById('why');
	var section = document.getElementById('section');

	
	var px = "12px";
	why.style.right = px;
	section.style.right = px;


	
	
}

function focusout(){
	
	
	var px = "";
	why.style.right = px;
	section.style.right = px;


	
	
}








