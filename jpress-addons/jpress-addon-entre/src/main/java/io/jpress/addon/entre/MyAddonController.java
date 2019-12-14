package io.jpress.addon.entre;

import com.alibaba.fastjson.JSON;
import com.jfinal.aop.Before;
import com.jfinal.aop.Inject;
import com.jfinal.core.ActionKey;
import com.jfinal.kit.HashKit;
import com.jfinal.kit.Ret;
import com.jfinal.log.Log;
import com.jfinal.plugin.activerecord.Db;
import io.jboot.Jboot;
import io.jboot.utils.StrUtil;
import io.jboot.web.controller.JbootController;
import io.jboot.web.controller.annotation.RequestMapping;
import io.jboot.web.validate.EmptyValidate;
import io.jboot.web.validate.Form;
import io.jpress.JPressConsts;
import io.jpress.JPressOptions;
import io.jpress.commons.sms.SmsKit;
import io.jpress.commons.sms.SmsMessage;
import io.jpress.core.menu.annotation.AdminMenu;
import io.jpress.model.User;
import io.jpress.service.UserService;
import io.jpress.web.base.AdminControllerBase;
import io.jpress.web.base.ControllerBase;
import io.jpress.web.base.UserControllerBase;
import io.jpress.web.interceptor.CSRFInterceptor;
import io.jpress.web.interceptor.UserCenterInterceptor;
import io.jpress.web.interceptor.UserInterceptor;
import io.jpress.web.interceptor.UserMustLoginedInterceptor;

import javax.servlet.http.HttpServletRequest;
import java.util.Enumeration;


@RequestMapping(value = "/me",viewPath = "/")
public class MyAddonController extends UserControllerBase {
    @Inject
    UserService userService;



    public void index() {
        setAttr("version","1.0.2");
        renderJson(Ret.ok());
    }
    public void uploadVerImgs() {
        setAttr("version","1.0.2");
        renderJson(Ret.ok());
    }



    public void doSaveIdSrc(){
        String frontImgsrc=getPara("frontImgsrc");
        String backImgsrc=getPara("backImgsrc");
        User user=getLoginedUser();
        Ver ver=ZUtils.getVer(user);
        ver.setFrontImgsrc(frontImgsrc);
        ver.setBackImgsrc(backImgsrc);
        String json=JSON.toJSONString(ver);
        user.setRemark(json);
        user.update();
        renderOkJson();
    }

    public void doSmsSend(){
            String phone = getPara("phone");
            if (StrUtil.isBlank(phone)) {
                renderJson(Ret.fail().set("message", "手机号不能为空..."));
                return;
            }
            if (StrUtil.isMobileNumber(phone) == false) {
                renderJson(Ret.fail().set("message", "你输入的手机号码不正确"));
                return;
            }
            int count=Db.queryInt("select count(*) from user where mobile="+phone+" and id!="+getLoginedUser().getId());
            if(count>0){
                renderJson(Ret.fail().set("message", "手机已经注册").set("errorCode", 7));
                return;
            }
            String code = SmsKit.generateCode();
            String template ="SMS_180049533";
            String sign ="身份验证";
            Boolean sendOk =SmsKit.sendCode(phone, code,template, sign);
            if (sendOk) {
                renderJson(Ret.ok().set("message", "短信发送成功，请手机查看"));
            } else {
                renderJson(Ret.fail().set("message", "短信实发失败，请联系管理员"));
            }
    }

    public void checkBeforeVer(){
        String phoneNumber = getPara("phone");
        String paraCode = getPara("sms_code");
        String idNo=getPara("idNo");
        String realName=getPara("realName");
        String address=getPara("address");
        String addrAreaCode=getPara("addrAreaCode");
        String addrAreaName=getPara("addrAreaName");

        if (SmsKit.validateCode(phoneNumber, paraCode) == false) {
                renderJson(Ret.fail().set("message", "短信验证码输入错误").set("errorCode", 7));
                return;
         }
         User user=getLoginedUser();

        if(user.getMobile()!=phoneNumber)
         user.setMobile(phoneNumber);

         user.setRealname(realName);
         user.setIdcard(idNo);
         user.setAddress(address);
         user.setMobileStatus("ok");
        //
        Ver ver=ZUtils.getVer(user);
        ver.setAddrAreaCode(addrAreaCode);
        ver.setAddrAreaName(addrAreaName);
        String json=JSON.toJSONString(ver);
        user.setRemark(json);
        //
         user.update();

         renderOkJson();
      }

