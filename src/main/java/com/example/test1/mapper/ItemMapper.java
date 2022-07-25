package com.example.test1.mapper;

import com.example.test1.domain.AttachImage;
import com.example.test1.domain.Criteria;
import com.example.test1.domain.Item;
import com.example.test1.domain.ItemImage;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface ItemMapper {

    List<Item> getListPaging(Criteria cri);
    Item selectItemDetail(Long item);
    void insertItem(Item item);
    void imageEnroll(ItemImage itemImage);

    List<Item> findAll();
}
