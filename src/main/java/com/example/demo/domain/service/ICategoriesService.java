package com.example.demo.domain.service;

import com.example.demo.domain.entity.Categories;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author 
 * @since 2025-01-19
 */
public interface ICategoriesService extends IService<Categories> {
    boolean addCategory(Categories category);
    List<Categories> getAllCategories();
    boolean updateCategory(Categories category);
    boolean deleteCategoryById(Integer id);
}
