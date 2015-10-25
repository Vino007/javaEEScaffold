<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<head>
<title>JavaEE Scaffold</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%@ include file="/WEB-INF/pages/common/default_header.jsp"%>
<%@ include file="/WEB-INF/pages/common/default_css.jsp"%>

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<!--
  BODY TAG OPTIONS:
  =================
  Apply one or more of the following classes to get the
  desired effect
  |---------------------------------------------------------|
  | SKINS         | skin-blue                               |
  |               | skin-black                              |
  |               | skin-purple                             |
  |               | skin-yellow                             |
  |               | skin-red                                |
  |               | skin-green                              |
  |---------------------------------------------------------|
  |LAYOUT OPTIONS | fixed                                   |
  |               | layout-boxed                            |
  |               | layout-top-nav                          |
  |               | sidebar-collapse                        |
  |               | sidebar-mini                            |
  |---------------------------------------------------------|
  -->
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">

		<!-- Main Header -->
		<%@include file="/WEB-INF/pages/common/main_header.jsp"%>
		<!-- Left side column. contains the logo and sidebar -->
		<%@include file="/WEB-INF/pages/common/left_sidebar.jsp"%>

		<!-- 内容区域 -->
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper" id="content-wrapper">
			 <%@include file="/WEB-INF/pages/common/main_content.jsp" %><!-- default content --> 
			<%-- <%@include file="/WEB-INF/pages/example/simpleTable.jsp"%> --%>
		</div>
		<!-- /.content-wrapper -->

		<!-- Main Footer -->
		<%@include file="/WEB-INF/pages/common/main_footer.jsp"%>

		<!-- Control Sidebar -->
		<%@include file="/WEB-INF/pages/common/control_sidebar.jsp"%>
		<!-- /.control-sidebar -->
		<!-- control-sidebar的背景设置  Add the sidebar's background. This div must be placed
           immediately after the control sidebar -->
		<div class="control-sidebar-bg"></div>
	</div>
	<!-- ./wrapper -->

	<!-- REQUIRED JS SCRIPTS -->
	<%@ include file="/WEB-INF/pages/common/default_js.jsp"%>

	<!-- Optionally, you can add Slimscroll and FastClick plugins.
         Both of these plugins are recommended to enhance the
         user experience. Slimscroll is required when using the
         fixed layout. -->
	<script type="text/javascript">
         $(document).ready(function(){
        	 $(".sidebarMenuHref").click(function(){
        		 
        		 $.ajax({
                     async : false,
                     cache:false,
                     type: 'GET',
                     //    contentType : 'application/json',  //发送信息至服务器时内容编码类型
                     //dataType : "json",
                     url: this.href,//请求的action路径
                     error: function () {//请求失败处理函数
                         alert('请求失败');
                     },
                     success:function(data){ //请求成功后处理函数。
                        // alert(data);
                     $("#content-wrapper").html(data);
                     }
        	 });
        	 return false;       		
          	});
          	});
         
         $(document).ready(function(){
        	 $("#profile").click(function(){
        		 
        		 $.ajax({
                     async : false,
                     cache:false,
                     type: 'GET',
                     //    contentType : 'application/json',  //发送信息至服务器时内容编码类型
                     //dataType : "json",
                     url: this.href,//请求的action路径
                     error: function () {//请求失败处理函数
                         alert('请求失败');
                     },
                     success:function(data){ //请求成功后处理函数。
                        // alert(data);
                     $("#content-wrapper").html(data);
                     }
        	 });
        	 return false;       		
          	});
          	});
          	
         </script>	
</body>
</html>
