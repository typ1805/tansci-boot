package com.tansci.domain.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @ClassName： TablesVo.java
 * @ClassPath： com.tansci.domain.vo.TablesVo.java
 * @Description： 数据表
 * @Author： tanyp
 * @Date： 2023/4/23 14:53
 **/
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ApiModel(value = "数据表")
public class TablesVo {

    @ApiModelProperty(value = "数据库")
    private String tableSchema;

    @ApiModelProperty(value = "数据表")
    private String tableName;

    @ApiModelProperty(value = "描述")
    private String tableComment;

}
