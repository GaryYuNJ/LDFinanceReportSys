
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
			<i class="icon-home"></i> 资料修改
		</h2>
		<div class="clearfix"></div>
	</div>
	<!-- Page heading ends -->

	<!-- Matter -->
	<div class="matter">
		<div class="container">
			<div class="row">
				<div class="col-md-3">
						<form id="formId" enctype="multipart/form-data" action="<c:url value="/user/updateSelf.shtml" />"  method="post">
						  <input type="hidden" value="<shiro:principal property="id"/>" name="id"/>
						  <div class="form-group">
						    <label for="nickname">姓名</label>
						    <input type="text" class="form-control" autocomplete="off" id="nickname" maxlength="8" name="nickname" value="<shiro:principal property="nickname"/>" placeholder="请输入姓名">
						  </div>
						  <div class="form-group">
						    <label for="email">手机号/账号（不准修改）</label>
						    <input type="text" class="form-control " disabled autocomplete="off" id="mobile" maxlength="64" name="mobile" value="<shiro:principal property="mobile"/>" placeholder="">
						  </div>
						  <div class="form-group">
						    <label for="email">Email</label>
						    <input type="text" class="form-control " autocomplete="off" id="email" maxlength="64" name="email" value="<shiro:principal property="email"/>" placeholder="请输入帐号">
						  </div>
						  <div class="form-group">
							  <button type="submit" class="btn btn-success">确定修改</button>
						  </div>
				</div>
			</div>
		</div>
	</div>
</div>


<%@ include file="/common/script.jsp"%>
<%@ include file="/common/footer.html"%>

<script>
	$(function(){
		var load;
		$("#formId").ajaxForm({
	    	success:function (result){
	    		layer.close(load);
	    		if(result && result.status == 300){
	    			layer.msg(result.message,function(){});
	    			return !1;
	    		}
	    		if(result && result.status == 500){
	    			layer.msg("操作失败！",function(){});
	    			return !1;
	    		}
	    		layer.msg('操作成功！');
	    	},
	    	beforeSubmit:function(){
	    		//判断参数
	    		if($.trim($("#nickname").val()) == ''){
		    		layer.msg('姓名不能为空！',function(){});
		    		$("#nickname").parent().removeClass('has-success').addClass('has-error');
		    		return !1;
	    		}else{
	    			$("#nickname").parent().removeClass('has-error').addClass('has-success');
	    		}
	    		load = layer.load();
	    	},
	    	dataType:"json",
	    	clearForm:false
		});
	
});
</script>
