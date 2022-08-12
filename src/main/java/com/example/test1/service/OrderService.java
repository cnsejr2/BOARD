package com.example.test1.service;

import com.example.test1.domain.CartItem;
import com.example.test1.domain.Order;
import com.example.test1.mapper.OrderMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class OrderService {

    @Resource
    OrderMapper orderMapper;

    public void registerOrder(Order order) { orderMapper.registerOrder(order); }
    public void insertOrderItem(String orderId, List<Long> itemIdxArray, String memberId) { orderMapper.insertOrderItem(orderId, itemIdxArray, memberId); }
    public List<Long> selectOrderItemId(String orderId) { return orderMapper.selectOrderItemId(orderId); }
    public CartItem findCartItem(Long cartItemId) { return orderMapper.findCartItem(cartItemId); }

}
