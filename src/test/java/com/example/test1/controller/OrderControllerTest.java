package com.example.test1.controller;

import com.example.test1.domain.CartItem;
import com.example.test1.mapper.OrderMapper;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

import java.util.ArrayList;
import java.util.List;


@RunWith(SpringRunner.class)
@SpringBootTest
class OrderControllerTest {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Resource
    OrderMapper orderMapper;
    @Test
    void processOrder() {
//        List<Long> itemIdxArray = new ArrayList<>();
//        itemIdxArray.add(Long.parseLong("13"));
//        itemIdxArray.add(Long.parseLong("14"));
//        itemIdxArray.add(Long.parseLong("15"));
        String itemIds = "12,13,14";
        orderMapper.insertOrderItem("20220811023445", itemIds, "user1");
    }

    @Test
    void processOrder1() {
        String orderItem = orderMapper.selectOrderItemId("20220812392234");
        String[] orderItemId = orderItem.split(",");
        logger.info("oII List : " + orderItemId);
        List<CartItem> cList = new ArrayList<>();
        for (String oItem : orderItemId) {
            cList.add(orderMapper.findCartItem(Long.parseLong(oItem)));
        }
        logger.info("cList : " + cList);
    }
}