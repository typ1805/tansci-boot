package com.tansci.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.google.common.collect.Lists;
import com.tansci.common.constant.Constants;
import com.tansci.domain.SysMenu;
import com.tansci.domain.SysRoleMenu;
import com.tansci.domain.vo.SysUserSessionVo;
import com.tansci.mapper.SysMenuMapper;
import com.tansci.service.SysMenuService;
import com.tansci.service.SysRoleMenuService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

/**
 * @ClassName： SysMenuServiceImpl.java
 * @ClassPath： com.tansci.service.impl.SysMenuServiceImpl.java
 * @Description： 菜单信息
 * @Author： tanyp
 * @Date： 2023/3/29 9:41
 **/
@Slf4j
@Service
public class SysMenuServiceImpl extends ServiceImpl<SysMenuMapper, SysMenu> implements SysMenuService {

    @Autowired
    private SysRoleMenuService sysRoleMenuService;

    @Override
    public List<SysMenu> tree(SysMenu menu) {
        // 菜单权限
        String userId = String.valueOf(StpUtil.getLoginId());
        SysUserSessionVo sessionVo = (SysUserSessionVo) StpUtil.getSession().get(userId);
        List<String> menuIds = Lists.newArrayList();
        if (Objects.nonNull(sessionVo) && Objects.nonNull(sessionVo.getRoleIds()) && sessionVo.getRoleIds().size() > 0) {
            List<SysRoleMenu> menus = sysRoleMenuService.list(Wrappers.<SysRoleMenu>lambdaQuery().eq(SysRoleMenu::getRoleId, sessionVo.getRoleIds()));
            menuIds.addAll(menus.stream().map(SysRoleMenu::getMenuId).collect(Collectors.toList()));
        }

        List<SysMenu> list = this.baseMapper.selectList(
                Wrappers.<SysMenu>lambdaQuery()
                        .eq(SysMenu::getIsDel, Constants.NOT_DEL_FALG)
                        .eq(Objects.nonNull(menuIds) && menuIds.size() > 0, SysMenu::getId, menuIds)
                        .eq(Objects.nonNull(menu.getParentId()), SysMenu::getParentId, menu.getParentId())
                        .like(Objects.nonNull(menu.getName()), SysMenu::getName, menu.getName())
                        .like(Objects.nonNull(menu.getChineseName()), SysMenu::getChineseName, menu.getChineseName())
                        .orderByDesc(SysMenu::getUpdateTime)
        );
        list = list.stream().collect(Collectors.collectingAndThen(Collectors.toCollection(() -> new TreeSet<>(Comparator.comparing(SysMenu::getId))), ArrayList::new));
        Map<String, List<SysMenu>> map = list.stream().collect(Collectors.groupingBy(SysMenu::getParentId, Collectors.toList()));
        list.stream().forEach(item -> item.setChildren(map.get(item.getId())));

        List<SysMenu> menuList = map.get("0").stream().sorted(Comparator.comparing(SysMenu::getSort)).collect(Collectors.toList());
        return menuList;
    }

}
