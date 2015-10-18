<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="vino" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!-- Content Header (Page header) -->

<section class="content-header">
	<h1>
		资源管理 <small></small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i>系统管理</a></li>
		<li class="active">资源管理</li>
	</ol>
</section>

<!-- Main content -->
<section class="content">
	<div class="row">
		<!-- <div class="col-md-6"> -->
		<div class="box">
			<!-- /.box-header -->
			<div class="box-body">
			
				<!-- /.row -->
				<div class="box box-primary">
					<div class="box-header with-border">
						<h3 class="box-title">资源树</h3>
					</div>
					<div class="btn-group">
						
						
						<!-- 注意，为了设置正确的内补（padding），务必在图标和文本之间添加一个空格。 -->
						<shiro:hasPermission name="resource:create">
						<button id="addBtn" type="button"
							class="btn  btn-primary btn-flat margin" data-toggle="modal"
							data-target="#addModal">
							<span class="fa fa-fw  fa-plus" aria-hidden="true"></span> 新增
						</button>	
						</shiro:hasPermission>
						
						<shiro:hasPermission name="resource:delete">
										
						<button id="deleteBtn" type="button"
							class="btn  btn-danger btn-flat margin">
							<span class="fa fa-fw fa-remove" aria-hidden="true"></span> 删除</button>
						
						</shiro:hasPermission>	
						<shiro:hasPermission name="resource:view">
						<button id="detailBtn" type="button"
							class="btn  btn-primary btn-flat margin" data-toggle="modal"
										data-target="#detailModal" onclick=''>
							<span class="fa fa-fw fa-newspaper-o" aria-hidden="true"></span> 详情</button>	
						</shiro:hasPermission>
						<shiro:hasPermission name="resource:update">
						<button id="updateBtn" type="button"
							class="btn  btn-primary btn-flat margin" data-toggle="modal"
										data-target="#updateModal" onclick=''>
							<span class="fa fa-fw fa-pencil-square-o" aria-hidden="true"></span> 编辑</button>	
							</shiro:hasPermission>	
							
					</div>
					<div class="zTreeDemoBackground right">
						<ul id="resourceTree" class="ztree"></ul>
					</div>
				</div>
				<!-- /.box-body -->
			</div>
			<!-- /.box -->
		</div>
	</div>
</section>
<!-- /.content -->

<!-- 新增页面 modal框 -->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="exampleModalLabel">新增资源</h4>
			</div>
			<div class="modal-body">
					
				<label for="parentName" class="control-label">上级资源:</label> 
						<font color="red"><span id="parentName">请返回,选定上级资源再进行操作</span></font>
					
				<form id="addForm" action="resource/add" method="post">
					<div class="form-group">
						<label for="name" class="control-label">资源名:</label> <input
							type="text" class="form-control" id="name" name="name">
					</div>
					<div class="form-group">
						<label for="permission" class="control-label">权限字符串:</label> <input
							type="text" class="form-control" id="permission" name="permission">
					</div>
					<div class="form-group">
						<label for="type" class="control-label">资源类型:</label> <input
							type="text" class="form-control" id="type" name="type">
					</div>
					<div class="form-group">
						<label for="url" class="control-label">菜单路径URL:</label> <input
							type="text" class="form-control" id="url" name="url">
					</div>
					<div class="form-group">
						<label for="priority" class="control-label">排序优先级:</label> <input
							type="text" class="form-control" id="priority" name="priority">
					</div>	
						
					
					<input type="hidden" class="form-control" id="parentId" name="parentId" >
									
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary" id="addSubmitBtn">提交</button>
			</div>
		</div>
	</div>
</div>
<!-- ./新增页面 modal框 -->

<!-- 编辑页面 modal框  -->
<div class="modal fade" id="updateModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content"></div>
	</div>
</div>

<!-- 详情页面 modal框  -->
<div class="modal fade" id="detailModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content"></div>
	</div>
</div>



<script>
	/*   */
	//Date range picker
	$('#reservation').daterangepicker();
	//Date range picker with time picker
	$('#reservationtime').daterangepicker({timePicker: true, timePickerIncrement: 30, format: 'MM/DD/YYYY h:mm A'});
	
	/* icheck 初始化 详情：https://github.com/fronteed/icheck */
   	iCheckInit();
 	/* iCheck事件监听 详情：https://github.com/fronteed/icheck */
 	/* 全选和取消全选 */
	$(document).ready(function(){
		$('#allCheck').on('ifToggled', function(event){		
			$('input[class*="deleteCheckbox"]').iCheck('toggle');			
		});
		
	});
	
	function getCheckedResourceIds(){
		var treeObj = $.fn.zTree.getZTreeObj("resourceTree");
		var nodes = treeObj.getCheckedNodes(true);

		var resourceIds=[];
		for(var i=0;i<nodes.length;i++){
			resourceIds[i]=nodes[i].id;
		}
		return resourceIds;	
		}
	
	/* button监听事件 */
	$(document).ready(function(){
		$("#deleteBtn").click(function(){
			deleteItemsById(getCheckedResourceIds(),"resource/delete");
		});
		
	});
		
 	/*modal框事件监听 详情：http://v3.bootcss.com/javascript/#modals-events */
	$('#addModal').on('shown.bs.modal', function(event) {			
			$("#addSubmitBtn").click(function() {
				if($('#parentId').val()==""){
					alert("请返回,选定上级资源再进行操作");
					return;
				}
				
				$.ajax({
					async : false,
					cache : false,
					type : 'POST',
					data : $("#addForm").serialize(),
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
			});
		});
	

	$("#searchBtn").click(function() {
		$('#pageNumber').val(1);
		$.ajax({
			async : false,
			cache : false,
			type : 'GET',
			data : $("#searchForm").serialize(),		 
			url : "resource/search",//请求的action路径  
			error : function() {//请求失败处理函数  
				alert('失败');
			},
			success : function(data) { //请求成功后处理函数。    
				$("#content-wrapper").html(data);//刷新content页面
			
			}
		});
	});

	function updateItem(id){
		$('#updateModal').on('show.bs.modal',function(event){
			$('#updateModal .modal-content').load('resource/'+id);
		});
	}
	function detailItem(id){
		$('#detailModal').on('show.bs.modal',function(event){
			$('#detailModal .modal-content').load('resource/detail/'+id)
		});
	}
	/* ztree */
	/* 节点点击的时候回调函数*/
	function onTreeNodeClick(event, treeId, treeNode, clickFlag) {
			$("#parentId").val(treeNode.id);//设置上级资源id
			$("#parentName").text(treeNode.name);
			$("#detailBtn").attr("onclick","detailItem("+treeNode.id+")");//设置要显示的详情的id
			$("#updateBtn").attr("onclick","updateItem("+treeNode.id+")");//设置要显示的编辑页面的id
		}	
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
			enable: true,
			chkboxType: { "Y": "s", "N": "s" }//设置勾选行为
		},
		callback: {
			
			onClick: onTreeNodeClick
		}
	};  
   	 
	   var zNodes;  
	   $(document).ready(function(){  
		   $.ajax({  
	            async : false,  
	            cache:false,  
	            type: 'GET',  
	            dataType : "json",  
	            url: "resource/json/all",//请求的action路径  
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