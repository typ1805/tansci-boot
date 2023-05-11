package com.tansci.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.tansci.domain.LcPagesMenu;
import org.apache.ibatis.annotations.Mapper;

/**
 * @ClassName： LcPagesMenuMapper.java
 * @ClassPath： com.tansci.mapper.LcPagesMenuMapper.java
 * @Description： 页面菜单关系
 * @Author： tanyp
 * @Date： 2023/5/11 9:06
 **/
@Mapper
public interface LcPagesMenuMapper extends BaseMapper<LcPagesMenu> {
}
