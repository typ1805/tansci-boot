package com.tansci.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.tansci.common.WrapMapper;
import com.tansci.common.Wrapper;
import com.tansci.common.annotation.Log;
import com.tansci.common.constant.Constants;
import com.tansci.domain.SysRole;
import com.tansci.service.SysRoleService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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

    @ApiOperation(value = "分页", notes = "分页")
    @Log(modul = "角色管理", type = Constants.SELECT, desc = "列表")
    @GetMapping("/page")
    public Wrapper<IPage<SysRole>> page(Page page, SysRole role) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysRoleService.page(page, role));
    }

    @ApiOperation(value = "列表", notes = "列表")
    @Log(modul = "角色管理", type = Constants.SELECT, desc = "列表")
    @GetMapping("/list")
    @SaCheckPermission("role:list")
    public Wrapper<List<SysRole>> list(SysRole role) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysRoleService.list(role));
    }

    @ApiOperation(value = "添加", notes = "添加")
    @Log(modul = "角色管理", type = Constants.INSERT, desc = "添加")
    @PostMapping("/save")
    @SaCheckPermission("role:save")
    public Wrapper<Object> save(@RequestBody SysRole role) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysRoleService.insert(role));
    }

    @ApiOperation(value = "删除", notes = "删除")
    @Log(modul = "角色管理", type = Constants.DELETE, desc = "删除")
    @GetMapping("/delete/{id}")
    @SaCheckPermission("role:delete")
    public Wrapper<Object> delete(@PathVariable String id) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysRoleService.delete(id));
    }

    @ApiOperation(value = "修改", notes = "修改")
    @Log(modul = "角色管理", type = Constants.UPDATE, desc = "修改")
    @PostMapping("/update")
    @SaCheckPermission("role:update")
    public Wrapper<Object> update(@RequestBody SysRole role) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysRoleService.update(role));
    }

    @ApiOperation(value = "数据权限", notes = "数据权限")
    @Log(modul = "角色管理", type = Constants.UPDATE, desc = "数据权限")
    @PostMapping("/dataPermissions")
    @SaCheckPermission("role:data")
    public Wrapper<Object> dataPermissions(@RequestBody SysRole role) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysRoleService.dataPermissions(role));
    }

    @ApiOperation(value = "获取权限组织", notes = "获取权限组织")
    @Log(modul = "角色管理", type = Constants.UPDATE, desc = "获取权限组织")
    @GetMapping("/orgList/{roleId}")
    @SaCheckPermission("role:data")
    public Wrapper<Object> orgList(@PathVariable String roleId) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysRoleService.orgList(roleId));
    }

    @ApiOperation(value = "菜单权限", notes = "菜单权限")
    @Log(modul = "角色管理", type = Constants.UPDATE, desc = "菜单权限")
    @PostMapping("/menuPermissions")
    @SaCheckPermission("role:menu")
    public Wrapper<Object> menuPermissions(@RequestBody SysRole role) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysRoleService.menuPermissions(role));
    }

    @ApiOperation(value = "获取权限菜单", notes = "获取权限菜单")
    @Log(modul = "角色管理", type = Constants.UPDATE, desc = "获取权限菜单")
    @GetMapping("/menuList/{roleId}")
    @SaCheckPermission("role:menu")
    public Wrapper<Object> menuList(@PathVariable String roleId) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysRoleService.menuList(roleId));
    }

}
