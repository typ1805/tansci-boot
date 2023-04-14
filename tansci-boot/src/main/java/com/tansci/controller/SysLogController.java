package com.tansci.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.tansci.common.WrapMapper;
import com.tansci.common.Wrapper;
import com.tansci.common.annotation.Log;
import com.tansci.common.constant.Constants;
import com.tansci.domain.SysLoginLog;
import com.tansci.domain.SysOperLog;
import com.tansci.service.SysLoginLogService;
import com.tansci.service.SysOperLogService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
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

    @ApiOperation(value = "登录日志", notes = "登录日志")
    @Log(modul = "日志管理", type = Constants.DELETE, desc = "登录日志")
    @GetMapping("/loginLog")
    public Wrapper<IPage<SysLoginLog>> loginLog(Page page) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysLoginLogService.page(page));
    }

    @ApiOperation(value = "操作日志", notes = "操作日志")
    @Log(modul = "日志管理", type = Constants.DELETE, desc = "操作日志")
    @GetMapping("/operLog")
    public Wrapper<IPage<SysOperLog>> operLog(Page page) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysOperLogService.page(page));
    }

}
