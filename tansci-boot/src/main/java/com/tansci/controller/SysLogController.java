package com.tansci.controller;

import com.tansci.service.SysLoginLogService;
import com.tansci.service.SysOperLogService;
import io.swagger.annotations.Api;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @ClassName： SysLogController.java
 * @ClassPath： com.tansci.controller.SysLogController.java
 * @Description： 日志管理
 * @Author： tanyp
 * @Date： 2023/3/29 9:45
 **/
@Slf4j
@RestController
@RequestMapping("/syslog")
@Api(value = "syslog", tags = "日志管理")
public class SysLogController {

    @Autowired
    private SysLoginLogService sysLoginLogService;
    @Autowired
    private SysOperLogService sysOperLogService;

}
