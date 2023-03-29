package com.tansci.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.tansci.domain.SysLoginLog;
import org.apache.ibatis.annotations.Mapper;

/**
 * @ClassName： SysLoginLogMapper.java
 * @ClassPath： com.tansci.mapper.SysLoginLogMapper.java
 * @Description： 登录日志
 * @Author： tanyp
 * @Date： 2023/3/29 9:29
 **/
@Mapper
public interface SysLoginLogMapper extends BaseMapper<SysLoginLog> {
}
