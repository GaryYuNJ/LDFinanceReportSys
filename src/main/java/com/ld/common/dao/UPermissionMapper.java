package com.ld.common.dao;

import java.util.List;
import java.util.Set;

import com.ld.common.model.UPermission;
import com.ld.permission.bo.UPermissionBo;

public interface UPermissionMapper {
    int deleteByPrimaryKey(Long id);

    int insert(UPermission record);

    int insertSelective(UPermission record);

    UPermission selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(UPermission record);

    int updateByPrimaryKey(UPermission record);

	List<UPermissionBo> selectPermissionByRoleId(Long roleId);
	
	//根据用户ID获取权限的Set集合
	Set<String> findPermissionByUserId(Long id);
}