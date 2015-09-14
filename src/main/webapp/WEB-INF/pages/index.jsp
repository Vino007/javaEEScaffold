<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="vino" uri="http://www.vino007.com/pager" %> 
<html>
<head>
<%@ include file="/WEB-INF/pages/common/default_css.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>分页测试</title>
</head>
<body>
<shiro:guest>
    欢迎游客访问，<a href="${pageContext.request.contextPath}/login">点击登录</a><br/>
</shiro:guest>

<shiro:user>
    欢迎[<shiro:principal/>]登录，<a href="${pageContext.request.contextPath}/logout">点击退出</a><br/>
</shiro:user>

<%-- <div class="ui-layout-west">
    功能菜单<br/>
    <c:forEach items="${menus}" var="m">
        <a href="${pageContext.request.contextPath}/${m.url}" target="content">${m.name}</a><br/>
    </c:forEach>
</div>
 --%>
<div class="ui-layout-west">
    权限菜单<br/>
    <c:forEach items="${permissionList}" var="permission">
       ${permission}<br/>
    </c:forEach>
</div>

 <c:forEach items="${permissions}" var="permission">
       ${permission.name}<br/>
    </c:forEach>
    
    
<%-- <vino:pager type="form" action="${pageContext.request.contextPath}/permission/view"/> --%>

<%@ include file="/WEB-INF/pages/common/default_js.jsp" %>
<script type="text/javascript">
/* 	$(document).click(function(e){
		$(e.target).addClass("active");
	}); */
</script>
</body>
</html>
