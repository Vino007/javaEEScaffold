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
				<tr><td>资源名:</td><td>${resource.name}</td></tr>
				<tr><td>权限字符串:</td><td>${resource.permission}</td></tr>
				<tr><td>类型:</td><td>${resource.type}</td></tr>
				<tr><td>排序优先级:</td><td>${resource.priority}</td></tr>
				<tr><td>菜单路径URL:</td><td>${resource.url}</td></tr>				
				<tr><td>上级资源ID:</td><td>${resource.parentId}</td></tr>
				<tr><td>状态:</td><c:choose>
								<c:when test="${resource.available}">
									<td><span class="badge bg-red">可用</span></td>
								</c:when>
								<c:otherwise>
									<td><span class="badge bg-green">不可用</span></td>
								</c:otherwise>
							</c:choose></tr>
				
				<tr><td>创建者:</td><td>${resource.creatorName}</td></tr>
				<tr><td>创建时间:</td><td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${resource.createTime}"/>	</td></tr>
				</table>																										
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>			
			</div>