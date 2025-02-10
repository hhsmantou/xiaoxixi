package com.example.demo.domain.service.impl;

import com.example.demo.domain.entity.Reviews;
import com.example.demo.domain.mapper.ReviewsMapper;
import com.example.demo.domain.service.IReviewsService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import java.time.LocalDateTime;
import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author 
 * @since 2025-01-19
 */
@Service
public class ReviewsServiceImpl extends ServiceImpl<ReviewsMapper, Reviews> implements IReviewsService {
    @Autowired
    private ReviewsMapper reviewsMapper;

    @Override
    public boolean addReview(Reviews review) {
        review.setCreateTime(LocalDateTime.now());
        try {
            return reviewsMapper.insertReview(review) > 0;
        } catch (Exception e) {

            System.err.println("Error adding review: " + e.getMessage());
            return false;
        }

    }

    @Override
    public List<Reviews> getAllReviews() {
        return reviewsMapper.selectAllReviews();
    }

    @Override
    public boolean updateReview(Reviews review) {
        return reviewsMapper.updateReview(review) > 0;
    }

    @Override
    public boolean deleteReviewById(Integer id) {
        return reviewsMapper.deleteReviewById(id) > 0;
    }

    @Override
    public List<Reviews> getReviewsByUserId(Integer userId) {
        return reviewsMapper.selectReviewsByUserId(userId);
    }

    @Override
    public List<Reviews> getReviewsByProductId(Integer productId) {
        return reviewsMapper.selectReviewsByProductId(productId);
    }
    @Override
    public IPage<Reviews> getReviewsPage(Page<Reviews> page) {
        return reviewsMapper.selectPage(page, null);
    }
    @Override
    public IPage<Reviews> getReviewsByProductIdPage(Page<Reviews> page, Integer productId) {
        return reviewsMapper.selectReviewsByProductIdPage(page, productId);
    }

    @Override
    public IPage<Reviews> getReviewsByUserIdPage(Page<Reviews> page, Integer userId) {
        return reviewsMapper.selectReviewsByUserIdPage(page, userId);
    }
}
