package com.example.demo.domain.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.demo.domain.entity.Products;
import com.example.demo.domain.mapper.ProductsMapper;
import com.example.demo.domain.service.IProductsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 */
@Service
public class ProductsServiceImpl extends ServiceImpl<ProductsMapper, Products> implements IProductsService {

    @Autowired
    private ProductsMapper productsMapper;

    @Override
    public List<Products> getAllProducts() {
        return productsMapper.selectAllProducts();
    }

    @Override
    public Products getProductById(Integer id) {
        return productsMapper.selectProductById(id);
    }

    @Override
    public boolean addProduct(Products product) {
        return productsMapper.insertProduct(product) > 0;
    }

    @Override
    public boolean updateProduct(Products product) {
        return productsMapper.updateProduct(product) > 0;
    }

    @Override
    public boolean deleteProductById(Integer id) {
        return productsMapper.deleteProductById(id) > 0;
    }

    @Override
    public List<Products> searchProducts(String keyword) {
        return productsMapper.searchProductsByName(keyword);
    }

    @Override
    public boolean addProductImages(Integer productId, List<String> fileNames) {
        Products product = getById(productId);
        if (product == null) {
            return false;
        }
        String existingCovers = product.getCover();
        String newCovers = existingCovers == null ? String.join(",", fileNames) : existingCovers + "," + String.join(",", fileNames);
        return productsMapper.updateProductImages(productId, newCovers) > 0;
    }

    @Override
    public boolean deleteProductImages(Integer productId, List<String> fileNames) {
        Products product = getById(productId);
        if (product == null) {
            return false;
        }
        String existingCovers = product.getCover();
        if (existingCovers == null) {
            return false;
        }
        List<String> existingCoverList = new ArrayList<>(Arrays.asList(existingCovers.split(",")));
        existingCoverList.removeAll(fileNames);
        return productsMapper.updateProductImages(productId, String.join(",", existingCoverList)) > 0;
    }

    @Override
    public IPage<Products> getProductsPage(int pageNum, int pageSize, String keyword) {
        Page<Products> page = new Page<>(pageNum, pageSize);
        return productsMapper.selectProductsPage(page, keyword);
    }

    @Override
    public List<Products> getProductsWithLowStock() {
        return productsMapper.selectProductsWithLowStock();
    }
    @Override
    public IPage<Products> getProductsByCategory(Integer category, int pageNum, int pageSize) {
        Page<Products> page = new Page<>(pageNum, pageSize);
        return productsMapper.selectProductsByCategory(page, category);
    }
}