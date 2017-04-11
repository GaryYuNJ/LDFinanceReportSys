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
			<i class="icon-home"></i> 用户列表
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
									<th>昵称</th>
									<th>手机号/帐号</th>
									<th>登录状态</th>
									<th>创建时间</th>
									<th>最后登录时间</th>
									<th>操作</th>
								</tr>
								<c:forEach items="${page.list}" var="it">  
									<tr>
										<!-- <td><input value="${it.id}" check='box' type="checkbox" /></td> -->
										<td>${it.nickname}</td>
										<td>${it.mobile}</td>
										<td>
											<c:if test="${it.status == 1 }">
												有效
											</c:if>
											<c:if test="${it.status != 1 }">
												禁止
											</c:if>
										</td>
										<td>${it.createTime}</td>
										<td>${it.lastLoginTime}</td>
										<td>
											<c:if test="${it.mobile != 'admin' and it.mobile != 'superadmin' }">
												<shiro:hasPermission name="/member/forbidUserById.shtml">
													<c:if test="${it.status == 1 }">
														<i class="glyphicon glyphicon-eye-close"></i>&nbsp;
													</c:if>
													<c:if test="${it.status != 1 }">
														<i class="glyphicon glyphicon-eye-open"></i>&nbsp;
													</c:if>
													<a href="javascript:forbidUserById('${it.status}','${it.id}')">
														<c:if test="${it.status == 1 }">
														禁止登录
													</c:if>
													<c:if test="${it.status != 1 }">
														激活登录
													</c:if>
													</a>
												</shiro:hasPermission>
												<shiro:hasPermission name="/member/deleteUserById.shtml">
													<a href="javascript:_delete([${it.id}]);">删除</a>
												</shiro:hasPermission>
											</c:if>
											
										</td>
									</tr>
								</c:forEach>
								<c:if test="${page eq null}">
									<tr>
										<td class="text-center danger" colspan="6">没有找到用户</td>
									</tr>
								</c:if>
							</table>
							<c:if test="${page != null}">
								<div class="pagination pull-right">
									${page.pageHtml}
								</div>
							</c:if>
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
			so.init(function(){
				//初始化全选。
				//so.checkBoxInit('#checkAll','[check=box]');
				<shiro:hasPermission name="/member/deleteUserById.shtml">
				//全选
				so.id('deleteAll').on('click',function(){
					var checkeds = $('[check=box]:checked');
					if(!checkeds.length){
						return layer.msg('请选择要删除的选项。',so.default),!0;
					}
					var array = [];
					checkeds.each(function(){
						array.push(this.value);
					});
					return _delete(array);
				});
				</shiro:hasPermission>
			});
			
			<shiro:hasPermission name="/member/deleteUserById.shtml">
			//根据ID数组，删除
			function _delete(ids){
				var index = layer.confirm("确定要删除这个用户？",function(){
					var load = layer.load();
					$.post('<c:url value="/member/deleteUserById.shtml"/>',{ids:ids.join(',')},function(result){
						layer.close(load);
						if(result && result.status != 200){
							return layer.msg(result.message,so.default),!0;
						}else{
							layer.msg('删除成功');
							setTimeout(function(){
								$('#formId').submit();
							},1000);
						}
					},'json');
					layer.close(index);
				});
			}
			</shiro:hasPermission>
			
			
			<shiro:hasPermission name="/member/forbidUserById.shtml">
			/*
			*激活 | 禁止用户登录
			*/
			function forbidUserById(status,id){
				if(status == 1){
					status = 0;
				}else{
					status = 1;
				}
				var text = status?'激活':'禁止';
				var index = layer.confirm("确定"+text+"这个用户？",function(){
					var load = layer.load();
					$.post('<c:url value="/member/forbidUserById.shtml"/>',{status:status,id:id},function(result){
						layer.close(load);
						if(result && result.status != 200){
							return layer.msg(result.message,so.default),!0;
						}else{
							layer.msg(text +'成功');
							setTimeout(function(){
								$('#formId').submit();
							},1000);
						}
					},'json');
					layer.close(index);
				});
			}
			</shiro:hasPermission>
		</script>