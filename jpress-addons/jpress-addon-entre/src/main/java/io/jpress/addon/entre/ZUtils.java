package io.jpress.addon.entre;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import io.jboot.utils.StrUtil;
import io.jpress.model.User;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

public class ZUtils {

    public static JSONObject parseLiferayJSONWSRequest(String rawData) {
        JSONObject target=null;
        JSONArray jsonArray= StrUtil.isBlank(rawData) ? null : JSON.parseArray(rawData);
        if(jsonArray==null) {

        }else {
            JSONObject cmdJSONObject=(JSONObject)jsonArray.get(0);
            Object[] keys=(Object[])cmdJSONObject.keySet().toArray();

            JSONObject paramJson=(JSONObject)cmdJSONObject.get(keys[0]);
            paramJson.put("_cmd", keys[0]);
            target=paramJson;
        }
        return target;
    }

    public static Ver getVer(User user){
        String source=user.getRemark();
        if(source==null)source="{}";
           source=source.replaceAll("&quot;","'");
        Ver ver=null;
        try {
            ver = JSON.parseObject(source, Ver.class);
        }catch (Exception e)
        {
            source="{}";
            ver = JSON.parseObject(source, Ver.class);
            e.printStackTrace();
        }
        return ver;
    }

    public static String[] getAxiosParameterValues(HttpServletRequest request, String arrPara) {
        List<String> lstValues = new ArrayList<>();
        Enumeration<String> en = request.getParameterNames();
        while (en.hasMoreElements()) {
            String ele = en.nextElement();
            if (ele.indexOf(arrPara) != -1) {
                lstValues.add(ele);
            }
        }
        String[] values = new String[lstValues.size()];
        for (int i = 0; i <lstValues.size() ; i++) {
             String val=request.getParameter(lstValues.get(i));
             values[i]=val;
        }
        return values;
    }
}
