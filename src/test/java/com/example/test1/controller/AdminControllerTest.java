package com.example.test1.controller;

import com.example.test1.domain.OrderList;
import com.example.test1.mapper.AdminMapper;
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
class AdminControllerTest {

    @Resource
    AdminMapper adminMapper;

    @Test
    void adminOrderList() {
        OrderList orderList = new OrderList();
        orderList.setOrderId("1");
        orderList.setCartItemId(Long.parseLong("1"));
        orderList.setMemberId("1");
        orderList.setState(1);
        List<OrderList> oList = new ArrayList<>();
        oList.add(orderList);

        adminMapper.selectOrderList();



    }
}