package io.jpress.addon.entre;

import com.alibaba.fastjson.JSON;
import com.jfinal.aop.Inject;
import com.jfinal.core.ActionKey;
import com.jfinal.kit.Ret;
import io.jboot.web.controller.JbootController;
import io.jboot.web.controller.annotation.RequestMapping;
import io.jpress.JPressConsts;
import io.jpress.JPressOptions;
import io.jpress.core.menu.annotation.AdminMenu;
import io.jpress.model.User;
import io.jpress.service.UserService;


@RequestMapping(value = "/entre",viewPath = "/")
public class EntreAddonController extends JbootController {

    @Inject
    UserService userService;
    public void index() {
        setAttr("version","1.0.2");
        render("entre/index.html");
    }

    public void json() {
        renderJson(Ret.ok().set("message", "json ok...."));
    }


    public void verCallback(){
        //https://xxx.com/xxx?code=xxxx&orderNo=xxxx&h5faceId=xxxx&newSignature=xxxx
        ///entre/verCallback?orderNo=11566717439865&signature=679A0650A38FA1E035D81AF544B8C61137320A70&code=0&newSignature=79F9997DB926819290DBFF57FDD79A9D78E7B162&h5faceId=b220ceb92be305aea847e49625fb21ac&liveRate=99
        String code=getPara("code");
        String pOrderNo=getPara("orderNo");
        String h5faceId=getPara("h5faceId");
        String newSignature=getPara("newSignature");

        //getUserId
        long len=(System.currentTimeMillis()+"").length();
        long totalLen=pOrderNo.length();
        int lenGap=Integer.parseInt((totalLen-len)+"");
        String userIdStr=pOrderNo.substring(0,lenGap);

        User user = userService.findById(Long.parseLong(userIdStr));
        //String orderNo= user.getRemark();
        //
        // AppID、orderNo 和 SIGN ticket、code
        String app_id = "IDA5oD0T";
        String  remark=user.getRemark();
        Ver ver=ZUtils.getVer(user);

        // String[] result=remark.split("@");
        String _orderNo=ver.getFaceOrderNo();
        String _signTicket=ver.getFacebizCode();

        String[] _param=new String[4];
        _param[0]=app_id;
        _param[1]=_orderNo;
        _param[2]=_signTicket;
        _param[3]=code;
        String _sha1Sign=ZFaceIdHelper.getArrSortSHA1Sign(_param);
        int err=-1;
        if(code.equalsIgnoreCase("0")&&_sha1Sign.equalsIgnoreCase(newSignature)){
            err=0;
            ver.setVerStatus("9");
            String json= JSON.toJSONString(ver);
            user.setRemark(json);
        }
        if(err==-1){

        }
        user.update();
        set("user",user);
        set("err",err);

        String webDomain=JPressOptions.get(JPressConsts.OPTION_WEB_DOMAIN);
        if(webDomain!=null && webDomain.indexOf(":")!=-1){
            webDomain=webDomain.substring(0,webDomain.lastIndexOf(':'));
            System.out.println(webDomain+"=====");
        }
        set("webDomain",webDomain);
        render("entre/ver_back.html");
    }

    @ActionKey("/admin/addon/test")
    @AdminMenu(groupId = JPressConsts.SYSTEM_MENU_ADDON, text = "插件测试")
    public void adminmenutest() {
        renderText("addon test");
    }

    public static void main(String[] args) {
        String pOrderNo=123+""+System.currentTimeMillis();
        long len=(System.currentTimeMillis()+"").length();
        long totalLen=pOrderNo.length();
        int lenGap=Integer.parseInt((totalLen-len)+"");
        String userIdStr=pOrderNo.substring(0,lenGap);
        System.out.println(userIdStr);
    }
}
