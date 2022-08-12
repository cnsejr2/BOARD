package com.example.test1.domain;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

import java.util.Date;

@Data
@Slf4j
public class Order {
    private String orderId;
    private String memberId;
    private String orderRec;
    private String addr1;
    private String addr2;
    private String addr3;
    private String phone;
    private int amount;
    private String orderDate;
}
