package com.example.demo.domain.service.impl;

import com.example.demo.domain.entity.LimitedProduct;
import com.example.demo.domain.entity.LimitedPurchase;
import com.example.demo.domain.entity.Products;
import com.example.demo.domain.mapper.LimitedProductMapper;
import com.example.demo.domain.mapper.LimitedPurchaseMapper;
import com.example.demo.domain.mapper.ProductsMapper;
import com.example.demo.domain.service.ILimitedPurchaseService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.time.LocalDateTime;

@Service
public class LimitedPurchaseServiceImpl extends ServiceImpl<LimitedPurchaseMapper, LimitedPurchase> implements ILimitedPurchaseService {

    @Autowired
    private LimitedProductMapper limitedProductMapper;

    @Autowired
    private LimitedPurchaseMapper limitedPurchaseMapper;

    @Autowired
    private ProductsMapper productMapper; // 新增的商品Mapper

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void purchaseProduct(Integer userId, Integer productId, Integer quantity) {
        // 检查限购商品
        LimitedProduct limitedProduct = limitedProductMapper.selectByProductId(productId);
        if (limitedProduct == null) {
            throw new RuntimeException("没有发现商品");
        }

        // 检查是否在限购时间范围内
        LocalDateTime now = LocalDateTime.now();
        if (now.isAfter(limitedProduct.getEndDate())) {
            throw new RuntimeException("购买期限已过 " + productId);
        }

        // 获取商品库存
        Products product = productMapper.selectById(productId);
        if (product == null) {
            throw new RuntimeException("商品表中没有找到商品");
        }

        // 检查库存是否足够
        if (product.getInventory() < quantity) {
            throw new RuntimeException(" 产品ID的库存不足" + productId);
        }

        // 获取用户在限购时间内的总购买量
        Timestamp startTime = Timestamp.valueOf(limitedProduct.getCreatedDate());
        Integer totalPurchased = limitedPurchaseMapper.getTotalPurchasedQuantity(userId, productId, startTime);
        totalPurchased = (totalPurchased == null) ? 0 : totalPurchased;

        // 检查是否可以购买
        if ((totalPurchased + quantity) > limitedProduct.getLimitQuantity()) {
            throw new RuntimeException("超过购买限制：用户ID " );
        }

        // 更新商品库存
        product.setInventory(product.getInventory() - quantity);
        productMapper.updateById(product);

        // 记录购买信息
        LimitedPurchase purchase = new LimitedPurchase();
        purchase.setUserId(userId);
        purchase.setProductId(productId);
        purchase.setPurchasedQuantity(quantity);
        purchase.setPurchaseTime(Timestamp.valueOf(now));
        limitedPurchaseMapper.insert(purchase);
    }
}