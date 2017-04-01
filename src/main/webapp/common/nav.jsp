<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    	<!-- Main content starts -->
		<div class="content">
			<!-- Sidebar -->
			<div class="sidebar">
				<div class="sidebar-dropdown">
					<a href="#">导航</a>
				</div>
				<!--- Sidebar navigation -->
				<!-- If the main navigation has sub navigation, then add the class "has_sub" to "li" of main navigation. -->
				<ul id="nav">
					<!-- Main menu with font awesome icon 
					<li>
						<a href="<c:url value="/manage/resourceManagePage" />"><i class="icon-home"></i> 首页</a>
					</li>
					-->
					<c:if test="${sessionScope.user.userRole!=null}">
					<c:if test="${sessionScope.user.userRole.roleType<=2}">
					<li class="has_sub">
						<a href="<c:url value="/manage/resourceManagePage" />"><i class="icon-list-alt"></i> 资源管理 </a>
					</li>
					<li class="has_sub">
						<a href="<c:url value="/manage/resourceGroupManagePage" />"><i class="icon-list-alt"></i> 资源组管理 </a>
					</li>
					</c:if>
					<li class="has_sub">
						<a href="<c:url value="/user/userManage" />"><i class="icon-list-alt"></i> 用户管理 </a>
					</li>
					<li class="has_sub">
						<a href="<c:url value="/userGroup/userGroupManage" />"><i class="icon-list-alt"></i> 用户组管理 </a>
					</li>
					<c:if test="${sessionScope.user.userRole.roleType==1}">
						<li class="has_sub">
							<a href="<c:url value="/admin/roleManagePage" />"><i class="icon-list-alt"></i> 角色管理 </a>
						</li>
						<li class="has_sub">
							<a href="<c:url value="/admin/backendUserManage" />"><i class="icon-list-alt"></i> 管理员管理 </a>
						</li>
						<li class="has_sub">
							<a href="<c:url value="/admin/buildingManagePage" />"><i class="icon-list-alt"></i> 楼栋管理 </a>
						</li>
					</c:if>
					</c:if>
			</div>
			<!-- Sidebar ends -->