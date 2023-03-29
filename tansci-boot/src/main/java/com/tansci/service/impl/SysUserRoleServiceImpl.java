package com.tansci.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.tansci.domain.SysUserRole;
import com.tansci.mapper.SysUserRoleMapper;
import com.tansci.service.SysUserRoleService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * @ClassName： SysUserRoleServiceImpl.java
 * @ClassPath： com.tansci.service.impl.SysUserRoleServiceImpl.java
 * @Description： 用户权限
 * @Author： tanyp
 * @Date： 2023/3/29 10:05
 **/
@Slf4j
@Service
public class SysUserRoleServiceImpl extends ServiceImpl<SysUserRoleMapper, SysUserRole> implements SysUserRoleService {
}
