function openlist(num) {
	let recenum = num;

	var popUrl = 'detailReceipt.jsp?num=' + recenum;
	var popOption = 'toolbar=no,width=500,height=1000';
	window.open('detailReceipt.jsp?num=' + recenum, "_blank", popOption);


};


$(function() {
	const modal = document.getElementById("modal");
		$("#return").click(function() {
	
			if ($('input:radio[name=index]').is(':checked') == false) {
				alert("반품할 메뉴를 먼저 선택해주세요!");
			} else {
				var index = $('input:radio[name=index]:checked').index('input:radio[name=index]');
				console.log("인덱스번호"  + index);
				var deal = $('#receiptList').find('tr').find('td:eq(6)').eq(index).text();
				if (deal ==  "취소거래건")  {
					alert("이미 취소된 거래건입니다.");
	
				} else {
					var num = $('#receiptList').find('tr').find('td:eq(1)').eq(index).text();
					var paymentdate = $('#receiptList').find('tr').find('td:eq(2)').eq(index).text();
					var price = $('#receiptList').find('tr').find('td:eq(3)').eq(index).text();
					var payment = $('#receiptList').find('tr').find('td:eq(4)').eq(index).text();
					var paymentime = $('#receiptList').find('tr').find('td:eq(5)').eq(index).text();
	
					console.log("영수증 번호" + num);
					console.log("결제날짜" + paymentdate);
					console.log("결제수단" + payment);
					console.log("결제시간" +  paymentime);
					console.log("거래정보"  + deal);
	
					let content = '';
					content += '<p>*다 음 과 같 은 주 문 건 이 취 소 됩 니 다*</p>';
					content += '<p>영 수 증 번호 :' + num  + '</p>';
					content += '<p>결 제 날 짜 :'  + paymentdate + '</p>';
					content += '<p>결 제 금 액 :' +  price  + '</p>';
					content += '<p>결 제 수 단 :' +   payment + '</p>';
					content += '<p>결 제 시 간 :' + paymentime + '</p>';
					content += '<button class="returnProgress">반품진행</button>';
					$(".content").append(content);
					modal.style.display = "flex"
	
	
				}
	
	
			}
	
	
	
	
		})
		$(".close-area").click(function() {
	
			modal.style.display = "none"
			$(".content").empty();
		})
		$(document).on("click", ".returnProgress" ,function()  {
	
	
			var index = $('input:radio[name=index]:checked').index('input:radio[name=index]');
			var receipt_no = $('#receiptList').find('tr').find('td:eq(1)').eq(index).text();
	
	
			$.ajax({
	
				url: "ReturnProgress.do",
				type: 'post',
				dataType : 'json',
				traditional: true,
	
				data :{
					"receipt_no": receipt_no,
	
	
	
			},
	
				success: function(result) {
	
					if (result == 1) {
						alert("반품처리되었습니다.");
						modal.style.display = "none"
						$(".content").empty();
						$("#receiptList").load(location.href + " #receiptList");
	
	
	
					} else {
						alert("반품오류!")
	
					}
	
				},
				error: function(data) {
					alert("오류");
				}
			})
	
	
	
	
	
	})

	$("li").click(function(index) {
		var pageNum = $("li").index(this) + 1;
	
	
		$.ajax({
	
			url: "PageReceiptList",
			type: 'get',
			dataType: 'json',
	
	
			data: {
				"pageNum": pageNum,
	
			},
	
			success: function(data) {
				
				$('#list').empty();
				
				var sjsonInfo = JSON.stringify(data);
				var jsonInfo = JSON.parse(sjsonInfo);
				var information = '';
				var result = '';
				for (var i in data.receiptList) {
					var receipt_no = jsonInfo.receiptList[i].receipt_no;
					var pay_date = jsonInfo.receiptList[i].pay_date;
					var pay_date2 = jsonInfo.receiptList[i].pay_date2;
					var payment = jsonInfo.receiptList[i].payment;
					var totalprice = jsonInfo.receiptList[i].totalprice;
	
	
					if (totalprice > 0) {
						information = '정상거래건';
					} else if (totalprice < 0) {
						information  = '취소거래건';
	
					}
	
	
	
					let comma  = totalprice.toLocaleString('ko-KR');
	
					result  += '<tr><td><input type="radio" class="index" name="index"></td>';
					result += '<td class="receipt_no" onclick="openlist(' + receipt_no + ');" >'
					result += receipt_no + '</td>';
					result += '<td>' + pay_date + '</td>';
					result += '<td>' + comma + '</td>';
					result += '<td>' + payment + '</td>';
					result += '<td>' + pay_date2 + '</td>';
					result += '<td class="mation" vlaue="1">' + information + '</td></tr>';
	
	
	
				}
				$('#list').append(result);
				let no = $('#receiptList').find('tr').length;
				let dealoff = "취소거래건";
				for (var y = 0; y < no; y++) {
					if ($('#receiptList').find('tr').find('td:eq(6)').eq(y).text() == dealoff) {
						$(".mation:contains('취소거래건')").css("color", "red");
	
					}
	
				}
	
	
			},
			error: function(data) {
				alert("오류");
			}
		})
	
	
	});
	
	$("#search").click(function(){
		var selected = $("#select option:selected").val();
		var select=$("#select").val();
		var searchtext=$("#searchtext").val();
		let check = /^[0-9]+$/;
		var cash="현금";
		var card="카드";
		if(selected==""||searchtext=="" ){
			alert("검색할 옵션또는 검색어를 입력해주세요");
			$("#searchtext").focus();
		}else if(selected=='영수증번호'&&searchtext=="카드"){
			alert("영수증번호를 입력해주세요");	
		}else if(selected=='영수증번호'&&searchtext=="현금"){
			alert("영수증번호를 입력해주세요");
		}else if(selected=='결제수단'&&check.test(searchtext)){
			alert("결제수단은 현금 또는 카드로 입력해주세요!");
		}else if(selected=='영수증번호'&&!check.test(searchtext)){
			alert("영수증번호는 숫자로만 입력해주세요!");	
		}else {
			
			
			 $.ajax({
	
				url: "SearchOrserList",
				type: 'get',
				dataType : 'json',
				traditional: true,
	
				data :{
					"select": select,
					"searchtext":searchtext,
	
	
	
			},
	
				success: function(data) {
	
					$('#list').empty();
					$('#noresult').empty();
					
					if(data !=0){
						var sjsonInfo = JSON.stringify(data);
						var jsonInfo = JSON.parse(sjsonInfo);
						var information = '';
						var result = '';
						for (var i in data.receiptList) {
							var receipt_no = jsonInfo.receiptList[i].receipt_no;
							var pay_date = jsonInfo.receiptList[i].pay_date;
							var pay_date2 = jsonInfo.receiptList[i].pay_date2;
							var payment = jsonInfo.receiptList[i].payment;
							var totalprice = jsonInfo.receiptList[i].totalprice;
			
			
							if (totalprice > 0) {
								information = '정상거래건';
							} else if (totalprice < 0) {
								information  = '취소거래건';
			
							}
			
			
			
							let comma  = totalprice.toLocaleString('ko-KR');
			
							result += '<tr><td><input type="radio" class="index" name="index"></td>';
							result += '<td class="receipt_no" onclick="openlist(' + receipt_no + ');" >'
							result += receipt_no + '</td>';
							result += '<td>' + pay_date + '</td>';
							result += '<td>' + comma + '</td>';
							result += '<td>' + payment + '</td>';
							result += '<td>' + pay_date2 + '</td>';
							result += '<td class="mation" vlaue="1">' + information + '</td></tr>';
			
			
			
						}
						$('#list').append(result);
						$('#pageul').empty();
						let no = $('#receiptList').find('tr').length;
						let dealoff = "취소거래건";
						for (var y = 0; y < no; y++) {
							if ($('#receiptList').find('tr').find('td:eq(6)').eq(y).text() == dealoff) {
								$(".mation:contains('취소거래건')").css("color", "red");
			
							}
			
						}
					
					
				}else if(data==0){
					$('#list').empty();
					$('#noresult').html("<h2>결제정보가 없습니다.</h2>");
					$('#pageul').empty();
					
				}
			
	
				},
				error: function(data) {
					$('#list').empty();
					$('#noresult').html("<h2>결제정보가 없습니다.</h2>");
					$('#pageul').empty();
				}
			})
			
			
		}
		
	})
	
	

});



