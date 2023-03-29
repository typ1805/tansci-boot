package com.tansci.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.tansci.domain.SysRole;
import org.apache.ibatis.annotations.Mapper;

/**
 * @ClassName： SysRoleMapper.java
 * @ClassPath： com.tansci.mapper.SysRoleMapper.java
 * @Description： 角色信息
 * @Author： tanyp
 * @Date： 2023/3/29 9:25
 **/
@Mapper
public interface SysRoleMapper extends BaseMapper<SysRole> {
}
