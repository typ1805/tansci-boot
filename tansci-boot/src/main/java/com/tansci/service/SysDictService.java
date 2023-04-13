package com.tansci.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.tansci.domain.SysDict;

import java.util.List;

/**
 * @ClassName： SysDictService.java
 * @ClassPath： com.tansci.service.SysDictService.java
 * @Description： 字典信息
 * @Author： tanyp
 * @Date： 2023/3/29 9:33
 **/
public interface SysDictService extends IService<SysDict> {

    List<SysDict> list(SysDict dict);

    Object delete(String id);
}
