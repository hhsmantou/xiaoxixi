package com.example.demo.domain.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.domain.entity.LimitedPurchase;

public interface ILimitedPurchaseService extends IService<LimitedPurchase> {
    void purchaseProduct(Integer userId, Integer productId, Integer quantity);
}