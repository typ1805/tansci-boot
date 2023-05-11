package com.tansci.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.tansci.common.exception.BusinessException;
import com.tansci.domain.LcPages;
import com.tansci.domain.LcPagesMenu;
import com.tansci.mapper.LcPagesMapper;
import com.tansci.service.LcPagesMenuService;
import com.tansci.service.LcPagesSerice;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.compress.utils.Lists;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * @ClassName： LcPagesServiceImpl.java
 * @ClassPath： com.tansci.service.impl.LcPagesServiceImpl.java
 * @Description： 页面管理
 * @Author： tanyp
 * @Date： 2023/5/11 8:57
 **/
@Slf4j
@Service
public class LcPagesServiceImpl extends ServiceImpl<LcPagesMapper, LcPages> implements LcPagesSerice {

    @Autowired
    private LcPagesMenuService lcPagesMenuService;

    @Override
    public IPage<LcPages> page(Page page, LcPages pages) {
        IPage<LcPages> iPage = this.baseMapper.selectPage(page,
                Wrappers.<LcPages>lambdaQuery()
                        .eq(Objects.nonNull(pages.getStatus()), LcPages::getStatus, pages.getStatus())
                        .eq(Objects.nonNull(pages.getParentId()), LcPages::getParentId, pages.getParentId())
                        .eq(Objects.nonNull(pages.getCreatorId()), LcPages::getCreatorId, pages.getCreatorId())
                        .like(Objects.nonNull(pages.getTitle()), LcPages::getTitle, pages.getTitle())
                        .orderByDesc(LcPages::getUpdateTime)
        );

        if (Objects.nonNull(iPage.getRecords()) && iPage.getRecords().size() > 0) {
            List<LcPagesMenu> menus = lcPagesMenuService.list(Wrappers.<LcPagesMenu>lambdaQuery().in(LcPagesMenu::getPagesId, iPage.getRecords().stream().map(LcPages::getId).collect(Collectors.toList())));
            iPage.getRecords().forEach(item -> {
                item.setMenuIds(menus.stream().filter(i -> Objects.equals(i.getPagesId(), item.getId())).map(LcPagesMenu::getMenuId).collect(Collectors.toList()));
            });
        }

        return iPage;
    }

    @Override
    public LcPages getPagesInfo(String menuId) {
        LcPagesMenu pagesMenu = lcPagesMenuService.getOne(Wrappers.<LcPagesMenu>lambdaQuery().eq(LcPagesMenu::getMenuId, menuId));
        if (Objects.isNull(pagesMenu)) {
            throw new BusinessException("该菜单未绑定页面");
        }
        return this.baseMapper.selectById(pagesMenu.getPagesId());
    }

    @Override
    @Transactional
    public Object bindMenu(LcPages pages) {
        lcPagesMenuService.remove(Wrappers.<LcPagesMenu>lambdaQuery().eq(LcPagesMenu::getPagesId, pages.getId()));
        if (Objects.nonNull(pages.getMenuIds()) && pages.getMenuIds().size() > 0) {
            lcPagesMenuService.remove(Wrappers.<LcPagesMenu>lambdaQuery().in(LcPagesMenu::getMenuId, pages.getMenuIds()));
            List<LcPagesMenu> menus = Lists.newArrayList();
            pages.getMenuIds().forEach(item -> {
                menus.add(
                        LcPagesMenu.builder().pagesId(pages.getId()).menuId(item).build()
                );
            });
            lcPagesMenuService.saveBatch(menus);
        }
        return "ok";
    }

    @Override
    @Transactional
    public Object delete(String id) {
        lcPagesMenuService.remove(Wrappers.<LcPagesMenu>lambdaQuery().eq(LcPagesMenu::getPagesId, id));
        return this.baseMapper.deleteById(id);
    }

    @Override
    @Transactional
    public Object batchDelete(LcPages pages) {
        lcPagesMenuService.remove(Wrappers.<LcPagesMenu>lambdaQuery().in(LcPagesMenu::getPagesId, pages.getIds()));
        return this.baseMapper.deleteBatchIds(pages.getIds());
    }

}
