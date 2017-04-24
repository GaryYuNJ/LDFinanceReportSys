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
			<i class="icon-home"></i> 当前在线用户
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
						<form method="post" action="" id="formId" class="form-inline">
							<div class="well">
						      <div class="form-group">
						        <input type="text" class="form-control" style="width: 300px;" value="${findContent}" 
						        			name="findContent" id="findContent" placeholder="输入昵称 / 帐号">
						      </div>
						     <span class="">
					         	<button type="submit" class="btn btn-primary">查询</button>
					         </span>    
					        </div>
							<table class="table table-striped table-bordered table-hover">
								<tr>
									<th>SessionID</th>
									<th>昵称</th>
									<th>手机号/帐号</th>
									<th>创建回话</th>
									<th>回话最后活动</th>
									<th>状态</th>
									<th>操作</th>
								</tr>
								<c:forEach items="${list}" var="it">  
									<tr>
										<td>${it.sessionId}</td>
										<td>${it.nickname}</td>
										<td>${it.mobile}</td>
										<td>${it.startTime}</td>
										<td>${it.lastAccess}</td>
										<td>
											<c:if test="${it.sessionStatus }">
												有效
											</c:if>
											<c:if test="${!it.sessionStatus}">
												已踢出
											</c:if>
										</td>
										<td>
											<a href='<c:url value="/member/onlineDetails/${it.sessionId}.shtml" />'>详情</a>
											<shiro:hasPermission name="/member/changeSessionStatus.shtml">
												<a v="onlineDetails"href="javascript:void(0);" 
												sessionId="${it.sessionId}" 
												status="${it.sessionStatus}">
													<c:if test="${it.sessionStatus}">
														踢出
													</c:if>
													<c:if test="${!it.sessionStatus}">
														激活
													</c:if>
												</a>
											</shiro:hasPermission>
											
										</td>
									</tr>
								</c:forEach>
								<c:if test="${list eq null}">
									<tr>
										<td class="text-center danger" colspan="7">没有找到用户</td>
									</tr>
								</c:if>
							</table>
						</form>
					</div>
				</div>
				</div>
			</div>
		</div>
	</div>


<%@ include file="/common/script.jsp"%>
<%@ include file="/common/footer.html"%>

<script >
	<shiro:hasPermission  name="/member/changeSessionStatus.shtml">
		$(function(){
			$("a[v=onlineDetails]").on('click',function(){
				var self = $(this);
				var text = $.trim(self.text());
				var index = layer.confirm("确定"+ text +"？",function(){
					changeSessionStatus(self.attr('sessionId'),self.attr('status'),self);
					layer.close(index);
				});
			});
		});
		
		//改变状态
		function changeSessionStatus(sessionIds,status,self){
			//status = !parseInt(status);
			status = !status;
			//loading
			var load = layer.load();
			$.post('<c:url value="/member/changeSessionStatus.shtml" />',{status:status,sessionIds:sessionIds},function(result){
				layer.close(load);
				if(result && result.status == 200){
					return self.text(result.sessionStatusText),
								self.attr('status',result.sessionStatus),
									self.parent().prev().text(result.sessionStatusTextTd);
									layer.msg('操作成功'),!1;
				}else{
					return layer.msg(result.message,function(){}),!1;
				}		
			},'json');
		}
	</shiro:hasPermission>
</script>