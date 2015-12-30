<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal"
		aria-label="Close">
		<span aria-hidden="true">&times;</span>
	</button>
	<h4 class="modal-title" id="exampleModalLabel">绑定资源</h4>
</div>

<div class="modal-body">
	<form id="bindForm" method="post">
		<input name="id" value="${role.id}" hidden="true" />
		<div class="form-group">
			<label for="name" class="control-label">角色名:</label>${role.name}
		</div>		
		<div class="form-group">
			<div class="zTreeDemoBackground right">
			<ul id="resourceTree" class="ztree"></ul>
	</div>
		</div>
	</form>
</div>
<div class="modal-footer">
	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	<button type="button" class="btn btn-primary" id="bindSubmitBtn">提交</button>
</div>

<script type="text/javascript">	
/*获取选中的resourceid*/
function getCheckedResourceIds(){
	var treeObj = $.fn.zTree.getZTreeObj("resourceTree");
	var nodes = treeObj.getCheckedNodes(true);

	var resourceIds=[];
	for(var i=0;i<nodes.length;i++){
		resourceIds[i]=nodes[i].id;
	}
	return resourceIds;	
	}
/* 提交表单 */
	$('#modal').on('shown.bs.modal', function(event) {
		$("#bindSubmitBtn").click(function() {			
			var resourceIds=getCheckedResourceIds();					
			$.ajax({
				async : false,
				cache : false,
				type : 'POST',
				data : $.param({
					resourceIds:resourceIds,
					roleId:${role.id}
				}),			  
				url : "role/bind",//请求的action路径  
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
			},
	    check: {
			enable: true
		}
	};  
   	 
	   var zNodes;  
	   $(document).ready(function(){  
		   $.ajax({  
	            async : false,  
	            cache:false,  
	            type: 'GET',  
	            dataType : "json",  
	            url: "role/json/getResources/"+${role.id},//请求的action路径  
	            error: function () {//请求失败处理函数  
	                alert('请求失败');  
	            },  
	            success:function(data){ //请求成功后处理函数。    	                
	                zNodes = data;   //把后台封装好的简单Json格式赋给treeNodes  
	            }  
	        });  
	      
	       $.fn.zTree.init($("#resourceTree"), setting, zNodes);
	   });
	   	     
</script>
