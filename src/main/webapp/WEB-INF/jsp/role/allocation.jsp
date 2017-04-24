<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="/common/header.jsp"%>
<%@ include file="/common/permission_nav.jsp"%>
<!-- Main bar -->
<div class="mainbar">
	<!-- Page heading -->
	<div class="page-head">
		<h2 class="pull-left">
			<i class="icon-home"></i> 用户角色分配
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
					        			name="findContent" id="findContent" placeholder="输入用户姓名 / 用户帐号">
					      </div>
					     <span class=""> 
				         	<button type="submit" class="btn btn-primary">查询</button>
				         </span>    
				        </div>
					<hr>
					<table class="table table-bordered">
						<input type="hidden" id="selectUserId">
						<tr>
							<th width="5%"><input type="checkbox" id="checkAll"/></th>
							<th width="10%">用户姓名</th>
							<th width="10%">手机号/帐号</th>
							<th width="10%">状态</th>
							<th width="55%">拥有的角色</th>
							<th width="10%">操作</th>
						</tr>
						<c:if test="${page != null}">
							<c:forEach items="${page.list}" var="it">  
								<tr>
									<td><input value="${it.id}" check='box' type="checkbox" /></td>
									<td>${it.nickname}</td>
									<td>${it.email}</td>
									<td>
										<c:if test="${it.status == 1 }">
											有效
										</c:if>
										<c:if test="${it.status != 1 }">
											禁止
										</c:if>
									</td>
									<td roleIds="${it.roleIds}">
										${it.roleNames}
									</td>
									<td>
										<shiro:hasPermission  name="/role/addRole2User.shtml">
											<i class="glyphicon glyphicon-share-alt"></i>
											<a href="javascript:selectRoleById(${it.id});">选择角色</a>
										</shiro:hasPermission>
									</td>
								</tr>
							
							</c:forEach>
						</c:if>
						<c:if test="${page == null}">
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

	<div class="modal fade bs-example-modal-sm"  id="selectRole" tabindex="-1" role="dialog" aria-labelledby="selectRoleLabel">
	  <div class="modal-dialog modal-sm" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="selectRoleLabel">添加角色</h4>
	      </div>
	      <div class="modal-body">
	        <form id="boxRoleForm">
	          loading...
	        </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" onclick="selectRole();" class="btn btn-primary">保存</button>
	      </div>
	    </div>
	  </div>
	</div>
	
<%@ include file="/common/script.jsp"%>
<%@ include file="/common/footer.html"%>

	<script >
		so.init(function(){
				//初始化全选。
				so.checkBoxInit('#checkAll','[check=box]');
				<shiro:hasPermission  name="/role/clearRoleByUserIds.shtml">
				//全选
				so.id('deleteAll').on('click',function(){
					var checkeds = $('[check=box]:checked');
					if(!checkeds.length){
						return layer.msg('请选择要清除的用户。',so.default),!0;
					}
					var array = [];
					checkeds.each(function(){
						array.push(this.value);
					});
					return deleteById(array);
				});
				</shiro:hasPermission>
			});
		
			<shiro:hasPermission  name="/role/clearRoleByUserIds.shtml">
			//--根据ID数组清空用户的角色-->
			function deleteById(ids){
				var index = layer.confirm("确定清除这"+ ids.length +"个用户的角色？",function(){
					var load = layer.load();
					$.post('<c:url value="/role/clearRoleByUserIds.shtml"/>',{userIds:ids.join(',')},function(result){
						layer.close(load);
						if(result && result.status != 200){
							return layer.msg(result.message,so.default),!0;
						}else{
							layer.msg(result.message);
							setTimeout(function(){
								$('#formId').submit();
							},1000);
						}
					},'json');
					layer.close(index);
				});
			}
			</shiro:hasPermission>
			
			<shiro:hasPermission  name="/role/addRole2User.shtml">
			//--选择角色后保存-->
			function selectRole(){
				var checked = $("#boxRoleForm  :checked");
				var ids=[],names=[];
				$.each(checked,function(){
					ids.push(this.id);
					names.push($.trim($(this).attr('name')));
				});
				var index = layer.confirm("确定操作？",function(){

					var load = layer.load();
					$.post('<c:url value="/role/addRole2User.shtml"/>',{ids:ids.join(','),userId:$('#selectUserId').val()},function(result){
						layer.close(load);
						if(result && result.status != 200){
							return layer.msg(result.message,so.default),!1;
						}
						layer.msg('添加成功。');
						setTimeout(function(){
							$('#formId').submit();
						},1000);
					},'json');
				});
			}
			/*
			*根据角色ID选择权限，分配权限操作。
			*/
			function selectRoleById(id){
				var load = layer.load();
				$.post('<c:url value="/role/selectRoleByUserId.shtml"/>',{id:id},function(result){
					layer.close(load);
					if(result && result.length){
						var html =[];
						$.each(result,function(){
							html.push("<div class='checkbox'><label>");
							html.push("<input type='checkbox' id='");
							html.push(this.id);
							html.push("'");
							if(this.check){
								html.push(" checked='checked'");
							}
							html.push("name='");
							html.push(this.name);
							html.push("'/>");
							html.push(this.name);
							html.push('</label></div>');
						});
						return so.id('boxRoleForm').html(html.join('')) & $('#selectRole').modal(),$('#selectUserId').val(id),!1;
					}else{
						return layer.msg('没有获取到用户数据，请先注册数据。',so.default);
					}
				},'json');
			}
			</shiro:hasPermission>
		</script>