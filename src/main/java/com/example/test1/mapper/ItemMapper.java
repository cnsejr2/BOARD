package com.example.test1.mapper;

import com.example.test1.domain.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@Mapper
public interface ItemMapper {

    List<Item> getListPaging(Criteria cri);
    Item selectItemDetail(Long id);
    void insertItem(Item item);
    void imageEnroll(ItemImage itemImage);
    List<Item> findAll();
    int hadItem(Map cItem);
    void saveCartItem(Map cartItem);
    int hadWishItem(@Param("itemId") Long itemId, @Param("mId") String mid);
    void saveWishItem(@Param("itemId") Long itemId, @Param("mId") String mid);
    void deleteMultiCartItem(List<Long> idx);
    List<CartItem> findAllCartItem(String user);
    List<WishItem> findAllWishItem(String user);
    void updateCartItem(@Param("itemId") Long itemId, @Param("cnt") int cnt);
}
