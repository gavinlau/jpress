package io.jpress.module.entre.service;

import com.jfinal.plugin.activerecord.Page;
import io.jpress.model.User;
import io.jpress.module.entre.model.AreaManage;

import java.util.List;

public interface AreaManageService  {

    /**
     * find model by primary key
     *
     * @param id
     * @return
     */
    public AreaManage findById(Object id);


    /**
     * find all model
     *
     * @return all <AreaManage
     */
    public List<AreaManage> findAll();


    /**
     * delete model by primary key
     *
     * @param id
     * @return success
     */
    public boolean deleteById(Object id);


    /**
     * delete model
     *
     * @param model
     * @return
     */
    public boolean delete(AreaManage model);


    /**
     * save model to database
     *
     * @param model
     * @return  id value if save success
     */
    public Object save(AreaManage model);


    /**
     * save or update model
     *
     * @param model
     * @return id value if saveOrUpdate success
     */
    public Object saveOrUpdate(AreaManage model);


    /**
     * update data model
     *
     * @param model
     * @return
     */
    public boolean update(AreaManage model);


    /**
     * paginate query
     *
     * @param page
     * @param pageSize
     * @return
     */
    public Page<AreaManage> paginate(int page, int pageSize);

    public List<User>  getUsersByRoleId(int roleId);

    public AreaManage getAreaManagerByUserId(long userId);
    /**
     *
     * @param dist
     * @param verStatus 0 没认证 1 验证中 9 认证王弼
     * @param contactStatus unaudited auditiong audited
     * @return
     */
    public Page<User> getUsersByDistrict(int page, int pageSize, String dist,int verStatus,String contactStatus);

    
}