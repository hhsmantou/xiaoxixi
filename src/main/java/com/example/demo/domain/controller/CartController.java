package com.example.demo.domain.controller;

import com.example.demo.common.Result;
import com.example.demo.domain.entity.Cart;
import com.example.demo.domain.entity.CartAndProduct;
import com.example.demo.domain.service.ICartService;
import com.example.demo.domain.service.IProductsService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author 
 * @since 2025-01-19
 */
@RestController
@RequestMapping("/api/cart")
@Api(tags = "购物车管理")
public class CartController {
        @Autowired
        private ICartService cartService;
        @Autowired
        private IProductsService productsService;

        @PostMapping
        @ApiOperation(value = "添加商品到购物车", notes = "根据用户ID和商品ID添加商品到购物车")
        public Result<String> addProductToCart(@RequestBody Cart cart) {
            System.out.println(cart.getUserId());
            boolean isAdded = cartService.addProductToCart(cart);
            if (isAdded) {
                return Result.success("商品已添加到购物车");
            } else {
                return Result.error("添加商品到购物车失败");
            }
        }

        @PutMapping("/{id}")
        @ApiOperation(value = "修改购物车商品", notes = "根据购物车ID修改商品数量")
        public Result<String> updateCartProduct(@PathVariable Integer id, @RequestParam Integer quantity) {
            boolean isUpdated = cartService.updateCartProduct(id, quantity);
            if (isUpdated) {
                return Result.success("购物车商品已更新");
            } else {
                return Result.error("更新购物车商品失败");
            }
        }

        @DeleteMapping("/{id}")
        @ApiOperation(value = "删除购物车商品", notes = "根据购物车ID删除商品")
        public Result<String> deleteCartProduct(@PathVariable Integer id) {
            boolean isDeleted = cartService.deleteCartProduct(id);
            if (isDeleted) {
                return Result.success("购物车商品已删除");
            } else {
                return Result.error("删除购物车商品失败");
            }
        }

    @GetMapping
    @ApiOperation(value = "获取购物车列表", notes = "根据用户ID获取购物车列表")
    public Result<List<CartAndProduct>> getCartList(@RequestParam Integer userId) {

        List<Cart> cartList = cartService.getCartList(userId);
        List<CartAndProduct> cartAndProductList = new ArrayList<>();
        for (Cart cart : cartList) {
            CartAndProduct cartAndProduct = new CartAndProduct();
            cartAndProduct.setId(cart.getId());
            cartAndProduct.setProductId(cart.getProductId());
            cartAndProduct.setQuantity(cart.getQuantity());
            cartAndProduct.setUserId(userId);
            cartAndProduct.setCreateTime(cart.getCreateTime());
            cartAndProduct.setProducts(productsService.getProductById(cart.getProductId()));
            cartAndProductList.add(cartAndProduct);
        }

        return Result.success(cartAndProductList);
    }
}


