package com.ld.common.dao;

import java.util.List;
import java.util.Map;

import com.ld.common.model.UUser;
import com.ld.permission.bo.URoleBo;

public interface UUserMapper {
    int deleteByPrimaryKey(Long id);

    int insert(UUser record);

    int insertSelective(UUser record);

    UUser selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(UUser record);

    int updateByPrimaryKey(UUser record);

	UUser checklogin(Map<String, Object> map);

	UUser findUserByMobile(String mobile);
	
	UUser findUserByEmail(String email);

	List<URoleBo> selectRoleByUserId(Long id);

}