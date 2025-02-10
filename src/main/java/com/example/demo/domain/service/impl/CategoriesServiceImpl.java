package com.example.demo.domain.service.impl;

import com.example.demo.domain.entity.Categories;
import com.example.demo.domain.mapper.CategoriesMapper;
import com.example.demo.domain.service.ICategoriesService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author 
 * @since 2025-01-19
 */
@Service
public class CategoriesServiceImpl extends ServiceImpl<CategoriesMapper, Categories> implements ICategoriesService {
    @Autowired
    private CategoriesMapper categoriesMapper;

    @Override
    public boolean addCategory(Categories category) {
        return categoriesMapper.insertCategory(category) > 0;
    }

    @Override
    public List<Categories> getAllCategories() {
        return categoriesMapper.selectAllCategories();
    }

    @Override
    public boolean updateCategory(Categories category) {
        return categoriesMapper.updateCategory(category) > 0;
    }

    @Override
    public boolean deleteCategoryById(Integer id) {
        return categoriesMapper.deleteCategoryById(id) > 0;
    }
}
