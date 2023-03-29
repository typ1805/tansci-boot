package com.tansci.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.tansci.domain.SysOperLog;
import com.tansci.mapper.SysOperLogMapper;
import com.tansci.service.SysOperLogService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * @ClassName： SysOperLogServiceImpl.java
 * @ClassPath： com.tansci.service.impl.SysOperLogServiceImpl.java
 * @Description： 操作日志
 * @Author： tanyp
 * @Date： 2023/3/29 9:42
 **/
@Slf4j
@Service
public class SysOperLogServiceImpl extends ServiceImpl<SysOperLogMapper, SysOperLog> implements SysOperLogService {
}
