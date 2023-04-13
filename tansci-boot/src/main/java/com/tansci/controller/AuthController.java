package com.tansci.controller;

import cn.dev33.satoken.session.SaSessionCustomUtil;
import cn.dev33.satoken.stp.StpUtil;
import cn.hutool.captcha.CaptchaUtil;
import cn.hutool.captcha.LineCaptcha;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.tansci.common.WrapMapper;
import com.tansci.common.Wrapper;
import com.tansci.domain.SysLoginLog;
import com.tansci.domain.SysUser;
import com.tansci.domain.vo.SysUserVo;
import com.tansci.service.SysLoginLogService;
import com.tansci.service.SysUserService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

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
    @Autowired
    private SysLoginLogService sysLoginLogService;

    @ApiOperation(value = "登录", notes = "登录")
    @PostMapping("/login")
    public Wrapper<SysUserVo> login(HttpServletRequest request, @RequestBody SysUser user) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysUserService.login(request, user));
    }

    @ApiOperation(value = "登出", notes = "登出")
    @GetMapping("/logout")
    public Wrapper<Object> logout() {
        SaSessionCustomUtil.deleteSessionById(String.valueOf(StpUtil.getLoginId()));
        StpUtil.logout();
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, "登出成功！");
    }

    @ApiOperation(value = "验证码", notes = "验证码")
    @GetMapping("/code")
    public Wrapper<Object> verificationCode(HttpServletRequest request) {
        LineCaptcha lineCaptcha = CaptchaUtil.createLineCaptcha(100, 60);
        // 四则运算方式
//        lineCaptcha.setGenerator(new MathGenerator());
        // 验证码存session， 60秒过期
        request.getSession().setMaxInactiveInterval(60);
        request.getSession().setAttribute("verifyCode", lineCaptcha.getCode());
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, lineCaptcha.getImageBase64());
    }

    @ApiOperation(value = "在线用户", notes = "在线用户")
    @GetMapping("/onlineUser")
    public Wrapper<IPage<SysLoginLog>> onlineUser(Page page, String username) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysLoginLogService.onlineUser(page, username));
    }

    @ApiOperation(value = "踢人", notes = "踢人")
    @GetMapping("/kick")
    public Wrapper<Object> kick(String token) {
        StpUtil.logoutByTokenValue(token);
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, "ok");
    }

}
