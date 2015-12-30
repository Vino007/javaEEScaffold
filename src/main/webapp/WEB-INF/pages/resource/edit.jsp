<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
   
	<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="exampleModalLabel">编辑资源</h4>
			</div>
				<form id="updateForm" action="resource/update" method="post">
			<div class="modal-body">

					<input name="id" value="${resource.id}" hidden="true"/>
					<div class="form-group">
						<label for="name" class="control-label">资源名:</label> ${resource.name}
						<%-- <input
							type="text" class="form-control" id="name" name="name" disabled="disabled" value="${resource.name}" > --%>
					</div>		
					<div class="form-group">
						<label for="permission" class="control-label">权限字符串:</label> <input
							type="text" class="form-control" id="permission" name="permission" value="${resource.permission}">
					</div>							
					<div class="form-group">
							<label for="type" class="control-label"><font color="red">*</font>资源类型:</label> 
						<c:choose>
							<c:when test="${resource.type=='Menu'}">
							<input  name="type"  type="radio" checked="checked" value="menu">Menu
							<input  name="type"  type="radio" value="button">Button
							</c:when>
							<c:otherwise>
							<input  name="type"  type="radio" value="menu">Menu
							<input  name="type"  type="radio" checked="checked" value="button">Button
							</c:otherwise>
							</c:choose>													
					</div>
					<div class="form-group">
						 <input
							type="hidden" class="form-control" id="parentId" name="parentId" value="${resource.parentId}">
					</div>
					<div class="form-group">
						<label for="priority" class="control-label"><font color="red">*</font>排序优先级:</label> <input
						placeholder="优先级数字越小，排在越上面"
							type="text" class="form-control" id="priority" name="priority" value="${resource.priority }">
					</div>	
					<div class="form-group">
						<label for="url" class="control-label">菜单路径URL:</label> <input
							type="text" class="form-control" id="url" name="url" value="${resource.url}">
					</div>
					<div class="form-group">
						<label for="available" class="control-label">状态:</label> 
						<c:choose>
							<c:when test="${resource.available}">
							<input  name="available"  type="radio" checked="checked" value="true">可用
							<input  name="available"  type="radio" value="false">不可用
							</c:when>
							<c:otherwise>
							<input  name="available"  type="radio" value="true">可用
							<input  name="available"  type="radio" checked="checked" value="false">不可用
							</c:otherwise>
						</c:choose>
					</div>
				
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="submit" class="btn btn-primary" id="updateSubmitBtn">提交</button>
			</div>
			</form>
<script>
/* 异步提交表单及更新content */
$('#modal').on('shown.bs.modal', function(event) {

	$("#updateForm").validate({
		 rules:{
			 name:{ //格式：domId: 规则
				 minlength:2,//无效
				 maxlength:30,
				 required:true							 	
				 },
			 type:"required",
			 available:"required",
			 permission:{
				 required:true,
				 isPermission:true
			 },//正则来校验，xxx:xxx:xxx
			 priority:{
				 min:1,//无效
				 max:999,
				 required:true,
				 digits:true	
				 }
		 },
		 messages:{					
			 priority:{
				 max: jQuery.validator.format("请输入一个最大为{0} 的数"),
				 min: jQuery.validator.format("请输入一个最小为{0} 的数"),						
				 digits: "只能输入整数",
				 reuqired:true
			 }
		 },
		 
		 submitHandler : function(form){
			$.ajax({
				async : false,
				cache : false,
				type : 'POST',
				data : $("#updateForm").serialize(),
			   
				url : "resource/update",//请求的action路径  
				error : function() {//请求失败处理函数  
					alert('失败');
				},
				success : function(data) { //请求成功后处理函数。    
					alert("success");						
					$('#modal').on('hidden.bs.modal',function(event){//当modal框完全隐藏后再刷新页面content，要不然有bug
						$("#content-wrapper").html(data);//刷新content页面
					});
				}
			});
		 }
		});
	
	});

</script>