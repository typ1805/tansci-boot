package com.tansci.controller;

import com.tansci.service.SysDicService;
import io.swagger.annotations.Api;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @ClassName： SysDicController.java
 * @ClassPath： com.tansci.controller.SysDicController.java
 * @Description： 字典管理
 * @Author： tanyp
 * @Date： 2023/3/29 9:45
 **/
@Slf4j
@RestController
@RequestMapping("/sysdic")
@Api(value = "sysdic", tags = "字典管理")
public class SysDicController {

    @Autowired
    private SysDicService sysDicService;

}
