/**
 * 
 */
function setPagerListener(url,formSelector){
$('#pager #firstPage').click(function(){
	$('#pageNumber').val(0);
	
	$.ajax({
		async : false,
		cache : false,
		type : 'GET',
		data : $(formSelector).serialize(),		 
		url : url,// 请求的action路径
		error : function() {// 请求失败处理函数
			alert('失败');
		},
		success : function(data) { // 请求成功后处理函数。
			$("#content-wrapper").html(data);// 刷新content页面
		
		}
	});
});
$('#pager #endPage').click(function(){
	$('#pageNumber').val();
	
	$.ajax({
		async : false,
		cache : false,
		type : 'GET',
		data : $(formSelector).serialize(),		 
		url : url,// 请求的action路径
		error : function() {// 请求失败处理函数
			alert('失败');
		},
		success : function(data) { // 请求成功后处理函数。
			$("#content-wrapper").html(data);// 刷新content页面
		
		}
	});
});
$('#pager #nextPage').click(function(){
	$('#pageNumber').val(${pageNumber+1});
	
	$.ajax({
		async : false,
		cache : false,
		type : 'GET',
		data : $(formSelector).serialize(),		 
		url : url,// 请求的action路径
		error : function() {// 请求失败处理函数
			alert('失败');
		},
		success : function(data) { // 请求成功后处理函数。
			$("#content-wrapper").html(data);// 刷新content页面
		
		}
	});
});
$('#pager #previousPage').click(function(){
	$('#pageNumber').val(${pageNumber-1});	
	$.ajax({
		async : false,
		cache : false,
		type : 'GET',
		data : $(formSelector).serialize(),		 
		url : url,// 请求的action路径
		error : function() {// 请求失败处理函数
			alert('失败');
		},
		success : function(data) { // 请求成功后处理函数。
			$("#content-wrapper").html(data);// 刷新content页面
		
		}
	});
});
}