package com.tansci.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.tansci.domain.SysUser;
import org.apache.ibatis.annotations.Mapper;

/**
 * @ClassName： SysUserMapper.java
 * @ClassPath： com.tansci.mapper.SysUserMapper.java
 * @Description： 用户信息
 * @Author： tanyp
 * @Date： 2023/3/20 15:50
 **/
@Mapper
public interface SysUserMapper extends BaseMapper<SysUser> {
}
