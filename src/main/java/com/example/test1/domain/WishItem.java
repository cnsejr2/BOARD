package com.example.test1.domain;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Data
@Slf4j
public class WishItem {
    private String mid;
    private Long itemId;
    private Item item;
}
