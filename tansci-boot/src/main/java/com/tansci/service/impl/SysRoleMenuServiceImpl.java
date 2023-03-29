package com.tansci.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.tansci.domain.SysRoleMenu;
import com.tansci.mapper.SysRoleMenuMapper;
import com.tansci.service.SysRoleMenuService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * @ClassName： SysRoleMenuServiceImpl.java
 * @ClassPath： com.tansci.service.impl.SysRoleMenuServiceImpl.java
 * @Description： 菜单权限
 * @Author： tanyp
 * @Date： 2023/3/29 10:26
 **/
@Slf4j
@Service
public class SysRoleMenuServiceImpl extends ServiceImpl<SysRoleMenuMapper, SysRoleMenu> implements SysRoleMenuService {
}
