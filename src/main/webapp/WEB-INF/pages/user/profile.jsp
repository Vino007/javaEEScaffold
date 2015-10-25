<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="vino" tagdir="/WEB-INF/tags"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!-- Content Header (Page header) -->
<section class="content-header">
	<h1>
		个人资料 <small></small>
	</h1>
	<ol class="breadcrumb">
		<li class="active">个人资料</li>
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
								<h3 class="box-title">个人资料</h3>
							</div>
							<div class="box-body">
								<table class="table">
								<tr><td>用户名:</td><td>${currentUser.username}</td></tr>	
								<tr><td>别名:</td><td>${currentUser.userAlias}</td></tr>	
								<tr><td>上次登录时间:</td><td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${currentUser.lastLoginTime}"></fmt:formatDate></td></tr>	
								<tr><td>登录时间:</td><td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${currentUser.loginTime}"></fmt:formatDate></td></tr>	
								<tr><td>创建时间:</td><td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${currentUser.createTime}"></fmt:formatDate></td></tr>	
							
								</table>
							</div>
						
						</div>
						<!-- /.box -->
					</div>
					<!-- /.col (right) -->
				</div>
				
				
			</div>
			<!-- /.box -->
		</div>
	</div>
</section>
<!-- /.content -->
