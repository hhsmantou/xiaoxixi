package com.example.demo.domain.controller;

import com.example.demo.common.Result;
import com.example.demo.domain.dto.LoginRequest;
import com.example.demo.domain.entity.Users;
import com.example.demo.domain.service.IUsersService;
import com.baomidou.mybatisplus.core.metadata.IPage;

import com.example.demo.security.JwtUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author 
 * @since 2025-01-19
 */
@RestController
@RequestMapping("/user")
@Api(tags = "用户管理")
public class UsersController {
    private static final String UPLOAD_DIR = "uploads/user";
    @Autowired
    private IUsersService usersService;

    @Autowired
    private JwtUtil jwtUtil;

    @GetMapping("/hello")
    public ResponseEntity<Result<Object>> hello() {
        return ResponseEntity.badRequest()
                .body(Result.error(200, "Hello, World!"));
    }
    @PostMapping("/register")
    @ApiOperation(value = "用户注册", notes = "注册新用户并上传头像")
    public ResponseEntity<Result<Object>> registerUser(@ModelAttribute Users user, @RequestParam("avatars") MultipartFile avatar) {
        // 验证必填字段
        if (user.getUsername() == null || user.getUsername().trim().isEmpty()) {
            return ResponseEntity.badRequest()
                    .body(Result.error(400, "用户名不能为空"));
        }

        if (user.getPassword() == null || user.getPassword().trim().isEmpty()) {
            return ResponseEntity.badRequest()
                    .body(Result.error(400, "密码不能为空"));
        }
        if (avatar.isEmpty()) {
            return ResponseEntity.badRequest()
                    .body(Result.error(400, "头像文件为空"));
        }

        // 验证文件类型
        String contentType = avatar.getContentType();
        if (!contentType.startsWith("image/")) {
            return ResponseEntity.badRequest().body(Result.error("仅支持图片文件"));
        }

        try {
            // 生成唯一文件名
            String fileName = System.currentTimeMillis() + "_" + avatar.getOriginalFilename();
            Path uploadPath = Paths.get(UPLOAD_DIR);
            
            // 确保上传目录存在
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

            Path filePath = uploadPath.resolve(fileName);
            Files.copy(avatar.getInputStream(), filePath);

            // 设置用户的头像文件名
            user.setAvatar(fileName);

            // 确保其他字段不为null
            if (user.getEmail() == null) user.setEmail("");
            if (user.getAddress() == null) user.setAddress("");
            if (user.getPhone() == null) user.setPhone("");
            boolean success = usersService.registerUser(user);

            if (success) {
                return ResponseEntity.ok(Result.success("注册成功", null));
            } else {
                return ResponseEntity.ok(Result.error("用户名已存在"));
            }
        } catch (IOException e) {
            return ResponseEntity.status(500).body(Result.error("文件上传失败"));
        }
    }



    @PostMapping("/login")
    @ApiOperation(value = "用户登录", notes = "用户登录并获取JWT token")
    public ResponseEntity<Result<Map<String, Object>>> login(@RequestBody LoginRequest loginRequest) {
        boolean authenticated = usersService.authenticateUser(loginRequest.getUsername(), loginRequest.getPassword());
        if (authenticated) {
            Users user = usersService.getUserByUsername(loginRequest.getUsername());
            user.setPassword(null);  // 不返回密码
            
            String token = jwtUtil.generateToken(user.getUsername());
            
            Map<String, Object> data = new HashMap<>();
            data.put("user", user);
            data.put("token", "Bearer " + token);
            
            return ResponseEntity.ok(Result.success("登录成功", data));
        } else {
            return ResponseEntity.ok(Result.error("用户名或密码错误"));
        }
    }



    @GetMapping("/user")
   @ApiOperation(value = "获取用户信息", notes = "根据用户名获取用户详细信息")
    public ResponseEntity<Result<Map<String, Object>>> getUserInfo(@RequestParam String username) {
        Users user = usersService.getUserByUsername(username);
        if (user != null) {
            Map<String, Object> userInfo = new HashMap<>();
            userInfo.put("id", user.getId());
            userInfo.put("username", user.getUsername());
            userInfo.put("email", user.getEmail());
            userInfo.put("address", user.getAddress());
            userInfo.put("phone", user.getPhone());
            userInfo.put("avatar", user.getAvatar());
            userInfo.put("roleId", user.getRoleId());
            userInfo.put("createTime", user.getCreateTime());
            
            return ResponseEntity.ok(Result.success(userInfo));
        }
        return ResponseEntity.ok(Result.error("用户不存在"));
    }

    @GetMapping("/user/{id}")
    @ApiOperation(value = "获取用户信息", notes = "根据用户名获取用户详细信息")
    public ResponseEntity<Result<Map<String, Object>>> getUserInfoByID(@PathVariable Long id) {
        Users user = usersService.getUserByID(id);
        if (user != null) {
            Map<String, Object> userInfo = new HashMap<>();
            userInfo.put("id", user.getId());
            userInfo.put("username", user.getUsername());
            userInfo.put("email", user.getEmail());
            userInfo.put("address", user.getAddress());
            userInfo.put("phone", user.getPhone());
            userInfo.put("avatar", user.getAvatar());
            userInfo.put("roleId", user.getRoleId());
            userInfo.put("createTime", user.getCreateTime());

            return ResponseEntity.ok(Result.success(userInfo));
        }
        return ResponseEntity.ok(Result.error("用户不存在"));
    }

