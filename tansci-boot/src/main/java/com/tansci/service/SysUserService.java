package com.tansci.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.tansci.domain.SysUser;

import java.util.List;

/**
 * @ClassName： SysUserService.java
 * @ClassPath： com.tansci.service.SysUserService.java
 * @Description： 用户信息
 * @Author： tanyp
 * @Date： 2023/3/20 15:51
 **/
public interface SysUserService extends IService<SysUser> {

    IPage<SysUser> page(Page page, SysUser user);

    List<SysUser> list(SysUser user);

    Integer modifyPass(SysUser user);

    boolean save(SysUser user);

    boolean update(SysUser user);

    boolean del(SysUser user);

    SysUser login(String username);

}
