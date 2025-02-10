package com.example.demo.domain.controller;




import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import com.example.demo.common.Result;
import com.example.demo.domain.entity.Products;
import com.example.demo.domain.service.IProductsService;
/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author 
 * @since 2025-01-19
 */
@RestController
@RequestMapping("/api/products")
@Api(tags = "商品管理")
public class ProductsController {
    private static final String UPLOAD_DIR = "uploads/products/";
    @Autowired
    private IProductsService productsService;

    // 获取商品列表
    @GetMapping
    @ApiOperation(value = "获取商品列表", notes = "获取商品列表")
    public Result<List<Products>> getProducts() {
        List<Products> productsList = productsService.getAllProducts();
        return Result.success(productsList);
    }

    // 获取商品详情
    @GetMapping("/{id}")
    @ApiOperation(value = "获取商品详情", notes = "根据id获取商品详情")
    public Result<Products> getProductById(@PathVariable Integer id) {
        Products product = productsService.getProductById(id);
        if (product != null) {
            return Result.success(product);
        } else {
            return Result.error("商品不存在");
        }
    }

    // 商品搜索
    @GetMapping("/search")
    @ApiOperation(value = "商品搜索", notes = "商品名进行搜索")
    public Result<List<Products>> searchProducts(@RequestParam String keyword) {
        List<Products> productsList = productsService.searchProducts(keyword);
        return Result.success(productsList);
    }

    @PostMapping("/add")
    @ApiOperation(value = "上传商品信息和图片", notes = "上传商品信息和多张图片")
    public Result<String> uploadProductImages(@ModelAttribute Products products, @RequestParam("files") MultipartFile[] files) {
        List<String> fileNames = new ArrayList<>();

        for (MultipartFile file : files) {
            if (file.isEmpty()) {
                return Result.error("文件为空");
            }

            try {
                Path uploadPath = Paths.get(UPLOAD_DIR);
                if (!Files.exists(uploadPath)) {
                    Files.createDirectories(uploadPath);
                }
                String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
                Path filePath = uploadPath.resolve(fileName);
                Files.copy(file.getInputStream(), filePath);
                fileNames.add(fileName);
            } catch (IOException e) {
                return Result.error("文件上传失败");
            }
        }

        // 将文件名列表转换为字符串并设置为商品的封面
        products.setCover(String.join(",", fileNames));

        // 保存商品信息
        boolean isSaved = productsService.addProduct(products);
        if (isSaved) {
            return Result.success("商品信息和图片上传成功", String.join(", ", fileNames));
        } else {
            return Result.error("商品信息保存失败");
        }
    }
    @PostMapping("/{id}/addImages")
    @ApiOperation(value = "根据商品ID新增图片", notes = "上传多张图片并与商品关联")
    public Result<String> addProductImages(@PathVariable Integer id, @RequestParam("files") MultipartFile[] files) {
        List<String> fileNames = new ArrayList<>();

        for (MultipartFile file : files) {
            if (file.isEmpty()) {
                return Result.error("文件为空");
            }

            try {
                Path uploadPath = Paths.get(UPLOAD_DIR);
                if (!Files.exists(uploadPath)) {
                    Files.createDirectories(uploadPath);
                }
                String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
                Path filePath = uploadPath.resolve(fileName);
                Files.copy(file.getInputStream(), filePath);
                fileNames.add(fileName);
            } catch (IOException e) {
                return Result.error("文件上传失败");
            }
        }

        boolean isUpdated = productsService.addProductImages(id, fileNames);
        if (isUpdated) {
            return Result.success("图片上传成功并与商品关联", String.join(", ", fileNames));
        } else {
            return Result.error("商品信息更新失败");
        }
    }

    @DeleteMapping("/{id}/deleteImages")
    @ApiOperation(value = "根据商品ID删除图片", notes = "删除商品的指定图片")
    public Result<String> deleteProductImages(@PathVariable Integer id, @RequestParam("fileNames") List<String> fileNames) {
        boolean isUpdated = productsService.deleteProductImages(id, fileNames);
        if (isUpdated) {
            return Result.success("图片删除成功");
        } else {
            return Result.error("图片删除失败");
        }
    }
    // 更新商品信息
    @PutMapping("/update")
    @ApiOperation(value = "更新商品信息", notes = "更新商品信息")
    public Result<String> updateProduct(@RequestBody Products products) {
        boolean isUpdated = productsService.updateProduct(products);
        if (isUpdated) {
            return Result.success("商品信息更新成功");
        } else {
            return Result.error("商品信息更新失败");
        }
    }

    // 删除商品
    @ApiOperation(value = "商品删除", notes = "根据商品id删除商品")
    @DeleteMapping("/delete/{id}")
    public Result<String> deleteProduct(@PathVariable Integer id) {
        boolean isDeleted = productsService.deleteProductById(id);
        if (isDeleted) {
            return Result.success("商品删除成功");
        } else {
            return Result.error("商品删除失败");
        }
    }
    @GetMapping("/page")
    @ApiOperation(value = "分页获取商品列表", notes = "分页获取商品列表")
    public Result<IPage<Products>> getProductsPage(
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize,
            @RequestParam(defaultValue = "") String name) {
        IPage<Products> productsPage = productsService.getProductsPage(pageNum, pageSize, name);
        return Result.success(productsPage);
    }

    @GetMapping("/low-stock")
    @ApiOperation(value = "获取库存量小于100的商品", notes = "获取库存量小于100的商品列表")
    public Result<List<Products>> getProductsWithLowStock() {
        List<Products> productsList = productsService.getProductsWithLowStock();
        return Result.success(productsList);
    }
}

