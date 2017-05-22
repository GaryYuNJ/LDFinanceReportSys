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
			<i class="icon-home"></i> 权限分配
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
						<div clss="well">
					      <div class="form-group">
					        <input type="text" class="form-control" style="width: 300px;" value="${findContent}" 
					        			name="findContent" id="findContent" placeholder="输入角色名称 / 角色类型">
					      </div>
					     <span class=""> 
				         	<button type="submit" class="btn btn-primary">查询</button>
				         	<shiro:hasPermission  name="/permission/clearPermissionByRoleIds.shtml">
				         		<button type="button" id="deleteAll" class="btn  btn-danger">清空角色权限</button>
				         	</shiro:hasPermission>
				         </span>    
				        </div>
					<hr>
					<table class="table table-bordered">
						<input type="hidden" id="selectRoleId">
						<tr>
							<th width="10%">角色名称</th>
							<th width="10%">角色类型</th>
							<th width="60%">拥有的权限</th>
							<th width="15%">操作</th>
						</tr>
						<c:if test="${page != null}">
							<c:forEach items="${page.list}" var="it">  
								<tr>
									<td>${it.name}</td>
									<td>${it.code}</td>
									<td permissionIds="${it.permissionIds}">
										${it.permissionNames}
									</td>
									<td>
										<shiro:hasPermission  name="/permission/addPermission2Role.shtml">
											<i class="glyphicon glyphicon-share-alt"></i>
											<a href="javascript:selectPermissionById(${it.id});">选择权限</a>
										</shiro:hasPermission>
									</td>
								</tr>
							</c:forEach>
						</c:if>
								
						<c:if test="${page == null}">
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

	<div class="modal fade bs-example-modal-sm"  id="selectPermission" tabindex="-1" role="dialog" aria-labelledby="selectPermissionLabel">
	  <div class="modal-dialog modal-sm" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="selectPermissionLabel">添加权限</h4>
	      </div>
	      <div class="modal-body">
	        <form id="boxRoleForm">
	          loading...
	        </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" onclick="selectPermission();" class="btn btn-primary">保存</button>
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
			<shiro:hasPermission  name="/permission/clearPermissionByRoleIds.shtml">
			//全选
			so.id('deleteAll').on('click',function(){
				var checkeds = $('[check=box]:checked');
				if(!checkeds.length){
					return layer.msg('请选择要清除的角色。',so.default),!0;
				}
				var array = [];
				checkeds.each(function(){
					array.push(this.value);
				});
				return deleteById(array);
			});
			</shiro:hasPermission>
		});
		<shiro:hasPermission  name="/permission/clearPermissionByRoleIds.shtml">
		//--根据ID数组清空角色的权限-->
		function deleteById(ids){
			var index = layer.confirm("确定清除这"+ ids.length +"个角色的权限？",function(){
				var load = layer.load();
				$.post('${rootUri}/permission/clearPermissionByRoleIds.shtml',{roleIds:ids.join(',')},function(result){
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
		<shiro:hasPermission  name="/permission/addPermission2Role.shtml">
		//--选择权限后保存-->
		function selectPermission(){
			var checked = $("#boxRoleForm  :checked");
			var ids=[],names=[];
			$.each(checked,function(){
				ids.push(this.id);
				names.push($.trim($(this).attr('name')));
			});
			var index = layer.confirm("确定操作？",function(){
				var load = layer.load();
				$.post('${rootUri}/permission/addPermission2Role.shtml',{ids:ids.join(','),roleId:$('#selectRoleId').val()},function(result){
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
		function selectPermissionById(id){
			var load = layer.load();
			$.post("${rootUri}/permission/selectPermissionById.shtml",{id:id},function(result){
				layer.close(load);
				if(result && result.length){
					var html =[];
					html.push('<div class="checkbox"><label><input type="checkbox"  selectAllBox="">全选</label></div>');
					$.each(result,function(){
						html.push("<div class='checkbox'><label>");
						html.push("<input type='checkbox' selectBox='' id='");
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
					//初始化全选。
					return so.id('boxRoleForm').html(html.join('')),
					so.checkBoxInit('[selectAllBox]','[selectBox]'),
					$('#selectPermission').modal(),$('#selectRoleId').val(id),!1;
				}else{
					return layer.msg('没有获取到权限数据，请先添加权限数据。',so.default);
				}
			},'json');
		}
		</shiro:hasPermission>
	</script>