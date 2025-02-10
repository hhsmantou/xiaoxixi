package com.example.demo.domain.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.common.Result;
import com.example.demo.domain.dto.LimitedProductDetailDTO;
import com.example.demo.domain.dto.LimitedProductRequestDTO;
import com.example.demo.domain.dto.PurchaseRequestDTO;
import com.example.demo.domain.entity.LimitedProduct;
import com.example.demo.domain.mapper.LimitedProductMapper;
import com.example.demo.domain.service.ILimitedProductService;
import com.example.demo.domain.service.ILimitedPurchaseService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/limited-purchase")
@Api(tags = "限购管理")
public class LimitedPurchaseController {

    @Autowired
    private ILimitedPurchaseService limitedPurchaseService;
    @Autowired
    private ILimitedProductService limitedProductService;


    @PostMapping("/purchase")
    @ApiOperation(value = "购买限购商品", notes = "用户购买限购商品")
    public Result<String> purchaseProduct(@RequestBody PurchaseRequestDTO purchaseRequest) {
        try {
            limitedPurchaseService.purchaseProduct(
                    purchaseRequest.getUserId(),
                    purchaseRequest.getProductId(),
                    purchaseRequest.getQuantity()
            );
            return Result.success("购买成功");
        } catch (RuntimeException e) {
            return Result.error(e.getMessage());
        }
    }
    @PostMapping("/add")
    @ApiOperation(value = "新增限时商品", notes = "新增限时商品及其限购数量")
    public Result<String> addLimitedTimeProduct(@RequestBody LimitedProductRequestDTO limitedProductRequest) {
        try {

            limitedProductService.addLimitedTimeProduct(
                    limitedProductRequest.getProductId(),
                    limitedProductRequest.getLimitQuantity(),
                    limitedProductRequest.getLimitTimeframe()
            );
            return Result.success("限时商品新增成功");
        } catch (Exception e) {
            return Result.error("限时商品新增失败: " + e.getMessage());
        }
    }
    @GetMapping("/available")
    @ApiOperation(value = "获取可用限购商品", notes = "分页获取当前可购买的限购商品列表")
    public Result<IPage<LimitedProductDetailDTO>> getAvailableLimitedProducts(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size) {
        Page<LimitedProduct> productPage = new Page<>(page, size);
        IPage<LimitedProductDetailDTO> availableProducts = limitedProductService.getAvailableLimitedProducts(productPage);
        return Result.success(availableProducts);
    }
    @PutMapping("/update-details")
    @ApiOperation(value = "更新限时商品详细信息", notes = "根据时间框架和限购数量更新限时商品的信息")
    public Result<String> updateLimitedProductDetails(@RequestBody LimitedProduct limitedProduct) {
        try {
            limitedProductService.updateLimitedProductDetails(limitedProduct.getProductId(), limitedProduct.getLimitTimeframe(), limitedProduct.getLimitQuantity());
            return Result.success("限时商品详细信息更新成功");
        } catch (RuntimeException e) {
            return Result.error(e.getMessage());
        }
    }
}