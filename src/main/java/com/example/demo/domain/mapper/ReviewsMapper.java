package com.example.demo.domain.mapper;

import com.example.demo.domain.entity.Reviews;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.springframework.data.repository.query.Param;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Select;
import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author 
 * @since 2025-01-19
 */
public interface ReviewsMapper extends BaseMapper<Reviews> {
    int insertReview(Reviews review);
    List<Reviews> selectAllReviews();
    int updateReview(Reviews review);
    int deleteReviewById(@Param("id") Integer id);
    List<Reviews> selectReviewsByUserId(@Param("userId") Integer userId);
    List<Reviews> selectReviewsByProductId(@Param("productId") Integer productId);
    @Select("SELECT * FROM reviews WHERE product_id = #{productId}")
    IPage<Reviews> selectReviewsByProductIdPage(Page<Reviews> page, @Param("productId") Integer productId);

    @Select("SELECT * FROM reviews WHERE user_id = #{userId}")
    IPage<Reviews> selectReviewsByUserIdPage(Page<Reviews> page, @Param("userId") Integer userId);
}
