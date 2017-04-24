<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="/common/header.jsp"%>
<%@ include file="/common/member_nav.jsp"%>
<!-- Main bar -->
<div class="mainbar">
	<!-- Page heading -->
	<div class="page-head">
		<h2 class="pull-left">
			<i class="icon-home"></i> Session详情
		</h2>
		<div class="clearfix"></div>
	</div>
	<!-- Page heading ends -->

	<!-- Matter -->
	<div class="matter">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="widget">
						<table class="table table-striped table-bordered table-hover">
							<tr>
								<th>Session Id</th>
								<td>${bo.sessionId}</td>
							</tr>
							<tr>
								<th>Session创建时间</th>
								<td>${bo.startTime}</td>
							</tr>
							<tr>
								<th>Session最后交互时间</th>
								<td>${bo.lastAccess}</td>
							</tr>
							<tr>
								<th>Session 状态</th>
								<td>
									<c:if test="${bo.sessionStatus}">
										有效
									</c:if>
									<c:if test="${!bo.sessionStatus}">
										已踢出
									</c:if>
							</tr>
							<tr>
								<th>Session Host</th>
								<td>${bo.host}</td>
							</tr>
							<tr>
								<th>Session timeout</th>
								<td>${bo.timeout}</td>
							</tr>
							<tr>
								<th>姓名</th>
								<td>${bo.nickname}</td>
							</tr>
							<tr>
								<th>手机号/帐号</th>
								<td>${bo.mobile}</td>
							</tr>
							<tr>
								<th>创建时间</th>
								<td>${bo.createTime}</td>
							</tr>
							<tr>
								<th>最后登录时间</th>
								<td>${bo.lastLoginTime}</td>
							</tr>
						</table>
					</div>
				</div>
				</div>
			</div>
		</div>
	</div>


<%@ include file="/common/script.jsp"%>
<%@ include file="/common/footer.html"%>
