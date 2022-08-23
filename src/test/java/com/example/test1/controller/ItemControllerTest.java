package com.example.test1.controller;

import com.example.test1.domain.ItemImage;
import com.example.test1.mapper.ItemMapper;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.annotation.Resource;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
@RunWith(SpringRunner.class)
@SpringBootTest
class ItemControllerTest {

    @Resource
    ItemMapper itemMapper;

    @Test
    void deleteSubmit() {
        List<Long> itemIdxArray = new ArrayList<>();
        itemIdxArray.add(Long.valueOf("22"));
        itemIdxArray.add(Long.valueOf("23"));

        itemMapper.deleteMultiCartItem(itemIdxArray);

    }

    @Test
    void itemFormPost() {

    }
}