package com.tansci.service.impl;

import com.tansci.domain.vo.ColumnsVo;
import com.tansci.domain.vo.TablesVo;
import com.tansci.mapper.DataSourceMapper;
import com.tansci.service.DataSourceService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @ClassName： DataSourceServiceImpl.java
 * @ClassPath： com.tansci.service.impl.DataSourceServiceImpl.java
 * @Description： 数据源
 * @Author： tanyp
 * @Date： 2023/4/23 15:20
 **/
@Slf4j
@Service
public class DataSourceServiceImpl implements DataSourceService {

    @Autowired
    private DataSourceMapper dataSourceMapper;

    @Override
    public List<TablesVo> tables(String sourceName) {
        return dataSourceMapper.tables(sourceName);
    }

    @Override
    public List<ColumnsVo> columns(String tableName) {
        return dataSourceMapper.columns(tableName);
    }

    @Override
    public String primary(String tableName) {
        return dataSourceMapper.primary(tableName);
    }
}
