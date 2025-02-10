package com.example.demo.domain.mapper;

import com.example.demo.domain.entity.LimitedPurchase;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.sql.Timestamp;

@Mapper
public interface LimitedPurchaseMapper extends BaseMapper<LimitedPurchase> {

    @Select("SELECT SUM(purchased_quantity) FROM limited_purchases " +
            "WHERE user_id = #{userId} AND product_id = #{productId} " +
            "AND purchase_time >= #{startTime}")
    Integer getTotalPurchasedQuantity(@Param("userId") Integer userId,
                                      @Param("productId") Integer productId,
                                      @Param("startTime") Timestamp startTime);
}