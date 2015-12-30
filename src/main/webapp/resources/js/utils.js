/**
 * 
 */
/* icheck 初始化 详情：https://github.com/fronteed/icheck */
function iCheckInit() {
	$('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
		checkboxClass : 'icheckbox_minimal-blue',
		radioClass : 'iradio_minimal-blue'
	});
	// Red color scheme for iCheck
	$('input[type="checkbox"].minimal-red, input[type="radio"].minimal-red')
			.iCheck({
				checkboxClass : 'icheckbox_minimal-red',
				radioClass : 'iradio_minimal-red'
			});
	// Flat red color scheme for iCheck
	$('input[type="checkbox"].flat-red, input[type="radio"].flat-red').iCheck({
		checkboxClass : 'icheckbox_flat-green',
		radioClass : 'iradio_flat-green'
	});
}


/* 遍历checkbox，进行删除 */
function deleteItems(checkboxSelector, action) {
	/* 遍历所有的checkbox，判断checkbox是否被选中 */
	var deleteIds = [];
	var i = 0;
	$(checkboxSelector).each(function(index, item) {
		var isChecked = item.checked;
		if (isChecked == true) {
			deleteIds[i++] = item.value;
		}
	});
	$.ajax({
		async : false,
		cache : false,
		type : 'POST',
		data : $.param({
			deleteIds : deleteIds
		}),
		// contentType : 'application/json', //发送信息至服务器时内容编码类型
		// dataType : "json",//返回的数据类型
		url : action,// 请求的action路径
		error : function() {// 请求失败处理函数
			alert('失败');
		},
		success : function(data) { // 请求成功后处理函数。
			alert("成功");
			$("#content-wrapper").html(data);// 刷新content页面
		}
	});
}

/* 遍历checkbox，进行删除 */
function deleteItemsById(deleteIds, action) {	
	$.ajax({
		async : false,
		cache : false,
		type : 'POST',
		data : $.param({
			deleteIds : deleteIds
		}),
		url : action,// 请求的action路径
		error : function() {// 请求失败处理函数
			alert('失败');
		},
		success : function(data) { // 请求成功后处理函数。
			alert("成功");
			$("#content-wrapper").html(data);// 刷新content页面
		}
	});
}


/* 遍历checkbox，进行删除 */
function deleteItemsUseModal(checkboxSelector, action) {
	/* 遍历所有的checkbox，判断checkbox是否被选中 */
	var deleteIds = [];
	var i = 0;
	$(checkboxSelector).each(function(index, item) {
		var isChecked = item.checked;
		if (isChecked == true) {
			deleteIds[i++] = item.value;
		}
	});
	$.ajax({
		async : false,
		cache : false,
		type : 'POST',
		data : $.param({
			deleteIds : deleteIds
		}),
		// contentType : 'application/json', //发送信息至服务器时内容编码类型
		// dataType : "json",//返回的数据类型
		url : action,// 请求的action路径
		error : function() {// 请求失败处理函数
			alert('失败');
		},
		success : function(data) { // 请求成功后处理函数。
			alert("成功");
			$("#deleteConfirmModal").modal('hide');
			$('#deleteConfirmModal').on('hidden.bs.modal',function(event){//当modal框完全隐藏后再刷新页面content，要不然有bug
				$("#content-wrapper").html(data);//刷新content页面
			});
		}
	});
}