    public void getFaceUrl(){
        String idNo=getPara("idNo");
        String realName=getPara("realName");
        long userId=getParaToLong("userId");
        String domain=JPressOptions.get(JPressConsts.OPTION_WEB_DOMAIN);
        String callBackURL=domain+EntreConstants.ENTRE_FACE_BACK_URL;
        String orderNo=userId+""+System.currentTimeMillis();
        String name=realName;
        String userIdStr=userId+"";
        String ret=ZFaceIdHelper.h5FaceIdCheckURL(orderNo, name, idNo, userIdStr, callBackURL);

        String[] results=ret.split("@");
        User user=userService.findById(userId);

        Ver ver=ZUtils.getVer(user);
        ver.setFacebizCode(results[0]);
        ver.setFaceOrderNo(orderNo);

        String json=JSON.toJSONString(ver);
        user.setRemark(json);

        user.setRealname(realName);
        userService.update(user);
        renderJson(Ret.ok().set("faceUrl",results[1]));
    }

    public void saveContact(){
        String proxyIdx=getPara("proxyIdx");
        String proxyName=getPara("proxyName");
        String proxyAreaCode=getPara("proxyAreaCode");
        String proxyAreaName=getPara("proxyAreaName");
        String proxyStreet=getPara("proxyStreet");
        String proxyCommunity=getPara("proxyCommunity");
        String proxySpace=getPara("proxySpace");
        String payUserName=getPara("payUserName");
        String payPhoneName=getPara("payPhoneName");
        String payCardNo=getPara("payCardNo");


        String[] contactPicsList= ZUtils.getAxiosParameterValues(getRequest(),"contactPicsList");
        System.out.println(contactPicsList);

        User user=getLoginedUser();
        Ver ver=ZUtils.getVer(user);
        ver.setProxyIdx(proxyIdx);
        ver.setProxyName(proxyName);
        ver.setProxyAreaCode(proxyAreaCode);
        ver.setProxyAreaName(proxyAreaName);
        ver.setProxyStreet(proxyStreet);
        ver.setProxyCommunity(proxyCommunity);
        ver.setProxySpace(proxySpace);

        ver.setContactPicsList(contactPicsList);

        String json=JSON.toJSONString(ver);
        user.setRemark(json);
        user.update();
        renderOkJson();
    }

    public void updateContractPicsList(){
        String[] contactPicsList= ZUtils.getAxiosParameterValues(getRequest(),"contactPicsList");
        User user=getLoginedUser();
        Ver ver=ZUtils.getVer(user);
        ver.setContactPicsList(contactPicsList);
        ver.setContactStatus("auditing");
        String json=JSON.toJSONString(ver);
        user.setRemark(json);
        user.update();
        renderOkJson();
    }


    public void updatePayInfo(){
        String payUserName=getPara("payUserName");
        String payPhoneNo=getPara("payPhoneNo");
        String payCardNo=getPara("payCardNo");
        User user=getLoginedUser();
        Ver ver=ZUtils.getVer(user);
        ver.setPayUserName(payUserName);
        ver.setPayPhoneNo(payPhoneNo);
        ver.setPayCardNo(payCardNo);
        ver.setContactStatus("paying");
        String json=JSON.toJSONString(ver);
        user.setRemark(json);
        user.update();
        renderOkJson();
    }

    @EmptyValidate({
            @Form(name = "oldPwd", message = "旧不能为空"),
            @Form(name = "newPwd", message = "新密码不能为空"),
            @Form(name = "confirmPwd", message = "确认密码不能为空")
    })
    public void updatePwd(String oldPwd, String newPwd, String confirmPwd) {

        User user = getLoginedUser();

        if (userService.doValidateUserPwd(user, oldPwd).isFail()) {
            renderJson(Ret.fail().set("message", "密码错误"));
            return;
        }

        if (newPwd.equals(confirmPwd) == false) {
            renderJson(Ret.fail().set("message", "两次出入密码不一致"));
            return;
        }

        String salt = user.getSalt();
        String hashedPass = HashKit.sha256(salt + newPwd);

        user.setPassword(hashedPass);
        userService.update(user);

        renderOkJson();
    }



    private static Log _log=Log.getLog(MyAddonController.class);
}
