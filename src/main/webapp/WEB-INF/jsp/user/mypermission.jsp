<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/common/header.jsp"%>
<%@ include file="/common/user_nav.jsp"%>
<!-- Main bar -->
<div class="mainbar">
	<!-- Page heading -->
	<div class="page-head">
		<h2 class="pull-left">
			<i class="icon-home"></i> 我的权限
		</h2>
		<div class="clearfix"></div>
	</div>
	<!-- Page heading ends -->

	<!-- Matter -->
	<div class="matter">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div id="getPermissionTree" >loding... ...</div>
				</div>
			</div>
		</div>
	</div>
	
</div>

<%@ include file="/common/script.jsp"%>
<%@ include file="/common/footer.html"%>

<script >
	$(function(){
		//加载 permission tree data
		var load = layer.load();
		$.post("getPermissionTree.shtml",{},function(data){
			layer.close(load);
			if(data && !data.length){
				return $("#getPermissionTree").html('<code>您没有任何权限。只有默认的个人中心。</code>'),!1;
			}
			$('#getPermissionTree').treeview({
	          levels: 1,//层级
	          color: "#428bca",
	          nodeIcon: "glyphicon glyphicon-user",
	          showTags: true,//显示数量
	          data: data//数据
	        });
		},'json');
	});
</script>