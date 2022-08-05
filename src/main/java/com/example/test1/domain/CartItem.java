package com.example.test1.domain;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

import java.sql.Timestamp;
import java.util.List;

@Data
@Slf4j
public class CartItem {

    private String mid;
    private Long itemId;
    private String itemSize;
    private String itemColor;
    private int cnt;
    private Item item;
    private List<ItemImage> ImageList;
}
