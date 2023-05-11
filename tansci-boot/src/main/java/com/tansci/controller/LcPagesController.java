package com.tansci.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.dev33.satoken.stp.StpUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.tansci.common.WrapMapper;
import com.tansci.common.Wrapper;
import com.tansci.common.annotation.Log;
import com.tansci.common.constant.Constants;
import com.tansci.domain.LcPages;
import com.tansci.service.LcPagesSerice;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

/**
 * @ClassName： LcPagesController.java
 * @ClassPath： com.tansci.controller.LcPagesController.java
 * @Description： 页面管理
 * @Author： tanyp
 * @Date： 2023/5/11 8:57
 **/
@Slf4j
@RestController
@RequestMapping("/lcPages")
@Api(value = "lcPages", tags = "页面管理")
public class LcPagesController {

    @Autowired
    private LcPagesSerice lcPagesSerice;

    @ApiOperation(value = "分页", notes = "分页")
    @Log(modul = "页面管理", type = Constants.SELECT, desc = "分页")
    @GetMapping("/page")
    public Wrapper<IPage<LcPages>> page(Page page, LcPages pages) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, lcPagesSerice.page(page, pages));
    }

    @ApiOperation(value = "根据ID获取页面信息", notes = "根据ID获取页面信息")
    @Log(modul = "页面管理", type = Constants.SELECT, desc = "根据ID获取页面信息")
    @GetMapping("/get/{id}")
    public Wrapper<LcPages> getById(@PathVariable("id") String id) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, lcPagesSerice.getById(id));
    }

    @ApiOperation(value = "根据菜单ID获取页面信息", notes = "根据菜单ID获取页面信息")
    @Log(modul = "页面管理", type = Constants.SELECT, desc = "根据菜单ID获取页面信息")
    @GetMapping("/getPagesInfo/{menuId}")
    public Wrapper<LcPages> getPagesInfo(@PathVariable("menuId") String menuId) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, lcPagesSerice.getPagesInfo(menuId));
    }

    @ApiOperation(value = "添加", notes = "添加")
    @Log(modul = "页面管理", type = Constants.INSERT, desc = "添加")
    @PostMapping("/save")
    @SaCheckPermission("pages:save")
    public Wrapper<Object> save(@RequestBody LcPages pages) {
        pages.setCreatorId(String.valueOf(StpUtil.getLoginId()));
        pages.setUpdateTime(LocalDateTime.now());
        pages.setCreateTime(LocalDateTime.now());
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, lcPagesSerice.save(pages));
    }

    @ApiOperation(value = "修改", notes = "修改")
    @Log(modul = "页面管理", type = Constants.UPDATE, desc = "修改")
    @PostMapping("/update")
    @SaCheckPermission("pages:update")
    public Wrapper<Object> update(@RequestBody LcPages pages) {
        pages.setUpdateTime(LocalDateTime.now());
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, lcPagesSerice.updateById(pages));
    }

    @ApiOperation(value = "删除", notes = "删除")
    @Log(modul = "页面管理", type = Constants.DELETE, desc = "删除")
    @GetMapping("/delete/{id}")
    @SaCheckPermission("pages:delete")
    public Wrapper<Object> delete(@PathVariable String id) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, lcPagesSerice.delete(id));
    }

    @ApiOperation(value = "批量删除", notes = "批量删除")
    @Log(modul = "页面管理", type = Constants.DELETE, desc = "批量删除")
    @PostMapping("/batchDelete")
    @SaCheckPermission("pages:delete")
    public Wrapper<Object> batchDelete(@RequestBody LcPages pages) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, lcPagesSerice.batchDelete(pages));
    }

    @ApiOperation(value = "绑定菜单", notes = "绑定菜单")
    @Log(modul = "页面管理", type = Constants.DELETE, desc = "绑定菜单")
    @PostMapping("/bindMenu")
    @SaCheckPermission("pages:update")
    public Wrapper<Object> bindMenu(@RequestBody LcPages pages) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, lcPagesSerice.bindMenu(pages));
    }

}
