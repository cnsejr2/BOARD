package com.example.test1.mapper;

import com.example.test1.domain.AttachImage;
import com.example.test1.domain.ItemImage;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface ItemImageMapper {

    List<ItemImage> getItemImageList(Long itemId);
    List<ItemImage> findAllImage();
    void deleteImage(Long itemId);
    void imageReEnroll(ItemImage itemImage);
    void deleteImageAll(Long itemId);
    List<ItemImage> checkFileList();
}
