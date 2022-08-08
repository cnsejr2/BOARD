package com.example.test1.service;

import com.example.test1.domain.*;
import com.example.test1.mapper.ItemMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class ItemService {

    @Resource
    ItemMapper itemMapper;

    public List<Item> getListPaging(Criteria cri) { return itemMapper.getListPaging(cri); }
    public Item selectItemDetail(Long id) { return itemMapper.selectItemDetail(id); }
    public void insertItem(Item item) { itemMapper.insertItem(item); }

    public void imageEnroll(ItemImage itemImage) { itemMapper.imageEnroll(itemImage); }

    public List<Item> findAll() { return itemMapper.findAll(); }

    public int hadItem(Map cItem) { return itemMapper.hadItem(cItem); }
    public void saveCartItem(Map cartItem) { itemMapper.saveCartItem(cartItem); }
    public int hadWishItem(Long itemId, String mid) { return itemMapper.hadWishItem(itemId, mid); }
    public void saveWishItem(Long itemId, String mid) { itemMapper.saveWishItem(itemId, mid);}
    public void deleteMultiCartItem(List<Long> idx) { itemMapper.deleteMultiCartItem(idx); }
    public List<CartItem> findAllCartItem(String user) { return itemMapper.findAllCartItem(user); }
    public List<WishItem> findAllWishItem(String user) { return itemMapper.findAllWishItem(user); }
    public void updateCartItem(Long id, int cnt) { itemMapper.updateCartItem(id, cnt); }


}
