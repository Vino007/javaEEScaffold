<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
	<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="exampleModalLabel">编辑用户</h4>
			</div>
				<form id="updateForm" action="user/update" method="post">
			<div class="modal-body">

					<input name="id" value="${user.id}" hidden="true"/>
					<div class="form-group">
						<label for="username" class="control-label">用户名:</label> ${user.username}<%-- <input
							type="text" class="form-control " id="username" name="username" disabled="disabled" value="${user.username}" > --%>
					</div>					
					<div class="form-group">
						<label for="userAlias" class="control-label">别名:</label> <input
							type="text" class="form-control" id="userAlias" name="userAlias" value="${user.userAlias}">
					</div>
					<div class="form-group">
						<label for="locked" class="control-label">状态:</label> 
						<c:choose>
							<c:when test="${user.locked}">
							<input  name="locked"  type="radio" checked="checked" value="true">锁定
							<input  name="locked"  type="radio" value="false">未锁定
							</c:when>
							<c:otherwise>
							<input  name="locked"  type="radio" value="true">锁定
							<input  name="locked"  type="radio" checked="checked" value="false">未锁定
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
			 userAlias:{ //格式：domId: 规则
				 minlength:2,//无效
				 maxlength:30,
				 required:true,							 	
				 }
		 },
		 messages:{
			
		 },
		 submitHandler : function(form){			
			 $.ajax({
					async : false,
					cache : false,
					type : 'POST',
					data : $("#updateForm").serialize(),				
					url : "user/update",//请求的action路径  
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