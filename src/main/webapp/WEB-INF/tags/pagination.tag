<%@tag pageEncoding="UTF-8"%>
<%@ attribute name="page" type="org.springframework.data.domain.Page" required="true" description="page对象，从controller获取"%>
<%@ attribute name="paginationSize" type="java.lang.Integer" required="true" description="pagination中间要显示几个页码"%> 
<%@ attribute name="action" type="java.lang.String" required="true" description="分页请求的action"%>
<%@ attribute name="contentSelector" type="java.lang.String" required="true" description="selector用来筛选响应所填充的目标元素" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
int current =  page.getNumber() + 1;
int begin = Math.max(1, current - paginationSize/2);
int end = Math.min(begin + (paginationSize - 1), page.getTotalPages());

request.setAttribute("current", current);
request.setAttribute("begin", begin);
request.setAttribute("end", end);
request.setAttribute("action", action);
request.setAttribute("contentSelector", contentSelector);
%>

<div id="pagination" class="box-footer clearfix">
	<ul class="pagination pagination-sm no-margin pull-right">
		 <% if (page.hasPrevious()){%>
               	<li><a href="${action}?pageNumber=1&${searchParams}">首页</a></li>
                <li><a href="${action}?pageNumber=${current-1}&${searchParams}">&laquo;</a></li>
         <%}else{%>
                <li class="disabled"><a href="#">首页</a></li>
                <li class="disabled"><a href="#">&laquo;</a></li>
         <%} %>
 
		<c:forEach var="i" begin="${begin}" end="${end}">
            <c:choose>
                <c:when test="${i == current}">
                    <li class="active"><a href="?pageNumber=${i}&${searchParams}">${i}</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="${action}?pageNumber=${i}&${searchParams}">${i}</a></li>
                </c:otherwise>
            </c:choose>
        </c:forEach>
	  
	  	 <% if (page.hasNext()){%>
               	<li><a href="${action}?pageNumber=${current+1}&${searchParams}">&raquo;</a></li>
                <li><a href="${action}?pageNumber=${page.totalPages}&${searchParams}">尾页</a></li>
         <%}else{%>
                <li class="disabled"><a href="#">&raquo;</a></li>
                <li class="disabled"><a href="#">尾页;</a></li>
         <%} %>

	</ul>
</div>

<script type="text/javascript">
$(document).ready(function(){
	 $("#pagination li a").click(function(){
		 if($(this).parent().hasClass("disabled")){//禁止分页控件点击disable的按钮导致发送ajax请求
			 return ;
		 }
			
		 $.ajax({
            async : false,
            cache:false,
            type: 'GET',            
            url: this.href,//请求的action路径
            error: function () {//请求失败处理函数
                alert('请求失败');
            },
            success:function(data){ //请求成功后处理函数。          
            $("${contentSelector}").html(data);
                   
            }
	 });
	 return false;       		
 	});
 	});
 	
</script>	


