<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><!-- 不加这句，编码会出错！！ -->
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="v" uri="http://www.vino007.com/sidebarRank"%>
<% %>
<aside class="main-sidebar">

	<!-- sidebar: style can be found in sidebar.less -->
	<section class="sidebar">

		<!-- Sidebar user panel (optional) -->
		<div class="user-panel">
			<div class="pull-left image">
				<img src="<%=request.getContextPath()%>/resources/AdminLTE/dist/img/user2-160x160.jpg"
					class="img-circle" alt="User Image">
			</div>
			<div class="pull-left info">
				<p>${currentUser.userAlias}</p>
				<!-- Status -->
				<a href="#"><i class="fa fa-circle text-success"></i> Online</a>
			</div>
		</div>

		<!-- search form (Optional) -->
<!-- 		<form action="#" method="get" class="sidebar-form">
			<div class="input-group">
				<input type="text" name="q" class="form-control"
					placeholder="Search..."> <span class="input-group-btn">
					<button type="submit" name="search" id="search-btn"
						class="btn btn-flat">
						<i class="fa fa-search"></i>
					</button>
				</span>
			</div>
		</form> -->
		<!-- /.search form -->
		<!-- Sidebar Menu -->
		<ul class="sidebar-menu">
			<li class="header">MAIN NAVIGATION</li>
			<!-- Optionally, you can add icons to the links -->
		
		<!-- 	<li><a href="#"><i class="fa fa-link"></i> <span>Another Link</span></a></li> -->
			
			<li class="treeview">
			<!-- <a href="#"><i class="fa fa-link"></i><span>系统管理</span> <i class="fa fa-angle-left pull-right"></i></a> -->
				<!-- <ul class="treeview-menu"> -->
					<v:sidebarRank currentUser="${currentUser}"/>	
			
				<!-- </ul -->
			</li>
			<!-- <li><a href="../../documentation/index.html"><i class="fa fa-book"></i> <span>Documentation</span></a></li> -->
		</ul>
		<!-- /.sidebar-menu -->
	</section>
	<!-- /.sidebar -->
</aside>
