<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="exampleModalLabel">用户详情</h4>
			</div>
			<div class="modal-body">
				<table  class="table table-striped">
				<tr><td>用户名:</td><td>${user.username}	</td></tr>
				<tr><td>别名:</td><td>${user.userAlias}</td></tr>
				<tr><td>角色:</td><td><c:forEach var="role" items="${user.roles}">${role.name}&nbsp;&nbsp;&nbsp;&nbsp;</c:forEach></td></tr>
				<tr><td>状态:</td><c:choose>
								<c:when test="${user.locked}">
									<td><span class="badge bg-red">锁定</span></td>
								</c:when>
								<c:otherwise>
									<td><span class="badge bg-green">未锁定</span></td>
								</c:otherwise>
							</c:choose></tr>
				<tr><td>上次登录时间:</td><td>${user.lastLoginTime}	</td></tr>
				<tr><td>创建者:</td><td>${user.creatorName}	</td></tr>
				<tr><td>创建时间:</td><td>${user.createTime}	</td></tr>
				</table>																										
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>			
			</div>