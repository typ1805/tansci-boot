package com.tansci.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.tansci.common.WrapMapper;
import com.tansci.common.Wrapper;
import com.tansci.common.annotation.Log;
import com.tansci.common.constant.Constants;
import com.tansci.domain.SysMenu;
import com.tansci.domain.vo.SysMenuVo;
import com.tansci.service.SysMenuService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @ClassName： SysMenuController.java
 * @ClassPath： com.tansci.controller.SysMenuController.java
 * @Description： 菜单管理
 * @Author： tanyp
 * @Date： 2023/3/29 9:45
 **/
@Slf4j
@RestController
@RequestMapping("/sysmenu")
@Api(value = "sysmenu", tags = "菜单管理")
public class SysMenuController {

    @Autowired
    private SysMenuService sysMenuService;

    @ApiOperation(value = "当前用户权限菜单列表", notes = "当前用户权限菜单列表")
    @Log(modul = "菜单管理-当前用户权限菜单列表", type = Constants.SELECT, desc = "当前用户权限菜单列表")
    @GetMapping("/menus")
    public Wrapper<List<SysMenuVo>> menus() {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysMenuService.menus());
    }

    @ApiOperation(value = "菜单树", notes = "菜单树")
    @Log(modul = "菜单管理-菜单树", type = Constants.SELECT, desc = "菜单树")
    @GetMapping("/tree")
    @SaCheckPermission("menu:list")
    public Wrapper<List<SysMenu>> tree(SysMenu menu) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysMenuService.tree(menu));
    }

    @ApiOperation(value = "详情", notes = "详情")
    @Log(modul = "菜单管理-详情", type = Constants.SELECT, desc = "详情")
    @GetMapping("/getById/{id}")
    @SaCheckPermission("menu:view")
    public Wrapper<SysMenu> getById(@PathVariable String id) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysMenuService.getById(id));
    }

    @ApiOperation(value = "添加", notes = "添加")
    @Log(modul = "菜单管理-添加", type = Constants.INSERT, desc = "添加")
    @GetMapping("/save")
    @SaCheckPermission("menu:save")
    public Wrapper<Object> save(@RequestBody SysMenu menu) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysMenuService.save(menu));
    }

    @ApiOperation(value = "删除", notes = "删除")
    @Log(modul = "菜单管理-删除", type = Constants.DELETE, desc = "删除")
    @GetMapping("/delete/{id}")
    @SaCheckPermission("menu:delete")
    public Wrapper<Object> delete(@PathVariable String id) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysMenuService.removeById(id));
    }

    @ApiOperation(value = "修改", notes = "修改")
    @Log(modul = "菜单管理-修改", type = Constants.UPDATE, desc = "修改")
    @PostMapping("/update")
    @SaCheckPermission("menu:update")
    public Wrapper<Object> update(@RequestBody SysMenu menu) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysMenuService.updateById(menu));
    }

}
