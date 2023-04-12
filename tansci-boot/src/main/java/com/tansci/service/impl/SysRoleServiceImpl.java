package com.tansci.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.tansci.common.constant.Constants;
import com.tansci.domain.*;
import com.tansci.mapper.SysRoleMapper;
import com.tansci.service.*;
import com.tansci.utils.UUIDUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @ClassName： SysRoleServiceImpl.java
 * @ClassPath： com.tansci.service.impl.SysRoleServiceImpl.java
 * @Description： 权限信息
 * @Author： tanyp
 * @Date： 2023/3/29 9:44
 **/
@Slf4j
@Service
public class SysRoleServiceImpl extends ServiceImpl<SysRoleMapper, SysRole> implements SysRoleService {

    @Autowired
    private SysRoleMenuService sysRoleMenuService;
    @Autowired
    private SysMenuService sysMenuService;
    @Autowired
    private SysRoleOrgService sysRoleOrgService;
    @Autowired
    private SysOrgService sysOrgService;

    @Override
    public IPage<SysRole> page(Page page, SysRole role) {
        return this.baseMapper.selectPage(page,
                Wrappers.<SysRole>lambdaQuery().eq(SysRole::getIsDel, Constants.NOT_DEL_FALG)
                        .eq(Objects.nonNull(role.getCode()), SysRole::getCode, role.getCode())
                        .eq(Objects.nonNull(role.getCreator()), SysRole::getCreator, role.getCreator())
                        .like(Objects.nonNull(role.getName()), SysRole::getName, role.getName())
                        .orderByDesc(SysRole::getUpdateTime)
        );
    }

    @Override
    public List<SysRole> list(SysRole role) {
        return this.baseMapper.selectList(
                Wrappers.<SysRole>lambdaQuery().eq(SysRole::getIsDel, Constants.NOT_DEL_FALG)
                        .eq(Objects.nonNull(role.getCode()), SysRole::getCode, role.getCode())
                        .eq(Objects.nonNull(role.getCreator()), SysRole::getCreator, role.getCreator())
                        .like(Objects.nonNull(role.getName()), SysRole::getName, role.getName())
                        .orderByDesc(SysRole::getUpdateTime)
        );
    }

    @Override
    public Object insert(SysRole role) {
        role.setCreator(String.valueOf(StpUtil.getLoginId()));
        role.setCode("SR"+UUIDUtils.getUUID(10).toUpperCase());
        role.setIsDel(Constants.NOT_DEL_FALG);
        role.setUpdateTime(LocalDateTime.now());
        role.setCreateTime(LocalDateTime.now());
        return this.baseMapper.insert(role);
    }

    @Override
    public Object update(SysRole role) {
        role.setUpdateTime(LocalDateTime.now());
        return this.baseMapper.updateById(role);
    }

    @Override
    public Object delete(String id) {
        int row = this.baseMapper.deleteById(id);
        if (row > 0) {
            sysRoleMenuService.remove(Wrappers.<SysRoleMenu>lambdaQuery().eq(SysRoleMenu::getRoleId, id));
            sysRoleOrgService.remove(Wrappers.<SysRoleOrg>lambdaQuery().eq(SysRoleOrg::getRoleId, id));
        }
        return row;
    }

    @Override
    public Object dataPermissions(SysRole role) {
        sysRoleOrgService.remove(Wrappers.<SysRoleOrg>lambdaQuery().eq(SysRoleOrg::getRoleId, role.getId()));
        List<SysRoleOrg> orgs = new ArrayList<>();
        role.getOrgIds().forEach(item -> {
            orgs.add(SysRoleOrg.builder().roleId(role.getId()).orgId(item).build());
        });
        return sysRoleOrgService.saveBatch(orgs);
    }

    @Override
    public Object orgList(String roleId) {
        Map<String, Object> map = new HashMap<>();
        map.put("list", sysOrgService.list(SysOrg.builder().build()));

        List<SysRoleOrg> orgs = sysRoleOrgService.list(Wrappers.<SysRoleOrg>lambdaQuery().eq(SysRoleOrg::getRoleId, roleId));
        if (Objects.nonNull(orgs) && orgs.size() > 0) {
            map.put("selected", orgs.stream().map(SysRoleOrg::getOrgId).collect(Collectors.toList()));
        }
        return map;
    }

    @Override
    public Object menuPermissions(SysRole role) {
        sysRoleMenuService.remove(Wrappers.<SysRoleMenu>lambdaQuery().eq(SysRoleMenu::getRoleId, role.getId()));
        List<SysRoleMenu> menus = new ArrayList<>();
        role.getMenuIds().forEach(item -> {
            menus.add(SysRoleMenu.builder().roleId(role.getId()).menuId(item).build());
        });
        return sysRoleMenuService.saveBatch(menus);
    }

    @Override
    public Object menuList(String roleId) {
        Map<String, Object> map = new HashMap<>();
        map.put("list", sysMenuService.tree(SysMenu.builder().build()));

        List<SysRoleMenu> menus = sysRoleMenuService.list(Wrappers.<SysRoleMenu>lambdaQuery().eq(SysRoleMenu::getRoleId, roleId));
        if (Objects.nonNull(menus) && menus.size() > 0) {
            map.put("selected", menus.stream().map(SysRoleMenu::getMenuId).collect(Collectors.toList()));
        }
        return map;
    }
}
