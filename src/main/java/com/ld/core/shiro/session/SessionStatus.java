package com.ld.core.shiro.session;

import java.io.Serializable;

/**
 * 
 * 开发公司：在线工具 <p>
 * 版权所有：© <p>
 * 博客地址：http:///blog/  <p>
 * <p>
 * 
 * Session 状态 VO
 * 
 * <p>
 * 
 * 区分　责任人　日期　　　　说明<br/>
 * 2016年6月2日 　<br/>
 *
 * @author 
 *   
 * @version 1.0,2016年6月2日 <br/>
 * 
 */
public class SessionStatus implements Serializable {
	private static final long serialVersionUID = 1L;

	//是否踢出 true:有效，false：踢出。
	private Boolean onlineStatus = Boolean.TRUE;

	
	public Boolean isOnlineStatus(){
		return onlineStatus;
	}

	public Boolean getOnlineStatus() {
		return onlineStatus;
	}
	public void setOnlineStatus(Boolean onlineStatus) {
		this.onlineStatus = onlineStatus;
	}
	
	
}
