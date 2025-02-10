package com.example.demo.domain.service.impl;

import com.example.demo.domain.entity.Cart;
import com.example.demo.domain.mapper.CartMapper;
import com.example.demo.domain.service.ICartService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Collections;
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
public class CartServiceImpl extends ServiceImpl<CartMapper, Cart> implements ICartService {
    @Autowired
    private CartMapper cartMapper;

    @Override
    public boolean addProductToCart(Cart cart) {
        cart.setCreateTime(LocalDateTime.now());
        return cartMapper.addProductToCart(cart) > 0;
    }

    @Override
    public boolean updateCartProduct(Integer cartId, Integer quantity) {
        Cart cart = cartMapper.selectById(cartId);
        if (cart != null) {
            cart.setQuantity(quantity);
            return cartMapper.updateCartProduct(cart) > 0;
        }
        return false;
    }

    @Override
    public boolean deleteCartProduct(Integer cartId) {
        return cartMapper.deleteCartProduct(cartId) > 0;
    }

    @Override
    public List<Cart> getCartList(Integer userId) {
        return cartMapper.getCartList(userId);
    }
}
