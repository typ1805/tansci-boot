package com.tansci.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.tansci.domain.SysMenu;
import org.apache.ibatis.annotations.Mapper;

/**
 * @ClassName： SysMenuMapper.java
 * @ClassPath： com.tansci.mapper.SysMenuMapper.java
 * @Description： 菜单信息
 * @Author： tanyp
 * @Date： 2023/3/29 9:26
 **/
@Mapper
public interface SysMenuMapper extends BaseMapper<SysMenu> {
}
