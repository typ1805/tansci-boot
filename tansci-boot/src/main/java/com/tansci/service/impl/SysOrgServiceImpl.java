package com.tansci.service.impl;

import cn.dev33.satoken.stp.StpUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.google.common.collect.Lists;
import com.tansci.common.constant.Constants;
import com.tansci.common.constant.Enums;
import com.tansci.domain.SysOrg;
import com.tansci.domain.SysRoleOrg;
import com.tansci.domain.vo.SysUserSessionVo;
import com.tansci.mapper.SysOrgMapper;
import com.tansci.service.SysOrgService;
import com.tansci.service.SysRoleOrgService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

/**
 * @ClassName： SysOrgServiceImpl.java
 * @ClassPath： com.tansci.service.impl.SysOrgServiceImpl.java
 * @Description： 组织信息
 * @Author： tanyp
 * @Date： 2023/3/29 9:43
 **/
@Slf4j
@Service
public class SysOrgServiceImpl extends ServiceImpl<SysOrgMapper, SysOrg> implements SysOrgService {

    @Autowired
    private SysRoleOrgService sysRoleOrgService;

    @Override
    public List<SysOrg> list(SysOrg org) {
        List<String> orgIds = Lists.newArrayList();
        SysUserSessionVo userSession = (SysUserSessionVo) StpUtil.getSession().get(StpUtil.getLoginId().toString());
        if (Objects.nonNull(userSession) && Objects.equals(Enums.USER_TYPE_1.getKey(), userSession.getType())) {
            orgIds.addAll(this.baseMapper.selectList(Wrappers.lambdaQuery()).stream().map(SysOrg::getId).collect(Collectors.toList()));
        } else {
            List<SysRoleOrg> menus = sysRoleOrgService.list(Wrappers.<SysRoleOrg>lambdaQuery().
                    in(Objects.nonNull(StpUtil.getRoleList()) && StpUtil.getRoleList().size() > 0, SysRoleOrg::getRoleId, StpUtil.getRoleList())
            );
            orgIds.addAll(menus.stream().map(SysRoleOrg::getOrgId).collect(Collectors.toList()));
        }
        if (Objects.isNull(orgIds) || orgIds.size() == 0) {
            return Lists.newArrayList();
        }

        List<SysOrg> list = this.baseMapper.selectList(
                Wrappers.<SysOrg>lambdaQuery()
                        .eq(SysOrg::getIsDel, Constants.NOT_DEL_FALG)
                        .in(Objects.nonNull(orgIds) && orgIds.size() > 0, SysOrg::getId, orgIds)
                        .eq(Objects.nonNull(org.getParentId()), SysOrg::getParentId, org.getParentId())
                        .eq(Objects.nonNull(org.getCode()), SysOrg::getCode, org.getCode())
                        .like(Objects.nonNull(org.getName()), SysOrg::getName, org.getName())
                        .orderByDesc(SysOrg::getUpdateTime)
        );
        list = list.stream().collect(Collectors.collectingAndThen(Collectors.toCollection(() -> new TreeSet<>(Comparator.comparing(SysOrg::getId))), ArrayList::new));
        Map<String, List<SysOrg>> map = list.stream().collect(Collectors.groupingBy(SysOrg::getParentId, Collectors.toList()));
        list.stream().forEach(item -> item.setChildren(map.get(item.getId())));

        List<SysOrg> orgList = map.get("0").stream().sorted(Comparator.comparing(SysOrg::getSort)).collect(Collectors.toList());
        return orgList;
    }

    @Override
    public Object delete(String id) {
        List<SysOrg> orgs = this.baseMapper.selectList(Wrappers.<SysOrg>lambdaQuery().eq(SysOrg::getParentId, id));
        List<String> ids = Lists.newArrayList(id);
        ids.addAll(orgs.stream().map(SysOrg::getId).collect(Collectors.toList()));
        int row = this.baseMapper.deleteBatchIds(ids);
        if (row > 0) {
            sysRoleOrgService.remove(Wrappers.<SysRoleOrg>lambdaQuery().in(SysRoleOrg::getOrgId, ids));
        }
        return row;
    }

}