package com.example.demo.domain.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.demo.domain.entity.Users;
import com.example.demo.domain.mapper.UsersMapper;
import com.example.demo.domain.service.IUsersService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author
 * @since 2025-01-19
 */
@Service
public class UsersServiceImpl extends ServiceImpl<UsersMapper, Users> implements IUsersService {

    private final BCryptPasswordEncoder passwordEncoder;

    public UsersServiceImpl(BCryptPasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
    }

    @Autowired
    private UsersMapper usersMapper;

    @Override
    public boolean registerUser(Users userInfo) {
        if (existsByUsername(userInfo.getUsername())) {
            return false;
        }

        Users user = new Users();
        user.setUsername(userInfo.getUsername());
        user.setPassword(passwordEncoder.encode(userInfo.getPassword()));
        user.setRoleId(0); // 默认普通用户
        user.setIsMember(0);
        user.setCreateTime(LocalDateTime.now());

        // 设置其他用户信息
        user.setEmail(userInfo.getEmail());
        user.setAddress(userInfo.getAddress());
        user.setPhone(userInfo.getPhone());
        user.setAvatar(userInfo.getAvatar());

        return save(user);
    }

    @Override
    public boolean authenticateUser(String username, String password) {
        String storedPassword = getPasswordByUsername(username);
        return storedPassword != null && passwordEncoder.matches(password, storedPassword);
    }

    @Override
    public boolean existsByUsername(String username) {
        return count(new QueryWrapper<Users>().eq("username", username)) > 0;
    }

    @Override
    public String getPasswordByUsername(String username) {
        Users user = getOne(new QueryWrapper<Users>().eq("username", username));
        return user != null ? user.getPassword() : null;
    }

    @Override
    public Users getUserByUsername(String username) {
        return getOne(new QueryWrapper<Users>().eq("username", username));
    }

    @Override
    public Users getUserByID(Long id) {
        return getOne(new QueryWrapper<Users>().eq("id", id));
    }

    @Override
    public List<Users> selectUserList(Users user) {
        return baseMapper.selectUserList(user);
    }

    @Override
    public boolean batchDeleteUsers(List<Long> ids) {
        return usersMapper.batchDeleteUsers(ids) > 0;
    }

    @Transactional
    @Override
    public boolean changePassword(String username, String oldPassword, String newPassword) {
        Users user = getUserByUsername(username);
        if (user != null && passwordEncoder.matches(oldPassword, user.getPassword())) {
            user.setPassword(passwordEncoder.encode(newPassword));
            return updateById(user);
        }
        return false;
    }

    @Override
    public IPage<Users> getUsersPage(int pageNum, int pageSize, String username, String phone, String email, Integer roleId) {
        Page<Users> page = new Page<>(pageNum, pageSize);
        return usersMapper.selectUsersPage(page, username, phone, email, roleId);
    }

    @Override
    public boolean isUserMember(Integer userId) {
        Users user = usersMapper.selectById(userId);
        return user != null && Boolean.TRUE.equals(user.getIsMember());
    }

    @Override
    public boolean updateUserMembership(Integer userId, Integer isMember) {
        Users user = usersMapper.selectById(userId);
        if (user != null) {
            user.setIsMember(isMember);
            return usersMapper.updateById(user) > 0;
        }
        return false;
    }
}
