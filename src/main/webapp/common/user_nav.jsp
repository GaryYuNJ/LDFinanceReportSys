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
						<a href="<c:url value="/user/userInfo.shtml" />"><i class="icon-list-alt"></i> 个人资料 </a>
					</li>
					<li class="has_sub">
						<a href="<c:url value="/user/updateSelf.shtml" />"><i class="icon-list-alt"></i> 资料修改 </a>
					</li>
					<li class="has_sub">
						<a href="<c:url value="/user/updatePswd.shtml" />"><i class="icon-list-alt"></i> 密码修改</a>
					</li>
					<li class="has_sub">
						<a href="<c:url value="/role/mypermission.shtml" />"><i class="icon-list-alt"></i> 我的权限 </a>
					</li>
			</div>
			<!-- Sidebar ends -->