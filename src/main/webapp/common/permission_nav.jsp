<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    	<!-- Main content starts -->
		<div class="content">
			<!-- Sidebar -->
			<div class="sidebar">
				<!--- Sidebar navigation -->
				<!-- If the main navigation has sub navigation, then add the class "has_sub" to "li" of main navigation. -->
				<ul id="nav">
					<li class="has_sub">
						<a href="<c:url value="/role/index.shtml" />"><i class="icon-list-alt"></i> 角色列表 </a>
					</li>
					<li class="has_sub">
						<a href="<c:url value="/role/allocation.shtml" />"><i class="icon-list-alt"></i> 角色分配 </a>
					</li>
					<li class="has_sub">
						<a href="<c:url value="/permission/index.shtml" />"><i class="icon-list-alt"></i> 权限列表 </a>
					</li>
					<li class="has_sub">
						<a href="<c:url value="/permission/allocation.shtml" />"><i class="icon-list-alt"></i> 权限分配 </a>
					</li>
			</div>
			<!-- Sidebar ends -->