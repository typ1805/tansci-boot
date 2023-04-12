package com.tansci.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.tansci.domain.SysRole;

import java.util.List;

/**
 * @ClassName： SysRoleService.java
 * @ClassPath： com.tansci.service.SysRoleService.java
 * @Description： 角色信息
 * @Author： tanyp
 * @Date： 2023/3/29 9:37
 **/
public interface SysRoleService extends IService<SysRole> {

    IPage<SysRole> page(Page page, SysRole role);

    List<SysRole> list(SysRole role);

    Object insert(SysRole role);

    Object update(SysRole role);

    Object delete(String id);

    Object dataPermissions(SysRole role);

    Object orgList(String roleId);

    Object menuPermissions(SysRole role);

    Object menuList(String roleId);

}
