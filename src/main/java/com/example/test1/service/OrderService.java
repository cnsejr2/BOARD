package com.example.test1.service;

import com.example.test1.domain.CartItem;
import com.example.test1.domain.Order;
import com.example.test1.domain.OrderList;
import com.example.test1.mapper.OrderMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service
public class OrderService {

    @Resource
    OrderMapper orderMapper;

    public void registerOrder(Order order) { orderMapper.registerOrder(order); }
    public void insertOrderItem(String orderId, String itemIds, String memberId) { orderMapper.insertOrderItem(orderId, itemIds, memberId); }
    public String selectOrderItemId(String orderId) { return orderMapper.selectOrderItemId(orderId); }
    public CartItem findCartItem(Long cartItemId) { return orderMapper.findCartItem(cartItemId); }
    public Order selectOrder(String orderId) { return orderMapper.selectOrder(orderId); }
    public int hadCartItem(String user) { return orderMapper.hadCartItem(user); }
    public void deleteOrder(String orderId) { orderMapper.deleteOrder(orderId); }
    public void updateCartItem(Long cartItemId) { orderMapper.updateCartItem(cartItemId); }


}
