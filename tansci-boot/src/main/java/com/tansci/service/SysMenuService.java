package com.tansci.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.tansci.domain.SysMenu;
import com.tansci.domain.vo.SysMenuVo;

import java.util.List;

/**
 * @ClassName： SysMenuService.java
 * @ClassPath： com.tansci.service.SysMenuService.java
 * @Description： 菜单信息
 * @Author： tanyp
 * @Date： 2023/3/29 9:35
 **/
public interface SysMenuService extends IService<SysMenu> {

    List<SysMenu> tree(SysMenu menu);

    List<SysMenuVo> menus();

    Object delete(String id);

}
