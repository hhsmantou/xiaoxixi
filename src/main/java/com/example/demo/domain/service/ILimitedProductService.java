package com.example.demo.domain.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.domain.dto.LimitedProductDetailDTO;
import com.example.demo.domain.entity.LimitedProduct;
import com.baomidou.mybatisplus.extension.service.IService;

public interface ILimitedProductService extends IService<LimitedProduct> {
    void addLimitedTimeProduct(Integer productId, Integer limitQuantity, String limitTimeframe);
    IPage<LimitedProductDetailDTO> getAvailableLimitedProducts(Page<LimitedProduct> page);
    void updateLimitedProductDetails(Integer productId, String limitTimeframe, Integer limitQuantity);
}