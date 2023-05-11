package com.tansci.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.google.common.collect.Lists;
import com.tansci.common.constant.Constants;
import com.tansci.common.constant.Enums;
import com.tansci.domain.SysMenu;
import com.tansci.domain.SysRoleMenu;
import com.tansci.domain.vo.SysMenuVo;
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
        List<String> menuIds = Lists.newArrayList();
        SysUserSessionVo userSession = (SysUserSessionVo) StpUtil.getSession().get(StpUtil.getLoginId().toString());
        if (Objects.nonNull(userSession) && Objects.equals(Enums.USER_TYPE_1.getKey(), userSession.getType())) {
            menuIds.addAll(this.list().stream().map(SysMenu::getId).collect(Collectors.toList()));
        } else {
            List<SysRoleMenu> menus = sysRoleMenuService.list(Wrappers.<SysRoleMenu>lambdaQuery().
                    in(Objects.nonNull(StpUtil.getRoleList()) && StpUtil.getRoleList().size() > 0, SysRoleMenu::getRoleId, StpUtil.getRoleList())
            );
            menuIds.addAll(menus.stream().map(SysRoleMenu::getMenuId).collect(Collectors.toList()));
        }
        if (Objects.isNull(menuIds) || menuIds.size() == 0) {
            return Lists.newArrayList();
        }

        List<SysMenu> list = this.baseMapper.selectList(
                Wrappers.<SysMenu>lambdaQuery()
                        .eq(SysMenu::getIsDel, Constants.NOT_DEL_FALG)
                        .in(Objects.nonNull(menuIds) && menuIds.size() > 0, SysMenu::getId, menuIds)
                        .eq(Objects.nonNull(menu.getParentId()), SysMenu::getParentId, menu.getParentId())
                        .eq(Objects.nonNull(menu.getIsShow()), SysMenu::getIsShow, menu.getIsShow())
                        .like(Objects.nonNull(menu.getName()), SysMenu::getName, menu.getName())
                        .like(Objects.nonNull(menu.getChineseName()), SysMenu::getChineseName, menu.getChineseName())
                        .orderByDesc(SysMenu::getUpdateTime)
        );

        if (Objects.isNull(list) || list.size() == 0) {
            return Lists.newArrayList();
        }

        list = list.stream().collect(Collectors.collectingAndThen(Collectors.toCollection(() -> new TreeSet<>(Comparator.comparing(SysMenu::getId))), ArrayList::new));
        Map<String, List<SysMenu>> map = list.stream().collect(Collectors.groupingBy(SysMenu::getParentId, Collectors.toList()));
        list.stream().forEach(item -> item.setChildren(map.get(item.getId())));

        List<SysMenu> menuList = map.get("0").stream().sorted(Comparator.comparing(SysMenu::getSort)).collect(Collectors.toList());
        return menuList;
    }

    @Override
    public List<SysMenuVo> menus() {
        List<String> menuIds = Lists.newArrayList();
        SysUserSessionVo userSession = (SysUserSessionVo) StpUtil.getSession().get(StpUtil.getLoginId().toString());
        if (Objects.nonNull(userSession) && Objects.equals(Enums.USER_TYPE_1.getKey(), userSession.getType())) {
            menuIds.addAll(this.list().stream().map(SysMenu::getId).collect(Collectors.toList()));
        } else {
            List<SysRoleMenu> menus = sysRoleMenuService.list(Wrappers.<SysRoleMenu>lambdaQuery().
                    in(Objects.nonNull(StpUtil.getRoleList()) && StpUtil.getRoleList().size() > 0, SysRoleMenu::getRoleId, StpUtil.getRoleList())
            );
            menuIds.addAll(menus.stream().map(SysRoleMenu::getMenuId).collect(Collectors.toList()));
        }
        if (Objects.isNull(menuIds) || menuIds.size() == 0) {
            return Lists.newArrayList();
        }

        List<SysMenu> list = this.baseMapper.selectList(
                Wrappers.<SysMenu>lambdaQuery()
                        .eq(SysMenu::getIsDel, Constants.NOT_DEL_FALG)
                        .eq(SysMenu::getIsShow, 1)
                        .in(Objects.nonNull(menuIds) && menuIds.size() > 0, SysMenu::getId, menuIds)
                        .orderByAsc(SysMenu::getSort)
        );

        if (Objects.isNull(list) || list.size() == 0) {
            return Lists.newArrayList();
        }

        List<SysMenuVo> newList = new ArrayList<>();
        for (SysMenu menu : list) {
            Map<String, Object> meta = new HashMap<>();
            meta.put("title", menu.getChineseName());
            meta.put("keepAlive", Objects.equals(1, menu.getKeepAlive()) ? true : false);
            meta.put("isShow", Objects.equals(1, menu.getIsShow()) ? true : false);
            meta.put("id", menu.getId());
            meta.put("openMode", menu.getOpenMode());
            meta.put("type", menu.getComponentType());
            newList.add(
                    SysMenuVo.builder()
                            .id(menu.getId())
                            .parentId(menu.getParentId())
                            .name(menu.getName())
                            .path(menu.getUrl())
                            .icon(menu.getIcon())
                            .sort(menu.getSort())
                            .component(Objects.nonNull(menu.getComponent()) && menu.getComponent().length() > 0 ? menu.getComponent() : "Layout")
                            .componentType(menu.getComponentType())
                            .isShow(Objects.equals(1, menu.getIsShow()) ? true : false)
                            .meta(meta)
                            .build()
            );
        }

        newList = newList.stream().collect(Collectors.collectingAndThen(Collectors.toCollection(() -> new TreeSet<>(Comparator.comparing(SysMenuVo::getId))), ArrayList::new));
        Map<String, List<SysMenuVo>> map = newList.stream().collect(Collectors.groupingBy(SysMenuVo::getParentId, Collectors.toList()));
        newList.stream().forEach(item -> item.setChildren(map.get(item.getId())));

        List<SysMenuVo> menuList = map.get("0").stream().sorted(Comparator.comparing(SysMenuVo::getSort)).collect(Collectors.toList());
        return menuList;
    }

    @Override
    public Object delete(String id) {
        List<SysMenu> menus = this.baseMapper.selectList(Wrappers.<SysMenu>lambdaQuery().eq(SysMenu::getParentId, id));
        List<String> ids = Lists.newArrayList(id);
        ids.addAll(menus.stream().map(SysMenu::getId).collect(Collectors.toList()));
        int row = this.baseMapper.deleteBatchIds(ids);
        if (row > 0) {
            sysRoleMenuService.remove(Wrappers.<SysRoleMenu>lambdaQuery().in(SysRoleMenu::getMenuId, ids));
        }
        return row;
    }

}
