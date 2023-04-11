package com.tansci.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.tansci.domain.SysRoleOrg;
import com.tansci.mapper.SysRoleOrgMapper;
import com.tansci.service.SysRoleOrgService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * @ClassName： SysRoleOrgServiceImpl.java
 * @ClassPath： com.tansci.service.impl.SysRoleOrgServiceImpl.java
 * @Description： 组织权限
 * @Author： tanyp
 * @Date： 2023/4/11 13:36
 **/
@Slf4j
@Service
public class SysRoleOrgServiceImpl extends ServiceImpl<SysRoleOrgMapper, SysRoleOrg> implements SysRoleOrgService {
}
