<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="uft-8">
<head>
  <meta charset="utf-8">
  <!-- Title and other stuffs -->
  <title>您已经被踢出登录</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="author" content="">
  <!-- Stylesheets -->
  <link href="<c:url value="/style/bootstrap.css" />" rel="stylesheet">
  <link href="<c:url value="/style/font-awesome.css" />" rel="stylesheet">
  <link href="<c:url value="/style/style.css" />" rel="stylesheet">
  <!-- HTML5 Support for IE -->
  <!--[if lt IE 9]>
  <script src="js/html5shim.js"></script>
  <![endif]-->
  <!-- Favicon -->
  <link rel="shortcut icon" href="<c:url value="/img/favicon/favicon.png" />">
</head>
<body data-target="#one" data-spy="scroll">
		
	<div class="container" style="padding-bottom: 15px;min-height: 300px; margin-top: 40px;">
		<div class="row">
			<div class="col-md-12">
				<h2>系统提示</h2>
				<hr>
				<p>您已经被系统踢出。请重新登录或者联系管理员！</p>
			</div>
		</div>
	</div>
			
</body>
</html>