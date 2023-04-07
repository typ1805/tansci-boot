package com.tansci.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.google.common.collect.Lists;
import com.tansci.common.constant.Constants;
import com.tansci.common.exception.BusinessException;
import com.tansci.domain.SysLoginLog;
import com.tansci.domain.SysUser;
import com.tansci.domain.SysUserRole;
import com.tansci.domain.vo.SysUserSessionVo;
import com.tansci.domain.vo.SysUserVo;
import com.tansci.mapper.SysUserMapper;
import com.tansci.service.SysLoginLogService;
import com.tansci.service.SysUserRoleService;
import com.tansci.service.SysUserService;
import com.tansci.utils.Sha256Util;
import com.tansci.utils.SystemUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * @ClassName： SysUserServiceImpl.java
 * @ClassPath： com.tansci.service.impl.SysUserServiceImpl.java
 * @Description： 用户信息
 * @Author： tanyp
 * @Date： 2023/3/20 15:51
 **/
@Slf4j
@Service
public class SysUserServiceImpl extends ServiceImpl<SysUserMapper, SysUser> implements SysUserService {

    @Autowired
    private SysUserRoleService sysUserRoleService;
    @Autowired
    private SysLoginLogService sysLoginLogService;

    @Override
    public IPage<SysUser> page(Page page, SysUser user) {
        return this.baseMapper.selectPage(page,
                Wrappers.<SysUser>lambdaQuery()
                        .eq(SysUser::getIsDel, Constants.NOT_DEL_FALG)
                        .eq(Objects.nonNull(user.getUsername()), SysUser::getUsername, user.getUsername())
                        .eq(Objects.nonNull(user.getPhone()), SysUser::getPhone, user.getPhone())
                        .eq(Objects.nonNull(user.getNickname()), SysUser::getNickname, user.getNickname())
                        .eq(Objects.nonNull(user.getType()), SysUser::getType, user.getType())
        );
    }

    @Override
    public List<SysUser> list(SysUser user) {
        return this.baseMapper.selectList(
                Wrappers.<SysUser>lambdaQuery()
                        .eq(SysUser::getIsDel, Constants.NOT_DEL_FALG)
                        .eq(Objects.nonNull(user.getType()), SysUser::getType, user.getType())
        );
    }

    @Override
    public Object insert(SysUser user) {
        Integer count = this.baseMapper.selectCount(Wrappers.<SysUser>lambdaQuery().eq(SysUser::getUsername, user.getUsername()));
        if (Objects.nonNull(count) && count > 0) {
            throw new BusinessException("用户名称已存在！");
        }
        user.setIsDel(Constants.NOT_DEL_FALG);
        user.setCreateTime(LocalDateTime.now());
        user.setPassword(Sha256Util.getSHA256(user.getPassword()));
        int rows = this.baseMapper.insert(user);
        if (rows > 0) {
            // 添加权限
            List<SysUserRole> userRoles = Lists.newArrayList();
            user.getRoleIds().forEach(item -> {
                userRoles.add(SysUserRole.builder().userId(user.getId()).roleId(item).build());
            });
            sysUserRoleService.saveBatch(userRoles);
        }
        return rows;
    }

    @Override
    public Object update(SysUser user) {
        user.setUpdateTime(LocalDateTime.now());
        return this.baseMapper.updateById(user);
    }

    @Override
    public Object del(SysUser user) {
        user.setIsDel(Constants.IS_DEL_FALG);
        int rows = this.baseMapper.updateById(user);
        if (rows > 0) {
            sysUserRoleService.remove(Wrappers.<SysUserRole>lambdaQuery().eq(SysUserRole::getUserId, user.getId()));
        }
        return rows;
    }

    @Override
    public SysUserVo login(HttpServletRequest request, SysUser user) {
        SysLoginLog loginLog = SysLoginLog.builder()
                .username(user.getUsername())
                .failPassword(user.getPassword())
                .type("成功")
                .ip(SystemUtils.getIp(request))
                .address(SystemUtils.getAddress(request))
                .browser(SystemUtils.getBrowser(request))
                .os(SystemUtils.getOS(request))
                .build();

        try {
            // 校验验证码
            String code = (String) request.getSession().getAttribute("verifyCode");
            if (Objects.isNull(user.getCode()) || !Objects.equals(code, user.getCode())) {
                loginLog.setType("失败");
                throw new BusinessException("验证码有误，请重新获取！");
            }

            SysUser sysUser = this.baseMapper.selectOne(Wrappers.<SysUser>lambdaQuery().eq(SysUser::getUsername, user.getUsername()));
            if (Objects.isNull(sysUser) && !Objects.equals(sysUser.getPassword(), Sha256Util.getSHA256(user.getPassword()))) {
                loginLog.setType("失败");
                throw new BusinessException("登录失败，用户名或密码有误！");
            }

            // 生成token
            StpUtil.login(sysUser.getId());
            // 登录日志记录
            loginLog.setToken(StpUtil.getTokenInfo().getTokenValue());

            // 用户角色到session
            List<SysUserRole> roles = sysUserRoleService.list(Wrappers.<SysUserRole>lambdaQuery().eq(SysUserRole::getUserId, sysUser.getId()));
            if (Objects.nonNull(roles) && roles.size() > 0) {
                StpUtil.getSession().set(sysUser.getId(),
                        SysUserSessionVo.builder()
                                .id(sysUser.getId())
                                .username(sysUser.getUsername())
                                .nickname(sysUser.getNickname())
                                .type(sysUser.getType())
                                .roleIds(roles.stream().map(SysUserRole::getRoleId).collect(Collectors.toList()))
                                .build()
                );
            }

            return SysUserVo.builder()
                    .username(sysUser.getUsername())
                    .nickname(sysUser.getNickname())
                    .type(sysUser.getType())
                    .avatar(sysUser.getAvatar())
                    .loginTime(LocalDateTime.now())
                    .token(StpUtil.getTokenInfo().getTokenValue())
                    .build();
        } finally {
            sysLoginLogService.save(loginLog);
        }
    }

    @Override
    public Object modifyPass(SysUser user) {
        SysUser sysUser = this.baseMapper.selectOne(Wrappers.<SysUser>lambdaQuery().eq(SysUser::getUsername, user.getUsername()));

        if (Objects.isNull(sysUser) || !Objects.equals(Sha256Util.getSHA256(sysUser.getPassword()), Sha256Util.getSHA256(user.getPassword()))) {
            throw new BusinessException("原始密码错误，请重新输入！");
        }

        sysUser.setPassword(Sha256Util.getSHA256(user.getPassword()));
        sysUser.setUpdateTime(LocalDateTime.now());
        return this.baseMapper.updateById(sysUser);
    }

}
