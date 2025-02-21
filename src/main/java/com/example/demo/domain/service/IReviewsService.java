package com.example.demo.domain.service;

import com.example.demo.domain.dto.ReviewWithUserDTO;
import com.example.demo.domain.entity.Reviews;
import com.baomidou.mybatisplus.extension.service.IService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import java.util.List;
/**
 * <p>
 *  服务类
 * </p>
 *
 * @author
 * @since 2025-01-19
 */
public interface IReviewsService extends IService<Reviews> {
        boolean addReview(Reviews review);
        List<Reviews> getAllReviews();
        boolean updateReview(Reviews review);
        boolean deleteReviewById(Integer id);
        List<Reviews> getReviewsByUserId(Integer userId);
        List<Reviews> getReviewsByProductId(Integer productId);
        IPage<Reviews> getReviewsPage(Page<Reviews> page);
        IPage<Reviews> getReviewsByProductIdPage(Page<Reviews> page, Integer productId);
        IPage<Reviews> getReviewsByUserIdPage(Page<Reviews> page, Integer userId);
        IPage<ReviewWithUserDTO> getReviewsWithUserByProductIdPage(Page<ReviewWithUserDTO> page, Integer productId);
        List<ReviewWithUserDTO> getLatestReviewsWithUser();
}


