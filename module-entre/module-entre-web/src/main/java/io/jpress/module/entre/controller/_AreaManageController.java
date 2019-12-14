/**
 * Copyright (c) 2016-2019, Michael Yang 杨福海 (fuhai999@gmail.com).
 * <p>
 * Licensed under the GNU Lesser General Public License (LGPL) ,Version 3.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * <p>
 * http://www.gnu.org/licenses/lgpl-3.0.txt
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package io.jpress.module.entre.controller;

import com.alibaba.fastjson.JSON;
import com.jfinal.aop.Inject;
import com.jfinal.kit.HashKit;
import com.jfinal.kit.Ret;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import io.jboot.utils.StrUtil;
import io.jboot.web.controller.annotation.RequestMapping;
import io.jboot.web.validate.EmptyValidate;
import io.jboot.web.validate.Form;
import io.jpress.JPressConsts;
import io.jpress.core.menu.annotation.AdminMenu;
import io.jpress.model.User;
import io.jpress.module.entre.model.AreaManage;
import io.jpress.module.entre.service.AreaManageService;
import io.jpress.service.RoleService;
import io.jpress.service.UserService;
import io.jpress.web.base.AdminControllerBase;
import org.apache.zookeeper.ZKUtil;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;


@RequestMapping(value = "/admin/entre/area_manage", viewPath = JPressConsts.DEFAULT_ADMIN_VIEW)
public class _AreaManageController extends AdminControllerBase {

    @Inject
    private AreaManageService service;

    @Inject
    private UserService userService;

    @Inject
    private RoleService   roleService;

    @AdminMenu(text = "区域管理", groupId = "entre")
    public void index() {
        Page<AreaManage> entries=service.paginate(getPagePara(), 10);
        userService.join(entries, "user_id");
        setAttr("page", entries);
        render("entre/area_manage_list.html");
    }

   
    public void edit() {
        int entryId = getParaToInt(0, 0);

        AreaManage entry = entryId > 0 ? service.findById(entryId) : null;
        setAttr("areaManage", entry);
        set("now", new Date());
        render("entre/area_manage_edit.html");
    }
   
    public void doSave() {
        AreaManage entry = new AreaManage();
        String id=getPara("id");
        String userId=getPara("user_id");
        String areaCode=getPara("area_code");
        String areaName=getPara("areaName");

        if(StrUtil.isNotBlank(id))
          entry.setId(Long.parseLong(id));

        entry.setUserId(Long.parseLong(userId));
        entry.setAreaCode(areaCode);
        entry.setAreaName(areaName);


        service.saveOrUpdate(entry);
        renderJson(Ret.ok().set("id", entry.getId()));
    }


    public void doDel() {
        Long id = getIdPara();
        render(service.deleteById(id) ? Ret.ok() : Ret.fail());
    }


    public void areaMngers(){
      List<User> users=service.getUsersByRoleId(3);
      renderJson(Ret.ok().set("users",users));
    }


    @AdminMenu(text = "客户管理", groupId = "entre")
    public void customer() {
        //String distCode=getPara("distCode");
        int verStatus=-1;
        String verStatusStr=getPara("verStatus");
        if(StrUtil.isNotBlank(verStatusStr)){
            verStatus=Integer.parseInt(verStatusStr);
        }
        String contactStatus=getPara("contactStatus");
       //
        String distCode="";
        User user=getLoginedUser();
        AreaManage am=service.getAreaManagerByUserId(user.getId());
        if(am!=null)
          distCode=am.getAreaCode().substring(0,2);
        //
        Page<User> users=service.getUsersByDistrict(getPagePara(),10,distCode,verStatus,contactStatus);
        setAttr("page", users);
        render("entre/customer_list.html");
    }

    public void audit(){
        String customerId=getPara("customerId");
        String contactStatus=getPara("contactStatus");
        User customer=userService.findById(customerId);
        Ver ver=ZUtils.getVer(customer);
        ver.setContactStatus(contactStatus);
        String json= JSON.toJSONString(ver);
        customer.setRemark(json);
        customer.update();
        renderJson(Ret.ok());
    }
}