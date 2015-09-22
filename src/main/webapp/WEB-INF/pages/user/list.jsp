<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Content Header (Page header) -->

<section class="content-header">
	<h1>
		Simple Tables <small>preview of simple tables</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li><a href="#">Tables</a></li>
		<li class="active">Simple</li>
	</ol>
</section>

<!-- Main content -->
<section class="content">
	<div class="row">
		<!-- <div class="col-md-6"> -->
		<div class="box">
			<div class="box-header with-border">
				<h3 class="box-title">用户列表</h3>
			</div>

			<!-- /.box-header -->
			<div class="box-body">
				<div class="btn-group">
					<!-- 注意，为了设置正确的内补（padding），务必在图标和文本之间添加一个空格。 -->
					<button id="addBtn" type="button"	class="btn  btn-primary btn-flat margin" data-toggle="modal" data-target="#addModal">
						<span class="fa fa-fw fa-flask" aria-hidden="true"></span> 新增					
					</button>
					<button id="bindBtn" type="button" class="btn  btn-primary btn-flat margin">角色绑定</button>
					<button id="deleteBtn" type="button" class="btn  btn-danger btn-flat margin">删除</button>
					<button id="unlockBtn" type="button" class="btn  btn-primary btn-flat margin">解锁</button>
					<button id="lockBtn" type="button" class="btn s btn-danger btn-flat margin">锁定</button>
				</div>
				<table  class="table table-bordered">
					<tr>
						<th style="width: 10px">
						<label> 
						<input id="allCheck" type="checkbox" class="minimal"  value="0">
						</label>
						</th>
						<th style="width: 10px">#</th>
						<th>用户名</th>
						<th>别名</th>
						<th>创建时间</th>
						<th>创建人</th>
						<th style="width: 60px">状态</th>

					</tr>
					<c:forEach items="${users}" var="user" varStatus="status" >
						<tr>
							<td>
							<label><input type="checkbox" class="minimal deleteCheckbox" value="${user.id}" ></label>
							</td>
							<td>${status.count}</td>
							<td>${user.username}</td>
							<td>${user.userAlias}</td>
							<td>${user.createTime}</td>
							<td>${user.creatorId}</td>
							<c:choose>
								<c:when test="${user.locked}">
									<td><span class="badge bg-red">锁定</span></td>
								</c:when>
								<c:otherwise>
									<td><span class="badge bg-green">未锁定</span></td>
								</c:otherwise>
							</c:choose>

						</tr>
					</c:forEach>
				</table>
			</div>
			<!-- /.box-body -->
			<!-- 分页 -->
			<div class="box-footer clearfix">
				<ul class="pagination pagination-sm no-margin pull-right">
					<li><a href="#">&laquo;</a></li>
					<li><a href="#">1</a></li>
					<li><a href="#">2</a></li>
					<li><a href="#">3</a></li>
					<li><a href="#">&raquo;</a></li>
				</ul>
			</div>
		</div>
		<!-- /.box -->
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
				<h4 class="modal-title" id="exampleModalLabel">新增用户</h4>
			</div>
			<div class="modal-body">

				<form id="addForm" action="user/add" method="post">
					<div class="form-group">
						<label for="username" class="control-label">用户名:</label> <input
							type="text" class="form-control" id="username" name="username">
					</div>
					<div class="form-group">
						<label for="password" class="control-label">密码:</label> <input
							class="form-control" id="password" name="password">
					</div>
					<div class="form-group">
						<label for="userAlias" class="control-label">别名:</label> <input
							type="text" class="form-control" id="userAlias" name="userAlias">
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary" id="submitBtn">提交</button>
			</div>
		</div>
	</div>
</div>
<!-- ./新增页面 modal框 -->

<script>
	/* icheck 初始化 详情：https://github.com/fronteed/icheck */
   
 	/* iCheck事件监听 详情：https://github.com/fronteed/icheck */
 	/* 全选和取消全选 */
	$(document).ready(function(){
		$('#allCheck').on('ifToggled', function(event){		
			$('input[class*="deleteCheckbox"]').iCheck('toggle');			
		});
		
	});
	

	/* button监听事件 */
	$(document).ready(function(){
		$("#deleteBtn").click(function(){
			deleteItems("input[class*='deleteCheckbox']","user/delete");
		});
		
	});
		
 	/*modal框事件监听 详情：http://v3.bootcss.com/javascript/#modals-events */
	$('#addModal').on('shown.bs.modal', function(event) {
		// var recipient = button.data('whatever') // Extract info from data-* attributes
		// If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
		// Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	
			$("#submitBtn").click(function() {
				$.ajax({
					async : false,
					cache : false,
					type : 'POST',
					data : $("#addForm").serialize(),
				   // contentType : 'application/json',    //发送信息至服务器时内容编码类型
					//dataType : "json",
					url : "user/add",//请求的action路径  
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
</script>