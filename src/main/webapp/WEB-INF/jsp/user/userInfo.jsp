<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="/common/header.jsp"%>
<%@ include file="/common/user_nav.jsp"%>
<!-- Main bar -->
<div class="mainbar">
	<!-- Page heading -->
	<div class="page-head">
		<h2 class="pull-left">
			<i class="icon-home"></i> 个人资料
		</h2>
		<div class="clearfix"></div>
	</div>
	<!-- Page heading ends -->

	<!-- Matter -->
	<div class="matter">
		<div class="container">
			<div class="row">
				<div class="col-md-10">
					<div class="widget">
						<table class="table table-striped table-bordered table-hover">
							<tr>
								<th>姓名</th>
								<td><shiro:principal property="nickname"/></td>
							</tr>
							<tr>
								<th>手机号/账号</th>
								<td><shiro:principal property="mobile"/></td>
							</tr>
							<tr>
								<th>Email</th>
								<td><shiro:principal property="email"/></td>
							</tr>
							<tr>
								<th>创建时间</th>
								<td>
									<fmt:formatDate type="both"  dateStyle="medium" timeStyle="medium" value="${createTime }" />
								</td>
							</tr>
							<tr>
								<th>最后登录时间</th>
								<td>
									<fmt:formatDate type="both"  dateStyle="medium" timeStyle="medium" value="${lastLoginTime }" />
								</td>
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
