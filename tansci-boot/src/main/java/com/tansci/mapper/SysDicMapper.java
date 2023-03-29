package com.tansci.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.tansci.domain.SysDic;
import org.apache.ibatis.annotations.Mapper;

/**
 * @ClassName： SysDicMapper.java
 * @ClassPath： com.tansci.mapper.SysDicMapper.java
 * @Description： 字典信息
 * @Author： tanyp
 * @Date： 2023/3/29 9:28
 **/
@Mapper
public interface SysDicMapper extends BaseMapper<SysDic> {
}
