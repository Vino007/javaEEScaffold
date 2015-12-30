<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal"
		aria-label="Close">
		<span aria-hidden="true">&times;</span>
	</button>
	<h4 class="modal-title" id="exampleModalLabel">角色绑定</h4>
</div>

<div class="modal-body">
	<form id="bindForm" method="post">
		<input name="id" value="${user.id}" hidden="true" />
		<div class="form-group">
			<label for="name" class="control-label">角色名:</label>${role.name}
		</div>
		<div class="form-group">
			<label for="resourceSelect" class="control-label">绑定角色:</label> <select
				id="resourceSelect" data-placeholder="选择角色"
				class="form-control select2  js-example-placeholder-multiple"
				tabindex="-1" multiple="multiple" style="width: 100%">

				<optgroup label="已持有角色">
					<c:forEach var="role" items="${user.roles}" varStatus="status">
						<option value="${role.id}" selected="selected">${role.name}</option>
					</c:forEach>					
				</optgroup>
				<optgroup label="可选角色">
					<c:forEach var="role" items="${availableRoles}" varStatus="status">
						<option value="${role.id}">${role.name}</option>
					</c:forEach>

				</optgroup>
			</select>
		</div>
	</form>
</div>
<div class="modal-footer">
	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	<button type="button" class="btn btn-primary" id="bindSubmitBtn">提交</button>
</div>

<script type="text/javascript">	
/* 提交表单 */
	$('#modal').on('shown.bs.modal', function(event) {

		$("#bindSubmitBtn").click(function() {
			var roleIds=[];
			var i=0;
			$("select option").each(function(index,item){			
				if(item.selected==true)
					roleIds[i++]=this.value;				
			});
			
			$.ajax({
				async : false,
				cache : false,
				type : 'POST',
				data : $.param({
					roleIds:roleIds,
					userId:${user.id}
				}),			  
				url : "user/bind",//请求的action路径  
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
		});
	});
	   
	    $(document).ready(function() {
	        $(".js-example-placeholder-multiple").select2({
	        	  placeholder: "选择角色",
	        	  allowClear: true
	        });
	        
	      });
	       
	     
</script>
