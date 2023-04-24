package com.tansci.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.tansci.domain.SysUser;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * @ClassName： SysUserMapper.java
 * @ClassPath： com.tansci.mapper.SysUserMapper.java
 * @Description： 用户信息
 * @Author： tanyp
 * @Date： 2023/3/20 15:50
 **/
@Mapper
public interface SysUserMapper extends BaseMapper<SysUser> {

    @Select("SELECT DISTINCT sm.permission\n" +
            "FROM sys_menu sm\n" +
            "right JOIN sys_role_menu srm ON sm.id = srm.menu_id\n" +
            "right JOIN sys_user_role sur ON sur.role_id = srm.role_id\n" +
            "right JOIN sys_user su ON su.id = sur.user_id AND su.id = #{userId} AND su.is_del = 0\n" +
            "WHERE sm.is_del = 0\n" +
            "AND sm.permission != ''\n" +
            "AND sm.permission IS NOT NULL")
    List<String> authorities(@Param("userId") String userId);

}
