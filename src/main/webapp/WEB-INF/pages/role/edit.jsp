<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
   
	<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="exampleModalLabel">编辑角色</h4>
			</div>
				<form id="updateForm" action="role/update" method="post">
			<div class="modal-body">

					<input name="id" value="${role.id}" hidden="true"/>
					<div class="form-group">
						<label for="name" class="control-label">角色名:</label>${role.name}<%--  <input
							type="text" class="form-control" id="name" name="name" disabled="disabled" value="${role.name}" > --%>
					</div>					
					<div class="form-group">
						<label for="description" class="control-label">描述:</label> <input
							type="text" class="form-control" id="description" name="description" value="${role.description}">
					</div>
					<div class="form-group">
						<label for="available" class="control-label">状态:</label> 
						<c:choose>
							<c:when test="${role.available}">
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

	$('#updateForm').validate({	
		 submitHandler : function(form){
			$.ajax({
				async : false,
				cache : false,
				type : 'POST',
				data : $("#updateForm").serialize(),			
				url : "role/update",//请求的action路径  
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