package com.example.test1.domain;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Data
@Slf4j
public class OrderList {

    private String orderId;
    private Long cartItemId;
    private String memberId;
    private int state;
}
