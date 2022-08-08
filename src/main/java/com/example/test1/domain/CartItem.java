package com.example.test1.domain;

import lombok.Builder;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;

import java.sql.Timestamp;
import java.util.List;

@Data
@Slf4j
public class CartItem {

    private Long cartItemId;
    private String mid;
    private Long itemId;
    private String itemSize;
    private String itemColor;
    private String itemName;
    private int itemPrice;
    private int cnt;
    private List<ItemImage> ImageList;
}
