<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<title>登录</title>
<style>
.error {
	color: red;
}
</style>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/AdminLTE/dist/css/font-awesome.min.css"/>
<!-- Ionicons -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/AdminLTE/dist/css/ionicons.min.css"/>
 <!-- Theme style -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/AdminLTE/dist/css/AdminLTE.min.css"/>
 
<base href="<%=basePath%>">
</head>
<body>

	<div class="error">${error}</div>
	
	<form action="" method="post">
    用户名：<input type="text" name="username" value="<shiro:principal/>"><br/>
    密&nbsp;&nbsp;&nbsp;&nbsp;码：<input type="password" name="password"><br/>
    自动登录：<input type="checkbox" name="rememberMe" value="true"><br/>
    <input type="submit" value="登录">
	</form>

</body>
</html>