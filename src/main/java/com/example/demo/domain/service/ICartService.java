package com.example.demo.domain.service;

import com.example.demo.domain.entity.Cart;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author 
 * @since 2025-01-19
 */
public interface ICartService extends IService<Cart> {
    boolean addProductToCart(Cart cart);
    boolean updateCartProduct(Integer cartId, Integer quantity);
    boolean deleteCartProduct(Integer cartId);
    List<Cart> getCartList(Integer userId);
}
