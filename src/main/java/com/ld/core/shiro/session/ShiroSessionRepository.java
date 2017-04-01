package com.ld.core.shiro.session;

import org.apache.shiro.session.Session;

import java.io.Serializable;
import java.util.Collection;

/**
 * 
 * 开发公司：在线工具 <p>
 * 版权所有：© <p>
 * 博客地址：http:///blog/  <p>
 * <p>
 * 
 * Session操作
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
public interface ShiroSessionRepository {

	/**
	 * 存储Session
	 * @param session
	 */
    void saveSession(Session session);
    /**
     * 删除session
     * @param sessionId
     */
    void deleteSession(Serializable sessionId);
    /**
     * 获取session
     * @param sessionId
     * @return
     */
    Session getSession(Serializable sessionId);
    /**
     * 获取所有sessoin
     * @return
     */
    Collection<Session> getAllSessions();
}
