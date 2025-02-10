package com.example.demo.domain.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.demo.domain.dto.LimitedProductDetailDTO;
import com.example.demo.domain.entity.LimitedProduct;
import com.example.demo.domain.entity.Products;
import com.example.demo.domain.mapper.LimitedProductMapper;
import com.example.demo.domain.mapper.ProductsMapper;
import com.example.demo.domain.service.ILimitedProductService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class LimitedProductServiceImpl extends ServiceImpl<LimitedProductMapper, LimitedProduct> implements ILimitedProductService {
    @Autowired
    private LimitedProductMapper limitedProductMapper;
    @Autowired
    private ProductsMapper productsMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void addLimitedTimeProduct(Integer productId, Integer limitQuantity, String limitTimeframe) {
        LimitedProduct limitedProduct = new LimitedProduct();
        limitedProduct.setProductId(productId);
        limitedProduct.setLimitQuantity(limitQuantity);
        limitedProduct.setLimitTimeframe(limitTimeframe);
        limitedProduct.setCreatedDate(LocalDateTime.now());

        // 根据时间框架设置结束日期
        LocalDateTime endDate = calculateEndDate(limitTimeframe, limitedProduct.getCreatedDate());
        limitedProduct.setEndDate(endDate);

        this.save(limitedProduct);
    }

    private LocalDateTime calculateEndDate(String timeframe, LocalDateTime startDate) {
        switch (timeframe) {
            case "daily":
                return startDate.plusDays(1);
            case "weekly":
                return startDate.plusWeeks(1);
            case "monthly":
                return startDate.plusMonths(1);
            case "once":
            default:
                return startDate.plusYears(1000); // Assuming 'once' means no specific end date
        }
    }



    @Override
    @Transactional(rollbackFor = Exception.class)
    public IPage<LimitedProductDetailDTO> getAvailableLimitedProducts(Page<LimitedProduct> page) {
        IPage<LimitedProduct> allProducts = limitedProductMapper.selectPage(page, null);
        LocalDateTime now = LocalDateTime.now();

        List<LimitedProductDetailDTO> validProducts = allProducts.getRecords().stream()
                .filter(product -> {
                    boolean isValid = now.isBefore(product.getEndDate());
                    if (!isValid) {
                        // 超出时间范围，删除商品
                        limitedProductMapper.deleteById(product.getId());
                    }
                    return isValid;
                })
                .map(product -> {
                    Products productDetail = productsMapper.selectById(product.getProductId());
                    LimitedProductDetailDTO dto = new LimitedProductDetailDTO();
                    dto.setProductId(product.getProductId());
                    dto.setProductName(productDetail.getName());
                    dto.setProductModel(productDetail.getModel());
                    dto.setProductInfo(productDetail.getInfo());
                    dto.setProductPrice(productDetail.getPrice());
                    dto.setProductCategory(productDetail.getCategory());
                    dto.setProductCover(productDetail.getCover());
                    dto.setLimitQuantity(product.getLimitQuantity());
                    dto.setEndDate(product.getEndDate());
                    dto.setInventory(productDetail.getInventory());
                    return dto;
                })
                .collect(Collectors.toList());

        // 创建新的分页对象
        IPage<LimitedProductDetailDTO> resultPage = new Page<>(page.getCurrent(), page.getSize(), page.getTotal());
        resultPage.setRecords(validProducts);
        return resultPage;
    }
    @Override

    public void updateLimitedProductDetails(Integer productId, String limitTimeframe, Integer limitQuantity) {
        // 检查限购商品是否存在

        System.out.println("Checking limited product with product ID: " + productId);
        LimitedProduct existingProduct = limitedProductMapper.selectByProductId(productId);
        if (existingProduct == null) {
            System.out.println("Limited product not found in database for product ID: " + productId);
            throw new RuntimeException("Limited product not found with product ID: " + productId);
        }

        // 更新限购时间框架和限购数量
        existingProduct.setLimitTimeframe(limitTimeframe);
        existingProduct.setLimitQuantity(limitQuantity);

        // 根据新的时间框架计算结束日期
        LocalDateTime newEndDate = calculateEndDate(existingProduct.getCreatedDate(), limitTimeframe);
        existingProduct.setEndDate(newEndDate);

        // 更新限购商品信息
        limitedProductMapper.updateById(existingProduct);
    }
    private LocalDateTime calculateEndDate(LocalDateTime createdDate, String limitTimeframe) {
        switch (limitTimeframe) {
            case "daily":
                return createdDate.plusDays(1);
            case "weekly":
                return createdDate.plusWeeks(1);
            case "monthly":
                return createdDate.plusMonths(1);
            case "once":
            default:
                return createdDate.plusYears(1000);
        }
    }

}