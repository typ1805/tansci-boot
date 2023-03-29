package com.tansci.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.tansci.domain.SysRole;
import com.tansci.mapper.SysRoleMapper;
import com.tansci.service.SysRoleService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * @ClassName： SysRoleServiceImpl.java
 * @ClassPath： com.tansci.service.impl.SysRoleServiceImpl.java
 * @Description： 权限信息
 * @Author： tanyp
 * @Date： 2023/3/29 9:44
 **/
@Slf4j
@Service
public class SysRoleServiceImpl extends ServiceImpl<SysRoleMapper, SysRole> implements SysRoleService {
}
