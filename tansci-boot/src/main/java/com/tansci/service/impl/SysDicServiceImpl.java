package com.tansci.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.tansci.domain.SysDic;
import com.tansci.mapper.SysDicMapper;
import com.tansci.service.SysDicService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * @ClassName： SysDicServiceImpl.java
 * @ClassPath： com.tansci.service.impl.SysDicServiceImpl.java
 * @Description： 字典信息
 * @Author： tanyp
 * @Date： 2023/3/29 9:39
 **/
@Slf4j
@Service
public class SysDicServiceImpl extends ServiceImpl<SysDicMapper, SysDic> implements SysDicService {
}