    @PutMapping("/update")
    @ApiOperation(value = "更新用户信息", notes = "更新用户的详细信息")
    public ResponseEntity<Result<Object>> updateUserInfo(@RequestBody Users user) {
        // 验证用户ID
        if (user.getId() == null) {
            return ResponseEntity.badRequest()
                .body(Result.error(400, "用户ID不能为空"));
        }

        boolean updated = usersService.updateById(user);
        if (updated) {
            return ResponseEntity.ok(Result.success("更新成功", null));
        } else {
            return ResponseEntity.ok(Result.error("更新失败"));
        }
    }

    @DeleteMapping("/delete/{id}")
    @ApiOperation(value = "删除用户", notes = "根据用户ID删除用户")
    public ResponseEntity<Result<Object>> deleteUser(@PathVariable Long id) {
        boolean deleted = usersService.removeById(id);
        if (deleted) {
            return ResponseEntity.ok(Result.success("删除成功", null));
        } else {
            return ResponseEntity.ok(Result.error("删除失败"));
        }
    }

    @GetMapping("/users")
    @ApiOperation(value = "获取用户列表", notes = "获取所有用户的列表")
    public ResponseEntity<Result<List<Users>>> getUserList(Users user) {
        List<Users> users = usersService.selectUserList(user);
        // 清除密码信息
        users.forEach(u -> u.setPassword(null));
        return ResponseEntity.ok(Result.success(users));
    }

    @DeleteMapping("/deleteAll")
    @ApiOperation(value = "批量删除用户", notes = "批量删除用户数据")
    public ResponseEntity<Result<Object>> batchDeleteUsers(@RequestBody List<Long> ids) {
        boolean deleted = usersService.batchDeleteUsers(ids);
        if (deleted) {
            return ResponseEntity.ok(Result.success("批量删除成功", null));
        } else {
            return ResponseEntity.ok(Result.error("批量删除失败"));
        }
    }

    @PostMapping("/changePassword")
    @ApiOperation(value = "修改用户密码", notes = "修改用户密码")
    public ResponseEntity<Result<Object>> changePassword(@RequestBody Map<String, String> passwordMap) {
        String username = passwordMap.get("username");
        String oldPassword = passwordMap.get("oldPassword");
        String newPassword = passwordMap.get("newPassword");

        if (username == null || oldPassword == null || newPassword == null) {
            return ResponseEntity.badRequest().body(Result.error(400, "请求参数不完整"));
        }

        boolean success = usersService.changePassword(username, oldPassword, newPassword);
        if (success) {
            return ResponseEntity.ok(Result.success("密码修改成功", null));
        } else {
            return ResponseEntity.ok(Result.error("密码修改失败"));
        }
    }

    // 上传用户头像
    @PostMapping("/{id}/uploadAvatar")
    public Result<String> uploadUserAvatar(@PathVariable Integer id, @RequestParam("file") MultipartFile file) {
        if (file.isEmpty()) {
            return Result.error("文件为空");
        }

        try {

            Path uploadPath = Paths.get("uploads/user/");
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }


            String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
            Path filePath = uploadPath.resolve(fileName);
            Files.copy(file.getInputStream(), filePath);


            Users user = usersService.getById(id);
            if (user != null) {
                user.setAvatar(fileName);
                usersService.updateById(user);
                return Result.success("文件上传成功", fileName);
            } else {
                return Result.error("用户不存在");
            }
        } catch (IOException e) {
            return Result.error("文件上传失败");
        }

    }
    @GetMapping("/page")
    @ApiOperation(value = "分页获取用户列表", notes = "分页获取用户列表")
    public Result<IPage<Users>> getUsersPage(
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize,
            @RequestParam(required = false) String username,
            @RequestParam(required = false) String phone,
            @RequestParam(required = false) String email,
            @RequestParam(required = false) Integer roleId) {
        IPage<Users> usersPage = usersService.getUsersPage(pageNum, pageSize, username, phone, email, roleId);
        return Result.success(usersPage);
    }
    @GetMapping("/{id}/is-member")
    @ApiOperation(value = "检查用户是否为会员", notes = "根据用户ID检查是否为会员")
    public Result<Boolean> isUserMember(@PathVariable Integer id) {
        boolean isMember = usersService.isUserMember(id);
        return Result.success(isMember);
    }
    @PutMapping("/{id}/membership")
    @ApiOperation(value = "更新用户会员状态", notes = "根据用户ID更新会员状态")
    public Result<String> updateUserMembership(@PathVariable Integer id, @RequestParam Integer isMember) {
        boolean isUpdated = usersService.updateUserMembership(id, isMember);
        return isUpdated ? Result.success("会员状态更新成功") : Result.error("会员状态更新失败");
    }
}

