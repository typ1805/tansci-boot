package com.tansci.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.tansci.domain.SysOrg;
import org.apache.ibatis.annotations.Mapper;

/**
 * @ClassName： SysOrgMapper.java
 * @ClassPath： com.tansci.mapper.SysOrgMapper.java
 * @Description： 组织机构
 * @Author： tanyp
 * @Date： 2023/3/29 9:27
 **/
@Mapper
public interface SysOrgMapper extends BaseMapper<SysOrg> {
}
