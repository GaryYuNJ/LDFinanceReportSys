package com.ld.core.tags;

import static freemarker.template.ObjectWrapper.DEFAULT_WRAPPER;

import java.util.HashMap;
import java.util.Map;

import com.ld.common.utils.LoggerUtils;
import com.ld.common.utils.SpringContextUtil;
import com.ld.core.statics.Constant;

import freemarker.template.TemplateModel;
import freemarker.template.TemplateModelException;

/**
 * 
 * 开发公司：在线工具 <p>
 * 版权所有：© <p>
 * 博客地址：http:///blog/  <p>
 * <p>
 * 
 * Freemarker 自定义标签 API公共入口
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

public class APITemplateModel extends WYFTemplateModel {

	@Override
	@SuppressWarnings({  "unchecked" })
	protected Map<String, TemplateModel> putValue(Map params)
			throws TemplateModelException {
		
		Map<String, TemplateModel> paramWrap = null ;
		if(null != params && params.size() != 0 || null != params.get(Constant.TARGET)){
			String name =  params.get(Constant.TARGET).toString() ;
			paramWrap = new HashMap<String, TemplateModel>(params);
			
			/**
			 * 获取子类，用父类接收，
			 */
			SuperCustomTag tag =  SpringContextUtil.getBean(name,SuperCustomTag.class);
			//父类调用子类方法
			Object result = tag.result(params);
			
			//输出
			paramWrap.put(Constant.OUT_TAG_NAME, DEFAULT_WRAPPER.wrap(result));
		}else{
			LoggerUtils.error(getClass(), "Cannot be null, must include a 'name' attribute!");
		}
		return paramWrap;
	}

	
	
	
	
	
}
