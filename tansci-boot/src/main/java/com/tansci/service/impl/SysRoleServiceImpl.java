package com.tansci.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.tansci.common.constant.Constants;
import com.tansci.domain.SysRole;
import com.tansci.domain.SysRoleMenu;
import com.tansci.domain.SysRoleOrg;
import com.tansci.mapper.SysRoleMapper;
import com.tansci.service.SysRoleMenuService;
import com.tansci.service.SysRoleOrgService;
import com.tansci.service.SysRoleService;
import com.tansci.utils.UUIDUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

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
    private SysRoleOrgService sysRoleOrgService;

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
        role.setCode(UUIDUtils.getUUID(10));
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
    public Object menuPermissions(SysRole role) {
        sysRoleMenuService.remove(Wrappers.<SysRoleMenu>lambdaQuery().eq(SysRoleMenu::getRoleId, role.getId()));
        List<SysRoleMenu> menus = new ArrayList<>();
        role.getOrgIds().forEach(item -> {
            menus.add(SysRoleMenu.builder().roleId(role.getId()).menuId(item).build());
        });
        return sysRoleMenuService.saveBatch(menus);
    }

}
