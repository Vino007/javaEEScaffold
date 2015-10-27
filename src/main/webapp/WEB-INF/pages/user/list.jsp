<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="vino" tagdir="/WEB-INF/tags"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!-- Content Header (Page header) -->
<section class="content-header">
	<h1>
		用户管理 <small></small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i>系统管理</a></li>
		<!-- <li><a href="#">用户管理</a></li> -->
		<li class="active">用户管理</li>
	</ol>
</section>
<!-- Main content -->
<section class="content">
	<div class="row">
		<!-- <div class="col-md-6"> -->
		<div class="box">
			<!-- /.box-header -->
			<div class="box-body">
				<div class="row">
					<div class="col-md-12">
						<div class="box box-primary">
							<div class="box-header with-border">
								<h3 class="box-title">数据查询</h3>
							</div>
							<div class="box-body">
								<!-- form start -->
								<form id="searchForm" action="user/search" method="get">
									<div class="box-body">
										<div class="row">
											<input hidden="true" name="pageNumber" id="pageNumber">
											<div class="form-group col-md-2">
												<label for="usernameLabel">用户名:</label> <input type="text"
													class="form-control" id="usernameLabel"
													name="search_username" value="${searchParamsMap.username }">
											</div>
											<div class="form-group col-md-2">
												<label for="aliasLabel">别名:</label> <input type="text"
													class="form-control" id="aliasLabel"
													name="search_userAlias"
													value="${searchParamsMap.userAlias }">
											</div>
											<!-- Date range -->
											<div class="form-group  col-md-4">
												<label>创建时间:</label>
												<div class="input-group">
													<div class="input-group-addon">
														<i class="fa fa-calendar"></i>
													</div>
													<input type="text" class="form-control pull-right"
														id="reservation" name="search_createTimeRange"
														value=${searchParamsMap.createTimeRange }>
												</div>
												<!-- /.input group -->
											</div>
											<!-- <div class="form-group col-md-2">
												<label for="isLockedLabel" >是否锁定: </label><br>
												<input id="isLockedLabel" type="checkbox" name="search_locked">
											</div> -->

											<!-- /.form group -->
										</div>
										<!-- other rows -->
									</div>
									<!-- /.box-body -->
									<div class="box-footer">
										<button id="searchBtn" type="submit"
											class="btn btn-info pull-right">查询</button>
									</div>
									<!-- /.box-footer -->
								</form>
							</div>
							<!-- /.box-body -->
						</div>
						<!-- /.box -->
					</div>
					<!-- /.col (right) -->
				</div>
				<!-- /.row -->
				<div class="box box-primary">
					<div class="box-header with-border">
						<h3 class="box-title">用户列表</h3>
					</div>
					<div class="btn-group">
						<!-- 注意，为了设置正确的内补（padding），务必在图标和文本之间添加一个空格。 -->

						<shiro:hasPermission name="user:create">
							<button id="addBtn" type="button"
								class="btn  btn-primary btn-flat margin" data-toggle="modal"
								data-target="#addModal" onclick="addItem()">
								<span class="fa fa-fw  fa-plus" aria-hidden="true"></span> 新增
							</button>
						</shiro:hasPermission>
						<shiro:hasPermission name="user:delete">
							<button id="deleteBtn" type="button"
								class="btn  btn-danger btn-flat margin">
								<span class="fa fa-fw fa-remove" aria-hidden="true"></span> 删除
							</button>
						</shiro:hasPermission>
						<shiro:hasPermission name="user:upload">
							<button id="uploadBtn" type="button"
								class="btn  btn-primary btn-flat margin" data-toggle="modal"
								data-target="#uploadModal" onclick="uploadItem()">
								<span class="fa fa-fw fa-cloud-upload" aria-hidden="true"></span> upload
							</button>
							</shiro:hasPermission>
							<shiro:hasPermission name="user:download">
							<form id="downloadForm" action="user/download" method="post">
							<input id="downloadIds" type="hidden" name="downloadIds[]">
							<button id="downloadBtn" type="submit"
								class="btn  btn-primary btn-flat margin" 
								 onclick="downloadItem()">
								<span class="fa fa-fw fa-cloud-download" aria-hidden="true"></span> download
							</button>
							</form>
							</shiro:hasPermission>

					</div>
					<table class="table table-hover">
						<tr>
							<th style="width: 10px"><label> <input id="allCheck"
									type="checkbox" class="minimal" value="0">
							</label></th>
							<th style="width: 10px">#</th>
							<th>用户名</th>
							<th>别名</th>
							<th>角色</th>
							<th>创建时间</th>
							<th>创建人</th>
							<th style="width: 60px">状态</th>
							<th style="width: 200px">操作</th>

						</tr>
						<c:forEach items="${users}" var="user" varStatus="status">
							<tr>
								<td><label><input type="checkbox"
										class="minimal deleteCheckbox" value="${user.id}"></label></td>
								<td>${status.count}</td>
								<td>${user.username}</td>
								<td>${user.userAlias}</td>
								<td><c:forEach var="role" items="${user.roles}">${role.name}&nbsp;&nbsp;&nbsp;&nbsp;</c:forEach></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
										value="${user.createTime}" /></td>
								<td>${user.creatorName}</td>
								<c:choose>
									<c:when test="${user.locked}">
										<td><span class="badge bg-red">锁定</span></td>
									</c:when>
									<c:otherwise>
										<td><span class="badge bg-green">未锁定</span></td>
									</c:otherwise>
								</c:choose>

								<td><shiro:hasPermission name="user:update">
										<button id="updateBtn" type="button"
											class="btn btn-xs btn-primary btn-flat " data-toggle="modal"
											data-target="#updateModal" onclick='updateItem(${user.id})'>编辑</button>
									</shiro:hasPermission> <shiro:hasPermission name="user:view">
										<button id="detailBtn" type="button"
											class="btn  btn-xs btn-primary btn-flat " data-toggle="modal"
											data-target="#detailModal" onclick='detailItem(${user.id})'>详情</button>
									</shiro:hasPermission> <shiro:hasPermission name="user:bind">
										<button id="bindRoleBtn" type="button"
											class="btn  btn-xs btn-primary btn-flat " data-toggle="modal"
											data-target="#bindModal" onclick='bindItem(${user.id})'>角色绑定</button>
									</shiro:hasPermission></td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<!-- /.box-body -->
				<!-- 分页 -->
				<vino:pagination paginationSize="10" page="${page}"
					action="user/search" contentSelector="#content-wrapper"></vino:pagination>
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

