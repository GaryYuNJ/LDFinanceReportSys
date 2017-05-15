package com.ld.common.dao;

import com.ld.common.model.UAppointments;

public interface UAppointmentsMapper {
    int deleteByPrimaryKey(Long id);

    int insert(UAppointments record);

    int insertSelective(UAppointments record);

    UAppointments selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(UAppointments record);

    int updateByPrimaryKey(UAppointments record);
}