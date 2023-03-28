package com.tansci.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.tansci.common.constant.Constants;
import com.tansci.domain.SysUser;
import com.tansci.common.exception.BusinessException;
import com.tansci.mapper.SysUserMapper;
import com.tansci.service.SysUserService;
import com.tansci.utils.Sha256Util;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

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
    public Integer modifyPass(SysUser user) {
        SysUser sysUser = this.baseMapper.selectOne(Wrappers.<SysUser>lambdaQuery().eq(SysUser::getUsername, user.getUsername()));

        if (Objects.isNull(sysUser) || !Objects.equals(Sha256Util.getSHA256(sysUser.getPassword()), Sha256Util.getSHA256(user.getPassword()))) {
            throw new BusinessException("原始密码错误，请重新输入！");
        }

        sysUser.setPassword(Sha256Util.getSHA256(user.getPassword()));
        sysUser.setUpdateTime(LocalDateTime.now());
        return this.baseMapper.updateById(sysUser);
    }

    @Override
    public boolean save(SysUser user) {
        Integer count = this.baseMapper.selectCount(Wrappers.<SysUser>lambdaQuery().eq(SysUser::getUsername, user.getUsername()));
        if (Objects.nonNull(count) && count > 0) {
            throw new BusinessException("用户名称已存在！");
        }
        user.setIsDel(Constants.NOT_DEL_FALG);
        user.setCreateTime(LocalDateTime.now());
        user.setPassword(Sha256Util.getSHA256(user.getPassword()));
        int row = this.baseMapper.insert(user);
        return false;
    }

    @Override
    public boolean update(SysUser user) {
        user.setUpdateTime(LocalDateTime.now());
        int row = this.baseMapper.updateById(user);
        return false;
    }

    @Override
    public boolean del(SysUser user) {
        user.setIsDel(Constants.IS_DEL_FALG);
        this.baseMapper.updateById(user);
        return false;
    }

    @Override
    public SysUser login(String username) {
        SysUser user = this.baseMapper.selectOne(Wrappers.<SysUser>lambdaQuery().eq(SysUser::getUsername, username));
        if (Objects.nonNull(user)) {
            // 生成token
            StpUtil.login(user.getId());
            // 获取token信息
            return SysUser.builder()
                    .username(user.getUsername())
                    .nickname(user.getNickname())
                    .type(user.getType())
                    .token(StpUtil.getTokenInfo().getTokenValue())
                    .build();
        }
        return null;
    }

}
