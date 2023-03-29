package com.tansci.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.tansci.domain.SysUserRole;
import org.apache.ibatis.annotations.Mapper;

/**
 * @ClassName： SysUserRoleMapper.java
 * @ClassPath： com.tansci.mapper.SysUserRoleMapper.java
 * @Description： 用户权限
 * @Author： tanyp
 * @Date： 2023/3/29 9:30
 **/
@Mapper
public interface SysUserRoleMapper extends BaseMapper<SysUserRole> {
}
