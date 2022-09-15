$(function() {
	
	
	$("li").click(function(index) {
		var pageNum = $("li").index(this) + 1;


		$.ajax({

			url: "PageMenuList.do",
			type: 'get',
			dataType: 'json',


			data: {
				"pageNum": pageNum,

			},

			success: function(data) {
				console.log(data);
				$('#menulist').empty();

				var sjsonInfo = JSON.stringify(data);
				var jsonInfo = JSON.parse(sjsonInfo);
				var result = '';

				for (var i in jsonInfo.menuList) {
					var menunum = jsonInfo.menuList[i].menunum;
					var typebread = jsonInfo.menuList[i].typebread;
					var name = jsonInfo.menuList[i].name;
					var price = jsonInfo.menuList[i].price;







					let comma = price.toLocaleString('ko-KR');

					result += '<tr><td><input type="radio" class="index" name="index"></td>';
					result += '<td>' + menunum + '</td>'
					result += '<td>' + typebread + '</td>';
					result += '<td>' + name + '</td>';
					result += '<td>' + comma + '</td></tr>';




				}
				$('#menulist').append(result);




			},
			error: function(data) {
				alert("오류");
			}
		})


	});

	$("#menuPlus").click(function() {
		const modal = document.getElementById("modal");
		modal.style.display = "flex";


	});

	$(".close-area").click(function() {
		const modal = document.getElementById("modal");

		modal.style.display = "none"

	});

	$("#insertmenu").click(function() {

		var breadList = $("#breadList option:selected").val();
		var name = $("#name").val();
		var price = $("#price").val();

		var typebread = $("#breadList").val();

		if (breadList == "") {
			alert("등록할 메뉴를 구분을 선택해주세요!");
		} else if (name == "") {
			alert("등록할 메뉴를 이름을 입력해주세요!");
			$("#name").focus();
		} else if (price == "") {
			alert("등록할 메뉴의 가격을 입력해주세요!");
			$("#price").focus();

		} else {



			$.ajax({

				url: "MenuPlus.do",
				type: 'post',
				dataType: 'text',

				data: {
					"typebread": typebread,
					"name": name,
					"price": price,



				},

				success: function(result) {

					if (result == 1) {
						alert("메뉴가 등록되었습니다.");
						modal.style.display = "none"





					} else if (result == 0) {
						alert("서버오류로 인해 되지않았어요")

					}

				},
				error: function(data) {
					alert("오류");
				}
			})



		}



	});

	$("#menuDelect").click(function() {

		if ($('input:radio[name=index]').is(':checked') == false) {
			alert("삭제 할 메뉴를 선택해주세요!");
		} else {
			var index = $('input:radio[name=index]:checked').index('input:radio[name=index]');
			console.log("인덱스번호" + index);
		}

		if (confirm("정말 삭제 하시겠습니다??") == true) {

			var no = $("#allMenuList").find('tr').find('td:eq(1)').eq(index).text();
			console.log("선택된 메뉴번호" + no);

			$.ajax({

				url: "MenuDelect.do",
				type: 'post',
				dataType: 'text',

				data: {
					"no": no,
				},

				success: function(result) {

					if (result == 1) {
						alert("메뉴가 삭제되었습니다.");
						$("#allMenuList").load(location.href + " #allMenuList");





					} else if (result == 0) {
						alert("서버오류로 인해 되지않았어요")

					}

				},
				error: function(data) {
					alert("오류");
				}
			});




		} else {

			return;
		}




	});

	$("#menuUpdate").click(function() {
		const modalupdate = document.getElementById("modalupdate");
		if ($('input:radio[name=index]').is(':checked') == false) {
			alert("수정할메뉴를선택하세요!");
		} else {
			var index = $('input:radio[name=index]:checked').index('input:radio[name=index]');
			console.log("인덱스번호" + index);

			var no = $('#allMenuList').find('tr').find('td:eq(1)').eq(index).text();
			var name = $('#allMenuList').find('tr').find('td:eq(3)').eq(index).text();
			var price = $('#allMenuList').find('tr').find('td:eq(4)').eq(index).text();

			let $price = price.replace(/,/g, "");

			let content = '';
			content += '메뉴 번호 :<div id="menunum">' + no + '</div>';
			content += '메뉴 이름 :<input type="text" id="titlename" value="' + name + '"><br>';
			content += '메뉴 가격 :<input type="text" id="reprice" value="' + $price + '"><br><br>';
			content += '<input type="button" class="setupdate" value="수정하기">';

			$(".content1").append(content);

			modalupdate.style.display = "flex";

		}

	});
	

	$(".close-area1").on("click",function() {
		const modalupdate = document.getElementById("modalupdate");
		$(".content1").empty();
		modalupdate.style.display = "none"

	});
	$(document).on("click",".setupdate",function(){
		var no = $("#menunum").text();
		var titlename = $("#titlename").val();
		var reprice = $("#reprice").val();
		console.log("번호" + menunum);
		console.log("이름" + titlename);
		console.log("가격" + reprice);
		
		let check = /^[0-9]+$/;
		
		
		if(titlename == "" && reprice == ""){
			alert("공백인값이 잇으면 수정이 불가능합니다.")
			
		}else if(!check.test(reprice)){
			
			alert("가격은 숫자로만 입력해주세요.");
		}else{
			
				$.ajax({

				url: "MenuDelect.do",
				type: 'post',
				dataType: 'text',

				data: {
					"titlename": titlename,
					"reprice": reprice,
					"no": no,



				},

				success: function(result) {

					if (result == 1) {
						alert("수정되었습니다.");
						modalupdate.style.display = "none";
						$("#allMenuList").load(location.href + " #allMenuList");

					} else if (result == 0) {
						alert("서버오류로 인해 되지않았어요")

					}

				},
				error: function(data) {
					alert("오류");
				}
			})

			
		}
		
		
		
		
		
		
		
		

		
	});









})