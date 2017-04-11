<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<!-- Title and other stuffs -->
<title>绿地销售财务报表系统</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="author" content="">
<!-- Stylesheets -->
<link href="<c:url value="/style/bootstrap.min.css" />" rel="stylesheet">
<!-- Font awesome icon -->
<link rel="stylesheet" href="<c:url value="/style/font-awesome.css" />">
<!-- Date picker -->
<link rel="stylesheet" href="<c:url value="/style/bootstrap-datetimepicker.min.css" />">
<!-- Bootstrap toggle -->
<link href="<c:url value="/style/style.css" />" rel="stylesheet">
<link href="<c:url value="/js/themes/default/style.min.css" />" rel="stylesheet">
<link href="<c:url value="/style/bootstrap-table.min.css" />" rel="stylesheet">
<link href="<c:url value="/style/bootstrap-switch.css" />" rel="stylesheet">
<link href="<c:url value="/style/bootstrapValidator.min.css" />" rel="stylesheet">
<link href="<c:url value="/style/fileinput.min.css" />" rel="stylesheet">
<link href="<c:url value="/style/bootstrap-select.min.css" />" rel="stylesheet">
<link href="<c:url value="/style/extend_top.css" />" rel="stylesheet">


<!-- HTML5 Support for IE -->
<!--[if lt IE 9]>
  <script src="js/html5shim.js"></script>
  <![endif]-->
<!-- Favicon -->
<link rel="shortcut icon" href="<c:url value="/img/favicon/favicon.png" />">
<c:set var="rootUri" value="${pageContext.request.contextPath}" />
<script type="text/javascript">
var rootUri="${rootUri}";
</script>
</head>

<body>
	<!-- Header starts -->
	<header>
		<div class="navbar navbar-inverse navbar-fixed-top animated fadeInDown" style="z-index: 101;height: 41px;">
		      <div class="container" style="">
			     <div role="navigation" class="navbar-collapse collapse">
			     	
					<div class="login-header navbar-brand" style="width: 280px;margin-top: 3px;margin-left: 2px;"></div>
			     
			          <ul class="nav navbar-nav">
						<li class="dropdown">
							<a aria-expanded="false" aria-haspopup="true" role="button" data-toggle="dropdown" class="dropdown-toggle" href="<c:url value="/user/userInfo" />">
								个人中心<span class="caret"></span>
							</a>
							<ul class="dropdown-menu">
								<li><a href="<c:url value="/user/userInfo.shtml" />">个人资料</a></li>
								<li><a href="<c:url value="/user/updateSelf.shtml" />">资料修改</a></li>
								<li><a href="<c:url value="/user/updatePswd.shtml" />">密码修改</a></li>
								<li><a href="<c:url value="/role/mypermission.shtml" />">我的权限</a></li>
							</ul>
						</li>	  
						<li class="dropdown">
							<a aria-expanded="false" aria-haspopup="true" role="button" data-toggle="dropdown" class="dropdown-toggle" href="<c:url value="/user/userInfo" />">
								用户中心<span class="caret"></span>
							</a>
							<ul class="dropdown-menu">
								<li><a href="<c:url value="/member/list.shtml" />">用户列表</a></li>
								<li><a href="<c:url value="/member/online.shtml" />">在线用户</a></li>
							</ul>
						</li>	
						<li class="dropdown">
							<a aria-expanded="false" aria-haspopup="true" role="button" data-toggle="dropdown" class="dropdown-toggle" href="<c:url value="/user/userInfo" />">
								权限管理<span class="caret"></span>
							</a>
							<ul class="dropdown-menu">
								<li><a href="<c:url value="/role/index.shtml" />">角色列表</a></li>
								<li><a href="<c:url value="/role/allocation.shtml" />">角色分配</a></li>
								<li><a href="<c:url value="/permission/index.shtml" />">权限列表</a></li>
								<li><a href="<c:url value="/permission/allocation.shtml" />">权限分配</a></li>
							</ul>
						</li>	
			          </ul>
			          
			           <ul class="nav navbar-nav  pull-right">
						<li class="dropdown" style="color:#fff;">
							<a aria-expanded="false" aria-haspopup="true" role="button" data-toggle="dropdown"  href="<c:url value="/user/userInfo" />" class="dropdown-toggle qqlogin">
								<shiro:principal property="nickname"/> 
								<span class="caret"></span>
							</a>
							<ul class="dropdown-menu" >
								<li><a href="javascript:void(0);" onclick="logout();">退出登录</a></li>
							</ul>
						</li>	
			          </ul>
			    </div>
		  	</div>
		</div>

	</header>
	<!-- Header ends -->
