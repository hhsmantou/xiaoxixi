package com.example.demo.domain.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import com.example.demo.domain.entity.Products;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface ProductsMapper extends BaseMapper<Products> {

    List<Products> selectAllProducts();

    Products selectProductById(@Param("id") Integer id);

    int insertProduct(Products product);

    int updateProduct(Products product);

    int deleteProductById(@Param("id") Integer id);

    List<Products> searchProductsByName(@Param("keyword") String keyword);
    // 更新商品的图片信息
    int updateProductImages(@Param("productId") Integer productId, @Param("cover") String cover);
    IPage<Products> selectProductsPage(Page<?> page, @Param("name") String keyword);

    @Select("SELECT * FROM products WHERE inventory < 100")
    List<Products> selectProductsWithLowStock();
}