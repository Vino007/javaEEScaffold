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
    <body class="hold-transition register-page">
    <div class="register-box">
      <div class="register-logo">
        <a href=""><b>Admin</b>LTE</a>
      </div>

      <div class="register-box-body">
        <p class="login-box-msg">注册</p>
        <form id="registerForm" action="register" method="post">
        <div style="color:red;">${isUserDuplicate}</div>
          <div class="form-group has-feedback">
            <input type="text" class="form-control required" placeholder="Username" name="username">
            <span class="form-control-feedback"></span>           
          </div>
       
          <div class="form-group has-feedback">
            <input id="password" type="password" class="form-control required" placeholder="Password" name="password">
            <span class="form-control-feedback"></span>
          </div>
          <div class="form-group has-feedback">
            <input id="passwordRetype" type="password" class="form-control required" placeholder="Retype password" >
            <span class="form-control-feedback"></span>
          </div>
          <div class="row">
            <div class="col-xs-8">
              <div class="checkbox icheck">
                <label>
                  <input type="checkbox"> I agree to the <a href="#">terms</a>
                </label>
              </div>
            </div><!-- /.col -->
            <div class="col-xs-4">
              <button type="submit" class="btn btn-primary btn-block btn-flat">注册</button>
            </div><!-- /.col -->
          </div>
        </form>
        <a href="login" class="text-center">已有账号，直接登录</a>
      </div><!-- /.form-box -->
    </div><!-- /.register-box -->

  <script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery-2.1.4.js"></script>
		<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery.validate.min.js"></script>
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
      $(document).ready(function(){
    	  $("#registerForm").validate({
    		  submitHandler:function(form){
    			  var password=$('#password').val();
        		  var passwordRetype=$('#passwordRetype').val();
        		  if(password!=passwordRetype){
        			  alert("兩次輸入的密碼不一樣");
        			  return false;
        		  }
   
    	          form.submit();
    	        }
    	       
    	  });
    	  
      });
    </script>
  </body>
</html>
