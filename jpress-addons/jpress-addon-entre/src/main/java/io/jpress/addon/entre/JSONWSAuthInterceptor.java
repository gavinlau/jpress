package io.jpress.addon.entre;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jfinal.aop.Inject;
import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;
import com.jfinal.kit.HashKit;
import com.jfinal.kit.Ret;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;


import io.jboot.utils.StrUtil;
import io.jboot.web.controller.JbootController;
import io.jpress.JPressConsts;
import io.jpress.JPressOptions;
import io.jpress.service.UserService;

public class JSONWSAuthInterceptor implements Interceptor, JPressOptions.OptionChangeListener{
	//implements Interceptor
	private static boolean apiEnable = false;

    private static String apiAppId = null;
    private static String apiSecret = null;
    private static final long timeout = 10 * 60 * 1000; //10分钟

    public JSONWSAuthInterceptor() {
        JPressOptions.addListener(this);
        init();
    }


    public static void init() {
        apiEnable = JPressOptions.getAsBool(JPressConsts.OPTION_API_ENABLE);
        apiAppId = JPressOptions.get(JPressConsts.OPTION_API_APPID);
        apiSecret = JPressOptions.get(JPressConsts.OPTION_API_SECRET);
    }

    @Inject
    private UserService userService;

    public void intercept(Invocation inv) {
    	if (inv.getActionKey().equals("/api/jsonws/invoke") ||!inv.getActionKey().contains("/api/jsonws/")) {
    		inv.invoke();
    		return;
    	}
        // API 功能未启用
        if (apiEnable == false) {
            inv.getController().renderJson(Ret.fail().set("message", "API功能已经关闭，请管理员在后台进行开启"));
            return;
        }

        if (StrUtil.isBlank(apiAppId)) {
            inv.getController().renderJson(Ret.fail().set("message", "后台配置的 APP ID 不能为空，请先进入后台的接口管理进行配置。"));
            return;
        }

        if (StrUtil.isBlank(apiSecret)) {
            inv.getController().renderJson(Ret.fail().set("message", "后台配置的 API 密钥不能为空，请先进入后台的接口管理进行配置。"));
            return;
        }

        JbootController controller = (JbootController) inv.getController();
        //Get Auth
        String rawData = controller.getAttr("rawData");
       
        JSONObject json=ZUtils.parseLiferayJSONWSRequest(rawData);
        
        if(json==null) {
        	inv.getController().renderJson(Ret.fail().set("message", "JSONWS Invoke Params Error"));
        	return;
        }
        //
        String appId =  json.getString("appId");
        
        if (StrUtil.isBlank(appId)) {
            inv.getController().renderJson(Ret.fail().set("message", "在Url中获取到appId内容，请注意Url是否正确。"));
            return;
        }


        if (!appId.equals(apiAppId)) {
            inv.getController().renderJson(Ret.fail().set("message", "客户端配置的AppId和服务端配置的不一致。"));
            return;
        }
        
        String sign =  json.getString("sign");
        if (StrUtil.isBlank(sign)) {
            controller.renderJson(Ret.fail("message", "签名数据不能为空，请提交 sign 数据。"));
            return;
        }

        Long time = json.getLong("t");
        if (time == null) {
            controller.renderJson(Ret.fail("message", "时间参数不能为空，请提交 t 参数数据。"));
            return;
        }

        // 时间验证，可以防止重放攻击
        if (Math.abs(System.currentTimeMillis() - time) > timeout) {
            controller.renderJson(Ret.fail("message", "请求超时，请重新请求。"));
            return;
        }

        String localSign = createLocalSign(json.getString("t"));
        if (sign.equals(localSign) == false) {
            inv.getController().renderJson(Ret.fail().set("message", "数据签名错误。"));
            return;
        }

        Object userId = controller.getJwtPara(JPressConsts.JWT_USERID);
        if (userId != null) {
            controller.setAttr(JPressConsts.ATTR_LOGINED_USER, userService.findById(userId));
        }

        inv.invoke();
    }

    private String createLocalSign(String t) {
        Map<String, String[]> params = new HashMap<>();
		params.put("appId", new String[] { apiAppId });
		params.put("t", new String[] { t});
		String[] keys = { "appId", "t"};
		Arrays.sort(keys);
        StringBuilder query = new StringBuilder();
        for (String key : keys) {
            String value = params.get(key)[0];
            query.append(key).append(value);
        }
        query.append(apiSecret);
        return HashKit.md5(query.toString());
    }
    @Override
    public void onChanged(String key, String newValue, String oldValue) {

        switch (key) {
            case JPressConsts.OPTION_API_ENABLE:
                apiEnable = Boolean.parseBoolean(newValue);
                break;
            case JPressConsts.OPTION_API_APPID:
                apiAppId = newValue;
                break;
            case JPressConsts.OPTION_API_SECRET:
                apiSecret = newValue;
                break;
        }
    }

}
