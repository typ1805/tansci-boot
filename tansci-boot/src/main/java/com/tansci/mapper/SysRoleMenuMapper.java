package com.tansci.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.tansci.domain.SysRoleMenu;
import org.apache.ibatis.annotations.Mapper;

/**
 * @ClassName： SysRoleMenuMapper.java
 * @ClassPath： com.tansci.mapper.SysRoleMenuMapper.java
 * @Description： 菜单角色
 * @Author： tanyp
 * @Date： 2023/3/29 9:30
 **/
@Mapper
public interface SysRoleMenuMapper extends BaseMapper<SysRoleMenu> {
}
