<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="vino" uri="http://www.vino007.com/pager" %> 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
<base href="<%=basePath%>"> 
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
    
<h2>树形菜单显示role</h2>
<div>
	<ul id="tree" class="ztree"></ul>
	<button id="getRoles">role/all</button>
</div>
<%-- <vino:pager type="form" action="${pageContext.request.contextPath}/permission/view"/> --%>

<%@ include file="/WEB-INF/pages/common/default_js.jsp" %>
<script type="text/javascript">

	
    var setting = {  
	        isSimpleData : true,              //数据是否采用简单 Array 格式，默认false  
	        treeNodeKey : "id",               //在isSimpleData格式下，当前节点id属性  
	        treeNodeParentKey : "pId",        //在isSimpleData格式下，当前节点的父节点id属性  
	        showLine : true,                  //是否显示节点间的连线  
	        checkable : true                  //每个节点上是否显示 CheckBox  
	    };  
	      
	    var zNodes;  
	   $(document).ready(function(){  
	    $("#getRoles").click(function(){
	        $.ajax({  
	            async : false,  
	            cache:false,  
	            type: 'GET',  
	        //    contentType : 'application/json',  //发送信息至服务器时内容编码类型
	            dataType : "json",  
	            url: "role/all",//请求的action路径  
	            error: function () {//请求失败处理函数  
	                alert('请求失败');  
	            },  
	            success:function(data){ //请求成功后处理函数。    
	                alert(data);  
	                zNodes = data;   //把后台封装好的简单Json格式赋给treeNodes  
	            }  
	        });  
	      
	       $.fn.zTree.init($("#tree"), setting, zNodes);
	    }); 
	   });
</script>
</body>
</html>
