package com.tansci.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.tansci.common.WrapMapper;
import com.tansci.common.Wrapper;
import com.tansci.domain.SysUser;
import com.tansci.service.SysUserService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @ClassName： SysUserController.java
 * @ClassPath： com.tansci.controller.SysUserController.java
 * @Description： 用户管理
 * @Author： tanyp
 * @Date： 2023/3/20 15:52
 **/
@Slf4j
@RestController
@RequestMapping("/sysuser")
@Api(value = "sysuser", tags = "用户管理")
public class SysUserController {

    @Autowired
    private SysUserService sysUserService;

    @ApiOperation(value = "用户分页", notes = "用户分页")
    @GetMapping("/page")
    public Wrapper<IPage<SysUser>> page(Page page, SysUser user) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysUserService.page(page, user));
    }

    @ApiOperation(value = "用户列表", notes = "用户列表")
    @GetMapping("/list")
    public Wrapper<List<SysUser>> list(SysUser user) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysUserService.list(user));
    }

    @ApiOperation(value = "添加用户信息", notes = "添加用户信息")
    @PostMapping("/save")
    public Wrapper<Object> save(@RequestBody SysUser user) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysUserService.insert(user));
    }

    @ApiOperation(value = "修改用户信息", notes = "修改用户信息")
    @PostMapping("/update")
    public Wrapper<Object> update(@RequestBody SysUser user) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysUserService.update(user));
    }

    @ApiOperation(value = "删除用户", notes = "删除用户")
    @GetMapping("/del")
    public Wrapper<Object> del(SysUser user) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysUserService.del(user));
    }

    @ApiOperation(value = "修改密码", notes = "修改密码")
    @PostMapping("/modifyPass")
    public Wrapper<Object> modifyPass(@RequestBody SysUser user) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysUserService.modifyPass(user));
    }

}
