package com.example.demo.domain.mapper;

import com.example.demo.domain.entity.Cart;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author 
 * @since 2025-01-19
 */
@Mapper
public interface CartMapper extends BaseMapper<Cart> {
    int addProductToCart(Cart cart);
    int updateCartProduct(Cart cart);
    int deleteCartProduct(@Param("id") Integer id);
    List<Cart> getCartList(@Param("userId") Integer userId);
}
