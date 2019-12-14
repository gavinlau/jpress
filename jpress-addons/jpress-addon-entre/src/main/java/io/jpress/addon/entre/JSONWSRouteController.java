package io.jpress.addon.entre;

import com.alibaba.fastjson.JSONObject;
import io.jboot.utils.StrUtil;
import io.jboot.web.controller.annotation.RequestMapping;
import io.jpress.web.base.ControllerBase;
@RequestMapping("/api/jsonws")
public class JSONWSRouteController extends ControllerBase {
	public void invoke() {
	     String authorization=getRequest().getHeader("Authorization");
	     JSONObject json=ZUtils.parseLiferayJSONWSRequest(getRawData());
	     String actionUrl=json.getString("_cmd");
	     if(StrUtil.isNotBlank(actionUrl)) {
	    	 setAttr("rawData",getRawData());
	    	 forwardAction("/api/jsonws"+actionUrl);
	    	 return;
	     }
	     renderFailJson();
	}
}
