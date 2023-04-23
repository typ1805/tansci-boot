package com.tansci.domain.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @ClassName： ColumnsVo.java
 * @ClassPath： com.tansci.domain.vo.ColumnsVo.java
 * @Description： 数据列
 * @Author： tanyp
 * @Date： 2023/4/23 15:00
 **/
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel(value = "数据列")
public class ColumnsVo {

    @ApiModelProperty(value = "数据库")
    private String tableSchema;

    @ApiModelProperty(value = "数据表")
    private String tableName;

    @ApiModelProperty(value = "列名称")
    private String columnName;

    @ApiModelProperty(value = "列描述")
    private String columnComment;

    @ApiModelProperty(value = "数据类型")
    private String dataType;

    @ApiModelProperty(value = "是否为空")
    private String isNullable;

    @ApiModelProperty(value = "列类型")
    private String columnType;

    @ApiModelProperty(value = "列长")
    private String columnLength;

}
