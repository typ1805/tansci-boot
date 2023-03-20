package com.tansci.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;


/**
 * @ClassName： SysDic.java
 * @ClassPath： com.tansci.SysDic.java
 * @Description： 数据字典
 * @Author： tanyp
 * @Date： 2023/03/20 10:38
 **/
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "sys_dic")
@ApiModel(value = "数据字典")
public class SysDic {

    @TableId(type = IdType.ASSIGN_UUID)
    @ApiModelProperty(value = "主键id", hidden = true)
    private String id;

    @ApiModelProperty(value = "父ID")
    private String parentId;

    @ApiModelProperty(value = "分组名称")
    private String groupName;

    @ApiModelProperty(value = "类型：0、系统，1、业务")
    private Integer type;

    @TableField(exist = false)
    @ApiModelProperty(value = "类型名称")
    private String typeName;

    @ApiModelProperty(value = "值")
    private Integer dicValue;

    @ApiModelProperty(value = "名称")
    private String dicLabel;

    @ApiModelProperty(value = "排序")
    private Integer sort;

    @ApiModelProperty(value = "预留字段1")
    private String text1;

    @ApiModelProperty(value = "预留字段3")
    private String text2;

    @ApiModelProperty(value = "预留字段2")
    private String text3;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", locale = "zh", timezone = "GMT+8")
    @ApiModelProperty(value = "更新时间")
    private LocalDateTime updateTime;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", locale = "zh", timezone = "GMT+8")
    @ApiModelProperty(value = "创建时间")
    private LocalDateTime createTime;

    @ApiModelProperty(value = "描述")
    private String remarks;

    @TableField(exist = false)
    private List<SysDic> children;

}