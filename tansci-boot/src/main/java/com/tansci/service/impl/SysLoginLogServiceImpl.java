package com.tansci.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.tansci.domain.SysLoginLog;
import com.tansci.mapper.SysLoginLogMapper;
import com.tansci.service.SysLoginLogService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * @ClassName： SysLoginLogServiceImpl.java
 * @ClassPath： com.tansci.service.impl.SysLoginLogServiceImpl.java
 * @Description： 登录日志
 * @Author： tanyp
 * @Date： 2023/3/29 9:40
 **/
@Slf4j
@Service
public class SysLoginLogServiceImpl extends ServiceImpl<SysLoginLogMapper, SysLoginLog> implements SysLoginLogService {
}