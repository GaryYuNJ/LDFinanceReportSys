package com.ld.common.model;

import java.io.Serializable;
import java.util.LinkedList;
import java.util.List;

import net.sf.json.JSONObject;
/**
 * 
 * 
 * 
 * <p>
 * 
 * 权限角色
 * 
 * <p>
 * 
 * 区分　责任人　日期　　　　说明<br/>
 * 2016年5月25日 　<br/>
 * <p>
 * *******
 * <p>
 * @author 
 *   
 * @version 1.0,2016年5月25日 <br/>
 * 
 */
public class URole  implements Serializable{
	private static final long serialVersionUID = 1L;
    private Long id;
    /**角色名称*/
    private String name;
    /**角色类型*/
    private String code;
    
    private Long appointmentId;
    //***做 role --> permission 一对多处理
    private List<UPermission> permissions = new LinkedList<UPermission>();
    
    private UAppointments appointment;
    
    
	public Long getAppointmentId() {
		return appointmentId;
	}

	public void setAppointmentId(Long appointmentId) {
		this.appointmentId = appointmentId;
	}

	public UAppointments getAppointment() {
		return appointment;
	}

	public void setAppointment(UAppointments appointment) {
		this.appointment = appointment;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

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
        this.name = name;
    }

    public List<UPermission> getPermissions() {
		return permissions;
	}

	public void setPermissions(List<UPermission> permissions) {
		this.permissions = permissions;
	}

    public String toString(){
    	return JSONObject.fromObject(this).toString();
    }
}