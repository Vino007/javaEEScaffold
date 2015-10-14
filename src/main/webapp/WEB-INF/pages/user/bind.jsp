<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal"
		aria-label="Close">
		<span aria-hidden="true">&times;</span>
	</button>
	<h4 class="modal-title" id="exampleModalLabel">资源绑定</h4>
</div>

<div class="modal-body">
	<form id="bindForm" method="post">
		<input name="id" value="${role.id}" hidden="true" />
		<div class="form-group">
			<label for="name" class="control-label">角色名:</label>${role.name}
		</div>
		<div class="form-group">
			<label for="resourceSelect" class="control-label">绑定资源:</label> <select
				id="resourceSelect" data-placeholder="选择资源"
				class="form-control select2  js-example-placeholder-multiple"
				tabindex="-1" multiple="multiple" style="width: 100%">

				<optgroup label="已持有资源">
					<c:forEach var="resource" items="${role.resources}" varStatus="status">
						<option value="${resource.id}" selected="selected">${resource.name}</option>
					</c:forEach>
					<!-- 	<option value="primaryRole" selected="selected">初级用户</option>
					<option value="seniorRole" selected="selected">中级用户</option> -->
				</optgroup>
				<optgroup label="可选资源">
					<c:forEach var="resource" items="${availableRoles}" varStatus="status">
						<option value="${resource.id}">${resource.name}</option>
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
	$('#bindModal').on('shown.bs.modal', function(event) {

		$("#bindSubmitBtn").click(function() {
			var resourceIds=[];
			var i=0;
			$("select option").each(function(index,item){			
				if(item.selected==true)
					resourceIds[i++]=this.value;
				
			});
			
			$.ajax({
				async : false,
				cache : false,
				type : 'POST',
				data : $.param({
					resourceIds:resourceIds,
					roleId:${role.id}
				}),
			   // contentType : 'application/json',    //发送信息至服务器时内容编码类型
				//dataType : "json",
				url : "role/bind",//请求的action路径  
				error : function() {//请求失败处理函数  
					alert('失败');
				},
				success : function(data) { //请求成功后处理函数。    
					alert("success");						
					$('#bindModal').on('hidden.bs.modal',function(event){//当modal框完全隐藏后再刷新页面content，要不然有bug
						$("#content-wrapper").html(data);//刷新content页面
					});
				}
			});
		});
	});

/* ztree */
    var setting = {  
    		data: {
				simpleData: {
					enable: true,
					idKey:"id",
					pIdKey:"pId"
				},
    		view: {
				showIcon: true
				}
			}	      
	    };  	      
	   var zNodes;  
	   $(document).ready(function(){  
	    $("#getRoles").click(function(){
	        $.ajax({  
	            async : false,  
	            cache:false,  
	            type: 'GET',  
	        //    contentType : 'application/json',  //发送信息至服务器时内容编码类型
	            dataType : "json",  
	            url: "resource/all",//请求的action路径  
	            error: function () {//请求失败处理函数  
	                alert('请求失败');  
	            },  
	            success:function(data){ //请求成功后处理函数。    
	                alert(data);  
	                zNodes = data;   //把后台封装好的简单Json格式赋给treeNodes  
	            }  
	        });  
	      
	       $.fn.zTree.init($("#tree"), setting, zNodes);
	    }); 
	   });
	   
	    $(document).ready(function() {
	        $(".js-example-placeholder-multiple").select2({
	        	  placeholder: "选择角色",
	        	  allowClear: true
	        });
	        
	      });
	       
	     
</script>
