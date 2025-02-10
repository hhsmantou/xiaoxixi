package com.example.demo.domain.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.demo.domain.entity.LimitedProduct;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.data.repository.query.Param;

@Mapper
public interface LimitedProductMapper extends BaseMapper<LimitedProduct> {
    @Select("SELECT * FROM limited_products WHERE product_id = #{productId}")
    LimitedProduct selectByProductId(@Param("productId") Integer productId);
}