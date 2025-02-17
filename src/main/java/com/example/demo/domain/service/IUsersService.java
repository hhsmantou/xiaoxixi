package com.example.demo.domain.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.example.demo.domain.entity.Products;
import com.example.demo.domain.entity.Users;
import com.baomidou.mybatisplus.extension.service.IService;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author 
 * @since 2025-01-19
 */
public interface IUsersService extends IService<Users> {

    boolean registerUser(Users user);
    
    boolean authenticateUser(String username, String password);
    
    boolean existsByUsername(String username);
    
    String getPasswordByUsername(String username);
    
    Users getUserByUsername(String username);

    List<Users> selectUserList(Users user);
    // 批量删除用户
    boolean batchDeleteUsers(@Param("list") List<Long> ids);
    boolean changePassword(String username, String oldPassword, String newPassword);

    IPage<Users> getUsersPage(int pageNum, int pageSize, String username, String phone, String email,Integer roleId);

    boolean isUserMember(Integer userId);
    boolean updateUserMembership(Integer userId, Integer isMember);
}


