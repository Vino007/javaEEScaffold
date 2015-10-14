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
						<label for="name" class="control-label">资源名:</label> <input
							type="text" class="form-control" id="name" name="name" disabled="disabled" value="${resource.name}" >
					</div>		
					<div class="form-group">
						<label for="permission" class="control-label">权限字符串:</label> <input
							type="text" class="form-control" id="permission" name="permission" value="${resource.permission}">
					</div>			
					<div class="form-group">
						<label for="type" class="control-label">类型:</label> <input
							type="text" class="form-control" id="type" name="type" value="${resource.type}">
					</div>
					
					<div class="form-group">
						<label for="priority" class="control-label">排序优先级:</label> <input
							type="text" class="form-control" id="priority" name="priority" value="${resource.priority}">
					</div>
					<div class="form-group">
						<label for="parentId" class="control-label">上级资源ID:</label> <input
							type="text" class="form-control" id="parentId" name="parentId" value="${resource.parentId}">
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
				<button type="button" class="btn btn-primary" id="updateSubmitBtn">提交</button>
			</div>
			</form>
<script>
/* 异步提交表单及更新content */
$('#updateModal').on('shown.bs.modal', function(event) {

		$("#updateSubmitBtn").click(function() {
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
					$('#updateModal').on('hidden.bs.modal',function(event){//当modal框完全隐藏后再刷新页面content，要不然有bug
						$("#content-wrapper").html(data);//刷新content页面
					});
				}
			});
		});
	});

</script>