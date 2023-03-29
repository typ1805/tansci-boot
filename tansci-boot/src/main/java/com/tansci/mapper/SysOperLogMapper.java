package com.tansci.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.tansci.domain.SysOperLog;
import org.apache.ibatis.annotations.Mapper;

/**
 * @ClassName： SysOperLogMapper.java
 * @ClassPath： com.tansci.mapper.SysOperLogMapper.java
 * @Description： 操作日志
 * @Author： tanyp
 * @Date： 2023/3/29 9:29
 **/
@Mapper
public interface SysOperLogMapper extends BaseMapper<SysOperLog> {
}
