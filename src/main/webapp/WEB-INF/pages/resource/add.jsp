<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal"
		aria-label="Close">
		<span aria-hidden="true">&times;</span>
	</button>
	<h4 class="modal-title" id="exampleModalLabel">新增资源</h4>
</div>
<form id="addForm" action="resource/add" method="post">
	<div class="modal-body">

		<label for="parentName" class="control-label">上级资源:</label> <font
			color="red"><span id="parentName">${parentName}请返回,选定上级资源再进行操作</span></font>


		<div class="form-group">
			<label for="name" class="control-label"><font color="red">*</font>资源名:</label>
			<input type="text" class="form-control " id="name"
				name="name">
		</div>
		<div class="form-group">
			<label for="permission" class="control-label"><font
				color="red">*</font>权限字符串:</label> <input type="text"
				class="form-control " id="permission" name="permission">
		</div>
		<div class="form-group">
			<label for="type" class="control-label"><font color="red">*</font>资源类型:</label>			
			<input name="type" type="checkbox" value="menu">
			<!-- <select  name="type" id="type"
				class="form-control select2  js-example-basic-single" tabindex="-1"
				style="width: 100%">
				<option value="menu">menu</option>
				<option value="button" selected="selected">button</option>
			</select> -->
		</div>
		<div class="form-group">
			<label for="url" class="control-label">菜单路径URL:</label> <input
				type="text" class="form-control " id="url" name="url">
		</div>
		<div class="form-group">
			<label for="priority" class="control-label"><font color="red">*</font>排序优先级:</label>
			<input type="text" class="form-control"  id="priority" placeholder="优先级数字越小，排在越上面"
				name="priority">
		</div>


		<input type="hidden" class="form-control" id="parentId"
			name="parentId" value="${parentId}">


	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		<button type="submit" class="btn btn-primary" id="addSubmitBtn">提交</button>
	</div>
</form>
<script>
/*modal框事件监听 详情：http://v3.bootcss.com/javascript/#modals-events */
$('#addModal').on('shown.bs.modal', function(event) {						
			$("#name").focus();
			 $("#addForm").validate({
				 priority:{
					 min:1,
					 required:true,
					 digits:false
				 },
				 submitHandler : function(form){
			           	$.ajax({
							async : false,
							cache : false,
							type : 'POST',
							data :  $("#addForm").serialize(),
						   // contentType : 'application/json',    //发送信息至服务器时内容编码类型
							//dataType : "json",
							url : "resource/add",//请求的action路径  
							error : function() {//请求失败处理函数  
								alert('失败');
							},
							success : function(data) { //请求成功后处理函数。    
								alert("success");
								$('#addModal').on('hidden.bs.modal',function(event){//当modal框完全隐藏后再刷新页面content，要不然有bug
									$("#content-wrapper").html(data);//刷新content页面
								});
							}
						});
			        }    
			    });
	});
	

</script>