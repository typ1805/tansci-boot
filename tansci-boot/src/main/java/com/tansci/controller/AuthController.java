package com.tansci.controller;

import cn.dev33.satoken.session.SaSessionCustomUtil;
import cn.dev33.satoken.stp.StpUtil;
import com.tansci.common.WrapMapper;
import com.tansci.common.Wrapper;
import com.tansci.domain.SysUser;
import com.tansci.domain.vo.SysUserVo;
import com.tansci.service.SysUserService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * @ClassName： AuthController.java
 * @ClassPath： com.tansci.controller.AuthController.java
 * @Description： 鉴权管理
 * @Author： tanyp
 * @Date： 2023/3/20 15:52
 **/
@Slf4j
@RestController
@RequestMapping("/auth")
@Api(value = "auth", tags = "鉴权管理")
public class AuthController {

    @Autowired
    private SysUserService sysUserService;

    @ApiOperation(value = "登录", notes = "登录")
    @PostMapping("/login")
    public Wrapper<SysUserVo> login(@RequestBody SysUser user) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysUserService.login(user));
    }

    @ApiOperation(value = "登出", notes = "登出")
    @GetMapping("/logout")
    public Wrapper<Object> logout() {
        SaSessionCustomUtil.deleteSessionById(String.valueOf(StpUtil.getLoginId()));
        StpUtil.logout();
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, "登出成功！");
    }

}
