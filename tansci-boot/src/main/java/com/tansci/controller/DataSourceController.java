package com.tansci.controller;

import com.tansci.common.WrapMapper;
import com.tansci.common.Wrapper;
import com.tansci.common.annotation.Log;
import com.tansci.common.constant.Constants;
import com.tansci.domain.vo.ColumnsVo;
import com.tansci.domain.vo.TablesVo;
import com.tansci.service.DataSourceService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @ClassName： DataSourceController.java
 * @ClassPath： com.tansci.controller.DataSourceController.java
 * @Description： 数据源
 * @Author： tanyp
 * @Date： 2023/4/23 15:19
 **/
@Slf4j
@RestController
@RequestMapping("/source")
@Api(value = "source", tags = "数据源")
public class DataSourceController {

    @Autowired
    private DataSourceService dataSourceService;

    @ApiOperation(value = "数据表", notes = "数据表")
    @Log(modul = "数据源", type = Constants.SELECT, desc = "数据表")
    @GetMapping("/tables")
    public Wrapper<List<TablesVo>> tables(String name) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, dataSourceService.tables(name));
    }

    @ApiOperation(value = "数据列", notes = "数据列")
    @Log(modul = "数据列", type = Constants.SELECT, desc = "数据列")
    @GetMapping("/columns")
    public Wrapper<List<ColumnsVo>> columns(String name) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, dataSourceService.columns(name));
    }

    @ApiOperation(value = "获取住建", notes = "获取住建")
    @Log(modul = "数据源", type = Constants.SELECT, desc = "获取住建")
    @GetMapping("/primary")
    public Wrapper<Object> primary(String name) {
        return WrapMapper.wrap(Wrapper.SUCCESS_CODE, Wrapper.SUCCESS_MESSAGE, dataSourceService.primary(name));
    }

}
