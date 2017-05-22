package com.ld.common.model;

import java.io.Serializable;
import java.math.BigDecimal;

public class UAppointments  implements Serializable{
	private static final long serialVersionUID = 1L;
    private Long id;

    private String name;

    private Long commissionFlag;

    private BigDecimal commissionRatio;

    private Long commiCalcuMethod;

    private Long houseRelation;

    private Long parentId;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public Long getCommissionFlag() {
        return commissionFlag;
    }

    public void setCommissionFlag(Long commissionFlag) {
        this.commissionFlag = commissionFlag;
    }

    public BigDecimal getCommissionRatio() {
        return commissionRatio;
    }

    public void setCommissionRatio(BigDecimal commissionRatio) {
        this.commissionRatio = commissionRatio;
    }

    public Long getCommiCalcuMethod() {
        return commiCalcuMethod;
    }

    public void setCommiCalcuMethod(Long commiCalcuMethod) {
        this.commiCalcuMethod = commiCalcuMethod;
    }

    public Long getHouseRelation() {
        return houseRelation;
    }

    public void setHouseRelation(Long houseRelation) {
        this.houseRelation = houseRelation;
    }

    public Long getParentId() {
        return parentId;
    }

    public void setParentId(Long parentId) {
        this.parentId = parentId;
    }
}