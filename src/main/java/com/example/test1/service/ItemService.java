package com.example.test1.service;

import com.example.test1.domain.Board;
import com.example.test1.domain.Criteria;
import com.example.test1.domain.Item;
import com.example.test1.domain.ItemImage;
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

    public int hadItem(Long itemId, String mid) { return itemMapper.hadItem(itemId, mid); }
    public void saveCartItem(Map cartItem) { itemMapper.saveCartItem(cartItem); }
    public int hadWishItem(Long itemId, String mid) { return itemMapper.hadWishItem(itemId, mid); }
    public void saveWishItem(Long itemId, String mid) { itemMapper.saveWishItem(itemId, mid);}


}
