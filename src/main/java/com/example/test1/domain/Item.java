package com.example.test1.domain;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

import java.sql.Timestamp;
import java.util.List;

@Data
@Slf4j
public class Item {

    private Long id;
    private String name;
    private String info;
    private String itemSize;
    private String price;
    private String color;
    private String itemCategory;
    private Timestamp regDate;
    private List<ItemImage> imageList;
    private int star;

}
