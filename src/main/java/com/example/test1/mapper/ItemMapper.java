package com.example.test1.mapper;

import com.example.test1.domain.AttachImage;
import com.example.test1.domain.Criteria;
import com.example.test1.domain.Item;
import com.example.test1.domain.ItemImage;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@Mapper
public interface ItemMapper {

    List<Item> getListPaging(Criteria cri);
    Item selectItemDetail(Long item);
    void insertItem(Item item);
    void imageEnroll(ItemImage itemImage);
    List<Item> findAll();
    int hadItem(@Param("itemId") Long itemId, @Param("mId") String mid);
    void saveCartItem(Map cartItem);
    int hadWishItem(@Param("itemId") Long itemId, @Param("mId") String mid);
    void saveWishItem(@Param("itemId") Long itemId, @Param("mId") String mid);
}
