package com.example.demo.domain.dto;

import lombok.Data;

import java.time.LocalDateTime;
@Data
public class ReviewWithUserDTO {
    private Integer id;
    private Integer userId;
    private Integer productId;
    private Integer rating;
    private String content;
    private LocalDateTime createTime;
    private String username;
    private String email;
    private String avatar;
}
