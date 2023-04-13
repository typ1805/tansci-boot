package com.tansci.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.tansci.common.WrapMapper;
import com.tansci.common.Wrapper;
import com.tansci.common.annotation.Log;
import com.tansci.common.constant.Constants;
import com.tansci.domain.SysOrg;
import com.tansci.service.SysOrgService;
import com.tansci.utils.UUIDUtils;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

/**
 * @ClassName： SysOrgController.java
 * @ClassPath： com.tansci.controller.SysOrgController.java
 * @Description： 组织管理
 * @Author： tanyp
 * @Date： 2023/3/29 9:46
 **/
@Slf4j
@RestController
@RequestMapping("/sysorg")
@Api(value = "sysorg", tags = "组织管理")
public class SysOrgController {

    @Autowired
    private SysOrgService sysOrgService;

    @ApiOperation(value = "列表", notes = "列表")
    @Log(modul = "组织管理-列表", type = Constants.SELECT, desc = "列表")
    @GetMapping("/list")
    @SaCheckPermission("org:list")
    public Wrapper<List<SysOrg>> list(SysOrg org) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysOrgService.list(org));
    }

    @ApiOperation(value = "添加", notes = "添加")
    @Log(modul = "组织管理-添加", type = Constants.INSERT, desc = "添加")
    @PostMapping("/save")
    @SaCheckPermission("org:save")
    public Wrapper<Object> save(@RequestBody SysOrg org) {
        org.setCode("SO" + UUIDUtils.getUUID(10).toUpperCase());
        org.setIsDel(Constants.NOT_DEL_FALG);
        org.setUpdateTime(LocalDateTime.now());
        org.setCreateTime(LocalDateTime.now());
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysOrgService.save(org));
    }

    @ApiOperation(value = "删除", notes = "删除")
    @Log(modul = "组织管理-删除", type = Constants.DELETE, desc = "删除")
    @GetMapping("/delete/{id}")
    @SaCheckPermission("org:delete")
    public Wrapper<Object> delete(@PathVariable String id) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysOrgService.delete(id));
    }

    @ApiOperation(value = "修改", notes = "修改")
    @Log(modul = "组织管理-修改", type = Constants.UPDATE, desc = "修改")
    @PostMapping("/update")
    @SaCheckPermission("org:update")
    public Wrapper<Object> update(@RequestBody SysOrg org) {
        org.setUpdateTime(LocalDateTime.now());
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, sysOrgService.updateById(org));
    }

}
