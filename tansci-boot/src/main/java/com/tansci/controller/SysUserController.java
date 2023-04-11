package com.tansci.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.tansci.common.WrapMapper;
import com.tansci.common.Wrapper;
import com.tansci.common.annotation.Log;
import com.tansci.common.constant.Constants;
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

    @ApiOperation(value = "分页", notes = "分页")
    @Log(modul = "用户管理-分页", type = Constants.SELECT, desc = "分页")
    @GetMapping("/page")
    public Wrapper<IPage<SysUser>> page(Page page, SysUser user) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysUserService.page(page, user));
    }

    @ApiOperation(value = "列表", notes = "列表")
    @Log(modul = "用户管理-列表", type = Constants.SELECT, desc = "列表")
    @GetMapping("/list")
    @SaCheckPermission("user:list")
    public Wrapper<List<SysUser>> list(SysUser user) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysUserService.list(user));
    }

    @ApiOperation(value = "添加", notes = "添加")
    @Log(modul = "用户管理-添加", type = Constants.INSERT, desc = "添加")
    @PostMapping("/save")
    @SaCheckPermission("user:save")
    public Wrapper<Object> save(@RequestBody SysUser user) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysUserService.insert(user));
    }

    @ApiOperation(value = "修改", notes = "修改")
    @Log(modul = "用户管理-修改", type = Constants.UPDATE, desc = "修改")
    @PostMapping("/update")
    @SaCheckPermission("user:update")
    public Wrapper<Object> update(@RequestBody SysUser user) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysUserService.update(user));
    }

    @ApiOperation(value = "删除", notes = "删除")
    @Log(modul = "用户管理-删除", type = Constants.DELETE, desc = "删除")
    @GetMapping("/delete/{id}")
    @SaCheckPermission("user:delete")
    public Wrapper<Object> delete(@PathVariable String id) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysUserService.del(id));
    }

    @ApiOperation(value = "修改密码", notes = "修改密码")
    @Log(modul = "用户管理-修改密码", type = Constants.UPDATE, desc = "修改密码")
    @PostMapping("/modifyPass")
    @SaCheckPermission("user:password")
    public Wrapper<Object> modifyPass(@RequestBody SysUser user) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysUserService.modifyPass(user));
    }

}
