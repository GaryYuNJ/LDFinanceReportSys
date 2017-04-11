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
			<i class="icon-home"></i> 权限列表
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
						<form method="post" action="" id="formId" class="form-inline">
						<div class="well">
					      <div class="form-group">
					        <input type="text" class="form-control" style="width: 300px;" value="${findContent}" 
					        			name="findContent" id="findContent" placeholder="输入权限名称">
					      </div>
					     <span class=""> 
				         	<button type="submit" class="btn btn-primary">查询</button>
				         </span>    
				        </div>
					
					<table class="table table-striped table-bordered table-hover">
						<tr>
							<th>权限名称</th>
							<th>角色类型</th>
						</tr>
						<c:if test="${page != null}">
							<c:forEach items="${page.list}" var="it">  
								<tr>
									<td>${it.name}</td>
									<td>${it.url}</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${page eq null}">
							<tr>
								<td class="text-center danger" colspan="4">没有找到角色</td>
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

<shiro:hasPermission  name="/permission/addPermission.shtml">
			<div class="modal fade" id="addPermission" tabindex="-1" role="dialog" aria-labelledby="addPermissionLabel">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="addPermissionLabel">添加权限</h4>
			      </div>
			      <div class="modal-body">
			        <form id="boxRoleForm">
			          <div class="form-group">
			            <label for="recipient-name" class="control-label">权限名称:</label>
			            <input type="text" class="form-control" name="name" id="name" placeholder="请输入权限名称"/>
			          </div>
			          <div class="form-group">
			            <label for="recipient-name" class="control-label">权限URL地址:</label>
			            <input type="text" class="form-control" id="url" name="url"  placeholder="请输入权限URL地址">
			          </div>
			        </form>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			        <button type="button" onclick="addPermission();" class="btn btn-primary">保存</button>
			      </div>
			    </div>
			  </div>
			</div>
			</shiro:hasPermission>

<%@ include file="/common/script.jsp"%>
<%@ include file="/common/footer.html"%>

	<script >
			so.init(function(){
				//初始化全选。
				so.checkBoxInit('#checkAll','[check=box]');
				<shiro:hasPermission  name="/permission/deletePermissionById.shtml">
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
					return deleteById(array);
				});
				</shiro:hasPermission>
			});
			<shiro:hasPermission  name="/permission/deletePermissionById.shtml">
			
			
			//--根据ID数组删除角色-->
			function deleteById(ids){
				var index = layer.confirm("确定这"+ ids.length +"个权限？",function(){
					var load = layer.load();
					$.post('${rootUri}/permission/deletePermissionById.shtml',{ids:ids.join(',')},function(result){
						layer.close(load);
						if(result && result.status != 200){
							return layer.msg(result.message,so.default),!0;
						}else{
							layer.msg(result.resultMsg);
							setTimeout(function(){
								$('#formId').submit();
							},1000);
						}
					},'json');
					layer.close(index);
				});
			}
			</shiro:hasPermission>
			
			<shiro:hasPermission  name="/permission/addPermission.shtml">
			//--添加权限-->
			function addPermission(){
				var name = $('#name').val(),
					url  = $('#url').val();
				if($.trim(name) == ''){
					return layer.msg('权限名称不能为空。',so.default),!1;
				}
				if($.trim(url) == ''){
					return layer.msg('权限Url不能为空。',so.default),!1;
				}
				<#--loding-->
				var load = layer.load();
				$.post('${rootUri}/permission/addPermission.shtml',{name:name,url:url},function(result){
					layer.close(load);
					if(result && result.status != 200){
						return layer.msg(result.message,so.default),!1;
					}
					layer.msg('添加成功。');
					setTimeout(function(){
						$('#formId').submit();
					},1000);
				},'json');
			}
			</shiro:hasPermission>
		</script>
</script>