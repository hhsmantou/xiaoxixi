package com.example.demo.domain.mapper;

import com.example.demo.domain.entity.Categories;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author 
 * @since 2025-01-19
 */
public interface CategoriesMapper extends BaseMapper<Categories> {
    int insertCategory(Categories category);
    List<Categories> selectAllCategories();
    int updateCategory(Categories category);
    int deleteCategoryById(@Param("id") Integer id);
}
