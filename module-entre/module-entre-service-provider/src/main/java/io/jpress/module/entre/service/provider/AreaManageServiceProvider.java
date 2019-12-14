package io.jpress.module.entre.service.provider;

import com.jfinal.aop.Inject;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import io.jboot.aop.annotation.Bean;
import io.jboot.db.model.Column;
import io.jboot.db.model.Columns;
import io.jboot.utils.StrUtil;
import io.jpress.model.User;
import io.jpress.module.entre.service.AreaManageService;
import io.jpress.module.entre.model.AreaManage;
import io.jboot.service.JbootServiceBase;
import io.jpress.service.UserService;

import java.util.ArrayList;
import java.util.List;

@Bean
public class AreaManageServiceProvider extends JbootServiceBase<AreaManage> implements AreaManageService {
    @Inject
    private UserService userService;
    @Override
    /**
     * select * from user u  left join user_role_mapping  m on user.id=m.
     */
    public List<User> getUsersByRoleId(int roleId) {
        List<Record> records = Db.find("select * from user_role_mapping where role_id=?",roleId);
        List<User> users=new ArrayList<>();
        for (Record rec:records){
            User user=userService.findById(rec.getInt("user_id"));
            users.add(user);
        }
        return users;
    }

    public AreaManage getAreaManagerByUserId(long userId){
        return DAO.findFirstByColumn(Column.create("user_id",userId));
    }

    @Override
    /**
     *
     * @param dist
     * @param verStatus 0 没认证 1 验证中 9 认证王弼
     * @param contactStatus unaudited auditiong audited
     * @return
     */
    public Page<User> getUsersByDistrict(int page, int pageSize, String distCode, int verStatus, String contactStatus) {

        Columns columns = new Columns();
        if(StrUtil.isNotBlank(distCode)){
            String distCodeRaw="&quot;proxyAreaCode&quot;:%&quot;"+distCode;
            columns.likeAppendPercent("remark", distCodeRaw);
        }
        if(verStatus!=-1) {
            String verStatusRaw="&quot;verStatus&quot;:%&quot;"+verStatus;
            columns.likeAppendPercent("remark", verStatusRaw);
        }
        if(StrUtil.isNotBlank(contactStatus)){
            String contactStatusRaw="&quot;contactStatus&quot;:%&quot;"+contactStatus;
            columns.likeAppendPercent("remark", contactStatusRaw);
        }


        Page<User> usersRaw=userService._paginate(page,pageSize,columns,null,"");
        List<User> list=usersRaw.getList();
        for(int i=0;i<list.size();i++){
            User user=list.get(i);
            String remark=user.getRemark();
            if(StrUtil.isNotBlank(remark)){
                remark=remark.replaceAll("&quot;","'");
            }
            user.setRemark(remark);
        }
        return userService._paginate(page,pageSize,columns,null,"");

    }
}