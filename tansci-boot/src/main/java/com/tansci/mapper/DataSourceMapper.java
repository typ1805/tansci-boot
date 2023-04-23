package com.tansci.mapper;

import com.tansci.domain.vo.ColumnsVo;
import com.tansci.domain.vo.TablesVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * @ClassName： DataSourceMapper.java
 * @ClassPath： com.tansci.mapper.DataSourceMapper.java
 * @Description：数据源
 * @Author： tanyp
 * @Date： 2023/4/23 14:44
 **/
@Mapper
public interface DataSourceMapper {

    @Select("select table_schema,table_name,table_comment from information_schema.tables where table_schema = #{sourceName}")
    List<TablesVo> tables(@Param("sourceName") String sourceName);

    @Select("select table_schema,table_name,column_name,column_comment,column_type,data_type,is_nullable,CHARACTER_MAXIMUM_LENGTH as columnLength from information_schema.columns where table_name = #{tableName}")
    List<ColumnsVo> columns(@Param("tableName") String tableName);

    @Select("select column_name from information_schema.columns where table_name = #{tableName} and column_key = 'PRI' and table_schema = database() limit 1")
    String primary(@Param("tableName") String tableName);

}
