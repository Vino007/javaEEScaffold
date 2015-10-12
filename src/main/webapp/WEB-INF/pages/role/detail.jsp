<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="exampleModalLabel">角色详情</h4>
			</div>
			<div class="modal-body">
				<table  class="table table-striped">
				<tr><td>用户名:</td><td>${role.name}	</td></tr>
				<tr><td>描述:</td><td>${role.description}</td></tr>
				<tr><td>资源:</td><td><c:forEach var="resource" items="${role.resources}">${resource.name}&nbsp;&nbsp;&nbsp;&nbsp;</c:forEach></td></tr>
				<tr><td>状态:</td><c:choose>
								<c:when test="${role.available}">
									<td><span class="badge bg-red">可用</span></td>
								</c:when>
								<c:otherwise>
									<td><span class="badge bg-green">不可用</span></td>
								</c:otherwise>
							</c:choose></tr>
				
				<tr><td>创建者:</td><td>${role.creatorId}	</td></tr>
				<tr><td>创建时间:</td><td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${role.createTime}"/>	</td></tr>
				</table>																										
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>			
			</div>