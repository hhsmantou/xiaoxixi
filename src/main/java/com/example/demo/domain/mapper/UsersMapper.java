package com.example.demo.domain.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.demo.domain.entity.Users;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author 
 * @since 2025-01-19
 */
@Mapper
public interface UsersMapper extends BaseMapper<Users> {
    
    // 更新用户信息
    int updateUser(Users user);
    
    // 根据用户名查询用户
    Users selectByUsername(@Param("username") String username);

    // 根据ID查询用户
    Users selectByID(@Param("id") Long id);

    // 检查用户名是否存在
    boolean existsByUsername(@Param("username") String username);
    
    // 插入新用户
    int insertUser(Users user);
    
    // 根据ID删除用户
    int deleteById(@Param("id") Long id);
    
    // 批量删除用户
    int batchDeleteUsers(@Param("list") List<Long> ids);
    
    // 条件查询用户列表
    List<Users> selectUserList(Users user);
    // 模糊查询
    IPage<Users> selectUsersPage(Page<Users> page,
                                 @Param("username") String username,
                                 @Param("phone") String phone,
                                 @Param("email") String email,
                                 @Param("roleId") Integer roleId);
}

