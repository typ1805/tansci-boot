package com.tansci.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.tansci.common.WrapMapper;
import com.tansci.common.Wrapper;
import com.tansci.common.annotation.Log;
import com.tansci.common.constant.Constants;
import com.tansci.domain.SysDict;
import com.tansci.service.SysDictService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

/**
 * @ClassName： SysDictController.java
 * @ClassPath： com.tansci.controller.SysDictController.java
 * @Description： 字典管理
 * @Author： tanyp
 * @Date： 2023/3/29 9:45
 **/
@Slf4j
@RestController
@RequestMapping("/sysdict")
@Api(value = "sysdict", tags = "字典管理")
public class SysDictController {

    @Autowired
    private SysDictService sysDictService;

    @ApiOperation(value = "列表", notes = "列表")
    @Log(modul = "字典管理-列表", type = Constants.SELECT, desc = "列表")
    @GetMapping("/list")
    @SaCheckPermission("dict:list")
    public Wrapper<List<SysDict>> list(SysDict dict) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysDictService.list(dict));
    }

    @ApiOperation(value = "添加", notes = "添加")
    @Log(modul = "字典管理-添加", type = Constants.INSERT, desc = "添加")
    @PostMapping("/save")
    @SaCheckPermission("dict:save")
    public Wrapper<Object> save(@RequestBody SysDict dict) {
        dict.setUpdateTime(LocalDateTime.now());
        dict.setCreateTime(LocalDateTime.now());
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysDictService.save(dict));
    }

    @ApiOperation(value = "删除", notes = "删除")
    @Log(modul = "字典管理-删除", type = Constants.DELETE, desc = "删除")
    @GetMapping("/delete/{id}")
    @SaCheckPermission("dict:delete")
    public Wrapper<Object> delete(@PathVariable String id) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysDictService.delete(id));
    }

    @ApiOperation(value = "修改", notes = "修改")
    @Log(modul = "字典管理-修改", type = Constants.UPDATE, desc = "修改")
    @PostMapping("/update")
    @SaCheckPermission("dict:update")
    public Wrapper<Object> update(@RequestBody SysDict dict) {
        dict.setUpdateTime(LocalDateTime.now());
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysDictService.updateById(dict));
    }

}
