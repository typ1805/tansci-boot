package com.tansci.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.tansci.domain.SysLoginLog;

/**
 * @ClassName： SysLoginLogService.java
 * @ClassPath： com.tansci.service.SysLoginLogService.java
 * @Description： 登录日志
 * @Author： tanyp
 * @Date： 2023/3/29 9:34
 **/
public interface SysLoginLogService extends IService<SysLoginLog> {

    IPage<SysLoginLog> onlineUser(Page page, String username);

}
