package com.tansci.controller;

import com.tansci.service.SysOrgService;
import io.swagger.annotations.Api;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @ClassName： SysOrgController.java
 * @ClassPath： com.tansci.controller.SysOrgController.java
 * @Description： 组织管理
 * @Author： tanyp
 * @Date： 2023/3/29 9:46
 **/
@Slf4j
@RestController
@RequestMapping("/sysrog")
@Api(value = "sysrog", tags = "组织管理")
public class SysOrgController {

    @Autowired
    private SysOrgService sysOrgService;

}
