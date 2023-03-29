package com.tansci.controller;

import com.tansci.service.SysRoleService;
import io.swagger.annotations.Api;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @ClassName： SysRoleController.java
 * @ClassPath： com.tansci.controller.SysRoleController.java
 * @Description： 角色管理
 * @Author： tanyp
 * @Date： 2023/3/29 9:46
 **/
@Slf4j
@RestController
@RequestMapping("/sysrole")
@Api(value = "sysrole", tags = "角色管理")
public class SysRoleController {

    @Autowired
    private SysRoleService sysRoleService;


}
