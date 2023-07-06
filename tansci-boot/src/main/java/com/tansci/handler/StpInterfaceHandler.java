//package com.tansci.handler;
//
//import cn.dev33.satoken.stp.StpInterface;
//import cn.dev33.satoken.stp.StpUtil;
//import com.baomidou.mybatisplus.core.toolkit.Wrappers;
//import com.tansci.common.constant.Constants;
//import com.tansci.common.constant.Enums;
//import com.tansci.domain.SysMenu;
//import com.tansci.domain.SysRoleMenu;
//import com.tansci.domain.SysUserRole;
//import com.tansci.domain.vo.SysUserSessionVo;
//import com.tansci.service.SysMenuService;
//import com.tansci.service.SysRoleMenuService;
//import com.tansci.service.SysUserRoleService;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Component;
//
//import java.util.List;
//import java.util.Objects;
//import java.util.stream.Collectors;
//
///**
// * @ClassName： StpInterfaceHandler.java
// * @ClassPath： com.tansci.handler.StpInterfaceHandler.java
// * @Description： 自定义权限验证
// * @Author： tanyp
// * @Date： 2023/4/7 15:07
// **/
//@Component
//public class StpInterfaceHandler implements StpInterface {
//
//    @Autowired
//    private SysUserRoleService sysUserRoleService;
//    @Autowired
//    private SysRoleMenuService sysRoleMenuService;
//    @Autowired
//    private SysMenuService sysMenuService;
//
//    /**
//     * @MonthName： getPermissionList
//     * @Description： 返回一个账号所拥有的权限码集合
//     * @Author： tanyp
//     * @Date： 2023/4/7 15:08
//     * @Param： [o, s]
//     * @return： java.util.List<java.lang.String>
//     **/
//    @Override
//    public List<String> getPermissionList(Object loginId, String loginType) {
//        SysUserSessionVo userSession = (SysUserSessionVo) StpUtil.getSession().get(StpUtil.getLoginId().toString());
//        if (Objects.nonNull(userSession)) {
//            if (Objects.nonNull(StpUtil.getSession().get(Constants.PERMISSION_KEY))) {
//                return (List<String>) StpUtil.getSession().get(Constants.PERMISSION_KEY);
//            }
//
//            if (Objects.equals(Enums.USER_TYPE_1.getKey(), userSession.getType())) {
//                List<SysMenu> menus = sysMenuService.list(
//                        Wrappers.<SysMenu>lambdaQuery()
//                                .eq(SysMenu::getIsDel, Constants.NOT_DEL_FALG)
//                                .ne(SysMenu::getPermission, "")
//                                .isNotNull(SysMenu::getPermission)
//                );
//                List<String> permissions = menus.stream().map(SysMenu::getPermission).collect(Collectors.toList());
//                StpUtil.getSession().set(Constants.PERMISSION_KEY, permissions);
//                return permissions;
//            } else {
//                List<SysUserRole> roles = sysUserRoleService.list(Wrappers.<SysUserRole>lambdaQuery().eq(SysUserRole::getUserId, StpUtil.getLoginId()));
//                if (Objects.nonNull(roles) && roles.size() > 0) {
//                    List<String> roleIds = roles.stream().map(SysUserRole::getRoleId).collect(Collectors.toList());
//                    List<SysRoleMenu> roleMenus = sysRoleMenuService.list(Wrappers.<SysRoleMenu>lambdaQuery().in(SysRoleMenu::getRoleId, roleIds));
//                    if (Objects.nonNull(roleMenus) && roleMenus.size() > 0) {
//                        List<SysMenu> menus = sysMenuService.list(
//                                Wrappers.<SysMenu>lambdaQuery()
//                                        .in(SysMenu::getId, roleMenus.stream().map(SysRoleMenu::getMenuId).collect(Collectors.toList()))
//                                        .eq(SysMenu::getIsDel, Constants.NOT_DEL_FALG)
//                                        .ne(SysMenu::getPermission, "")
//                                        .isNotNull(SysMenu::getPermission)
//                        );
//                        List<String> permissions = menus.stream().map(SysMenu::getPermission).collect(Collectors.toList());
//                        StpUtil.getSession().set(Constants.PERMISSION_KEY, permissions);
//                        return permissions;
//                    }
//                }
//            }
//        }
//        return null;
//    }
//
//    /**
//     * @MonthName： getRoleList
//     * @Description： 返回一个账号所拥有的角色标识集合 (权限与角色可分开校验)
//     * @Author： tanyp
//     * @Date： 2023/4/7 15:08
//     * @Param： [o, s]
//     * @return： java.util.List<java.lang.String>
//     **/
//    @Override
//    public List<String> getRoleList(Object loginId, String loginType) {
//        SysUserSessionVo userSession = (SysUserSessionVo) StpUtil.getSession().get(StpUtil.getLoginId().toString());
//        if (Objects.nonNull(userSession)) {
//            if (Objects.nonNull(StpUtil.getSession().get(Constants.ROLE_KEY))) {
//                return (List<String>) StpUtil.getSession().get(Constants.ROLE_KEY);
//            }
//
//            if (Objects.equals(Enums.USER_TYPE_1.getKey(), userSession.getType())) {
//                List<String> roleIds = sysUserRoleService.list().stream().map(SysUserRole::getRoleId).collect(Collectors.toList());
//                StpUtil.getSession().set(Constants.ROLE_KEY, roleIds);
//                return roleIds;
//            } else {
//                List<SysUserRole> roles = sysUserRoleService.list(Wrappers.<SysUserRole>lambdaQuery().eq(SysUserRole::getUserId, StpUtil.getLoginId()));
//                if (Objects.nonNull(roles) && roles.size() > 0) {
//                    List<String> roleIds = roles.stream().map(SysUserRole::getRoleId).collect(Collectors.toList());
//                    StpUtil.getSession().set(Constants.ROLE_KEY, roleIds);
//                    return roleIds;
//                }
//            }
//        }
//        return null;
//    }
//}
