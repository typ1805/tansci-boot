package com.tansci.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.tansci.domain.LcPagesMenu;
import com.tansci.mapper.LcPagesMenuMapper;
import com.tansci.service.LcPagesMenuService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * @ClassName： LcPagesMenuServiceImpl.java
 * @ClassPath： com.tansci.service.impl.LcPagesMenuServiceImpl.java
 * @Description： 页面菜单关系
 * @Author： tanyp
 * @Date： 2023/5/11 9:07
 **/
@Slf4j
@Service
public class LcPagesMenuServiceImpl extends ServiceImpl<LcPagesMenuMapper, LcPagesMenu> implements LcPagesMenuService {
}
