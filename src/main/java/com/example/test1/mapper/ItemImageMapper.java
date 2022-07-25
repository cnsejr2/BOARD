package com.example.test1.mapper;

import com.example.test1.domain.AttachImage;
import com.example.test1.domain.ItemImage;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface ItemImageMapper {
    /* 이미지 데이터 반환 */
    List<ItemImage> getAttachList(Long itemId);

    void deleteImage(Long itemId);

    void imageReEnroll(ItemImage itemImage);
    /* 지정 상품 이미지 전체 삭제 */
    void deleteImageAll(Long itemId);

    List<ItemImage> checkFileList();
}
