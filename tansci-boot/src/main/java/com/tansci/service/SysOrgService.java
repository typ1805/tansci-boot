package com.tansci.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.tansci.domain.SysOrg;

import java.util.List;

/**
 * @ClassName： SysOrgService.java
 * @ClassPath： com.tansci.service.SysOrgService.java
 * @Description： 组织信息
 * @Author： tanyp
 * @Date： 2023/3/29 9:36
 **/
public interface SysOrgService extends IService<SysOrg> {

    List<SysOrg> list(SysOrg org);

    Object delete(String id);

}
