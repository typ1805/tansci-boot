package com.tansci.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.tansci.domain.LcPages;

/**
 * @ClassName： LcPagesSerice.java
 * @ClassPath： com.tansci.service.LcPagesSerice.java
 * @Description： 页面管理
 * @Author： tanyp
 * @Date： 2023/5/11 8:56
 **/
public interface LcPagesSerice extends IService<LcPages> {

    IPage<LcPages> page(Page page, LcPages pages);

    LcPages getPagesInfo(String menuId);

    Object bindMenu(LcPages pages);

    Object delete(String id);

    Object batchDelete(LcPages pages);

}
