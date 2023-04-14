package com.tansci.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.google.common.collect.Lists;
import com.tansci.domain.SysDict;
import com.tansci.mapper.SysDictMapper;
import com.tansci.service.SysDictService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

/**
 * @ClassName： SysDictServiceImpl.java
 * @ClassPath： com.tansci.service.impl.SysDictServiceImpl.java
 * @Description： 字典信息
 * @Author： tanyp
 * @Date： 2023/3/29 9:39
 **/
@Slf4j
@Service
public class SysDictServiceImpl extends ServiceImpl<SysDictMapper, SysDict> implements SysDictService {

    @Override
    public List<SysDict> tree(SysDict dict) {
        List<SysDict> list = this.baseMapper.selectList(
                Wrappers.<SysDict>lambdaQuery()
                        .eq(Objects.nonNull(dict.getParentId()), SysDict::getParentId, dict.getParentId())
                        .eq(Objects.nonNull(dict.getGroupName()), SysDict::getGroupName, dict.getGroupName())
                        .eq(Objects.nonNull(dict.getDicValue()), SysDict::getDicValue, dict.getDicValue())
                        .orderByDesc(SysDict::getUpdateTime)
        );
        list = list.stream().collect(Collectors.collectingAndThen(Collectors.toCollection(() -> new TreeSet<>(Comparator.comparing(SysDict::getId))), ArrayList::new));
        Map<String, List<SysDict>> map = list.stream().collect(Collectors.groupingBy(SysDict::getParentId, Collectors.toList()));
        list.stream().forEach(item -> item.setChildren(map.get(item.getId())));

        List<SysDict> orgList = map.get("0").stream().sorted(Comparator.comparing(SysDict::getSort)).collect(Collectors.toList());
        return orgList;
    }

    @Override
    public List<SysDict> list(SysDict dict) {
        return this.baseMapper.selectList(
                Wrappers.<SysDict>lambdaQuery()
                        .eq(Objects.nonNull(dict.getParentId()), SysDict::getParentId, dict.getParentId())
                        .eq(Objects.nonNull(dict.getGroupName()), SysDict::getGroupName, dict.getGroupName())
                        .eq(Objects.nonNull(dict.getDicValue()), SysDict::getDicValue, dict.getDicValue())
                        .orderByDesc(SysDict::getUpdateTime)
        );
    }

    @Override
    public Object delete(String id) {
        List<SysDict> orgs = this.baseMapper.selectList(Wrappers.<SysDict>lambdaQuery().eq(SysDict::getParentId, id));
        List<String> ids = Lists.newArrayList(id);
        ids.addAll(orgs.stream().map(SysDict::getId).collect(Collectors.toList()));
        return this.baseMapper.deleteBatchIds(ids);
    }

}