<!-- bind页面 modal框  -->
<div class="modal fade" id="bindModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content"></div>
	</div>
</div>
<!-- upload页面 modal框  -->
<div class="modal fade" id="uploadModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content"></div>
	</div>
</div>

<script>

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
	

	/* button监听事件 */
	$(document).ready(function(){
		$("#deleteBtn").click(function(){
			deleteItems("input[class*='deleteCheckbox']","user/delete");
		});
		
	});		
	$("#searchBtn").click(function() {
		$('#pageNumber').val(1);
		$.ajax({
			async : false,
			cache : false,
			type : 'GET',
			data : $("#searchForm").serialize(),		 
			url : "user/search",//请求的action路径  
			error : function() {//请求失败处理函数  
				alert('失败');
			},
			success : function(data) { //请求成功后处理函数。    
				$("#content-wrapper").html(data);//刷新content页面
			
			}
		});
	});
	function addItem(){
		$("#addModal").on('show.bs.modal',function(event){
			$('#addModal .modal-content').load('user/prepareAdd');
		});
	}
	function updateItem(id){
		$('#updateModal').on('show.bs.modal',function(event){
			$('#updateModal .modal-content').load('user/'+id);
		});
	}
	f
	function detailItem(id){
		$('#detailModal').on('show.bs.modal',function(event){
			$('#detailModal .modal-content').load('user/detail/'+id);
		});
	}
	function bindItem(id){
		$('#bindModal').on('show.bs.modal',function(event){
			$('#bindModal .modal-content').load('user/prepareBind/'+id);
		});
	}
	function uploadItem(){
		$('#uploadModal').on('show.bs.modal',function(event){
			$('#uploadModal .modal-content').load('user/prepareUpload');
		});
	}
	/**
	AJAX不能下载文件，用表单来实现
	*/
	function downloadItem(){	
		var downloadIds = [];
		var i = 0;
		$("input[class*='deleteCheckbox']").each(function(index, item) {
			var isChecked = item.checked;
			if (isChecked == true) {
				downloadIds[i++] = item.value;
			}
		});
		$('#downloadIds').val(downloadIds)
		$('#downloadForm').submit(function(){
			
		});
	}
	
	
</script>