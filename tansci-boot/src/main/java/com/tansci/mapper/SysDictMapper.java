package com.tansci.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.tansci.domain.SysDict;
import org.apache.ibatis.annotations.Mapper;

/**
 * @ClassName： SysDictMapper.java
 * @ClassPath： com.tansci.mapper.SysDictMapper.java
 * @Description： 字典信息
 * @Author： tanyp
 * @Date： 2023/3/29 9:28
 **/
@Mapper
public interface SysDictMapper extends BaseMapper<SysDict> {
}
