package com.example.demo.domain.controller;


import com.example.demo.common.Result;
import com.example.demo.domain.entity.Categories;
import com.example.demo.domain.service.ICategoriesService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author 
 * @since 2025-01-19
 */
@RestController
@RequestMapping("/api/categories")
@Api(tags = "商品分类管理")
public class CategoriesController {
    @Autowired
    private ICategoriesService categoriesService;

    @PostMapping
    @ApiOperation(value = "添加商品分类", notes = "添加新的商品分类")
    public Result<String> addCategory(@RequestBody Categories category) {
        boolean isAdded = categoriesService.addCategory(category);
        return isAdded ? Result.success("商品分类添加成功") : Result.error("商品分类添加失败");
    }

    @GetMapping
    @ApiOperation(value = "获取商品分类列表", notes = "获取所有商品分类")
    public Result<List<Categories>> getCategories() {
        List<Categories> categoriesList = categoriesService.getAllCategories();
        return Result.success(categoriesList);
    }

    @PutMapping("/{id}")
    @ApiOperation(value = "更新商品分类", notes = "根据ID更新商品分类信息")
    public Result<String> updateCategory(@PathVariable Integer id, @RequestBody Categories category) {
        category.setId(id);
        boolean isUpdated = categoriesService.updateCategory(category);
        return isUpdated ? Result.success("商品分类更新成功") : Result.error("商品分类更新失败");
    }

    @DeleteMapping("/{id}")
    @ApiOperation(value = "删除商品分类", notes = "根据ID删除商品分类")
    public Result<String> deleteCategory(@PathVariable Integer id) {
        boolean isDeleted = categoriesService.deleteCategoryById(id);
        return isDeleted ? Result.success("商品分类删除成功") : Result.error("商品分类删除失败");
    }
}

