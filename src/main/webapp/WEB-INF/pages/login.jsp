<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>AdminLTE 2 | Log in</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
   <link type="text/css" rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/bootstrap.css" />
  <!-- Font Awesome -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/AdminLTE/dist/css/font-awesome.min.css"/>
<!-- Ionicons -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/AdminLTE/dist/css/ionicons.min.css"/>
 <!-- Theme style -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/AdminLTE/dist/css/AdminLTE.min.css"/>
    <!-- iCheck -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/AdminLTE/plugins/iCheck/square/blue.css"/>
  
  </head>
  <body class="hold-transition login-page">
    <div class="login-box">
      <div class="login-logo">
        <b>JaveEE</b>脚手架
      </div><!-- /.login-logo -->
      <div class="login-box-body">
        <p class="login-box-msg">登录</p>
        <form action="" method="post">
          <div><font color="red">${loginError}</font></div>
          <div class="form-group has-feedback">
            <input type="text" name="username" class="form-control" placeholder="Username">
            <span></span>
          </div>
          <div class="form-group has-feedback">
            <input type="password" name="password" class="form-control" placeholder="Password">
            <span></span>
          </div>
          <div class="row">
            <div class="col-xs-8">
              <div class="checkbox icheck">
                <label>
                  <input type="checkbox" name="rememberMe" value="true"> 记住我
                </label>
              </div>
            </div><!-- /.col -->
            <div class="col-xs-4">
              <button type="submit" class="btn btn-primary btn-block btn-flat">登录</button>
            </div><!-- /.col -->
          </div>
        </form>     
        <a href="#">忘记密码</a><br>
        <a href="register.html" class="text-center">注册</a>

      </div><!-- /.login-box-body -->
    </div><!-- /.login-box -->

<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery-2.1.4.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/bootstrap.js"></script>
	<script
	src="<%=request.getContextPath()%>/resources/AdminLTE/plugins/iCheck/icheck.min.js"></script>
	<script>
      $(function () {
        $('input').iCheck({
          checkboxClass: 'icheckbox_square-blue',
          radioClass: 'iradio_square-blue',
          increaseArea: '20%' // optional
        });
      });
    </script>
  </body>
</html>
