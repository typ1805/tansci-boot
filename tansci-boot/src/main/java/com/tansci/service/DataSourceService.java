package com.tansci.service;

import com.tansci.domain.vo.ColumnsVo;
import com.tansci.domain.vo.TablesVo;

import java.util.List;

/**
 * @ClassName： DataSourceService.java
 * @ClassPath： com.tansci.service.DataSourceService.java
 * @Description： 数据源
 * @Author： tanyp
 * @Date： 2023/4/23 15:20
 **/
public interface DataSourceService {

    List<TablesVo> tables(String sourceName);

    List<ColumnsVo> columns(String tableName);

    String primary(String tableName);

}
