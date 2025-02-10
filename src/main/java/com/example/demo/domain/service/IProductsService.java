package com.example.demo.domain.service;


import com.example.demo.domain.entity.Products;
import com.baomidou.mybatisplus.extension.service.IService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author 
 * @since 2025-01-19
 */
public interface IProductsService extends IService<Products> {
    List<Products> getAllProducts();

    Products getProductById(Integer id);

    boolean addProduct(Products product);

    boolean updateProduct(Products product);

    boolean deleteProductById(Integer id);

    List<Products> searchProducts(String keyword);

    boolean addProductImages(Integer productId, List<String> fileNames);

    boolean deleteProductImages(Integer productId, List<String> fileNames);



    IPage<Products> getProductsPage(int pageNum, int pageSize, String keyword);

    List<Products> getProductsWithLowStock();
}
