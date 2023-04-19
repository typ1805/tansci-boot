package com.tansci.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.tansci.domain.SysUser;
import com.tansci.domain.vo.SysUserVo;
import com.tansci.domain.vo.UserAuthVo;

import javax.servlet.http.HttpServletRequest;
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

    UserAuthVo info();

    Object insert(SysUser user);

    Object update(SysUser user);

    Object del(String id);

    SysUserVo login(HttpServletRequest request, SysUser user);

    Object modifyPass(SysUser user);

}
