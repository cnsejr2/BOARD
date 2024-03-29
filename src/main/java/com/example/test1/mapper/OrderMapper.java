package com.example.test1.mapper;

import com.example.test1.domain.CartItem;
import com.example.test1.domain.Order;
import com.example.test1.domain.OrderList;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface OrderMapper {

    void registerOrder(Order order);
    void insertOrderItem(@Param("orderId") String orderId, @Param("itemIds") String itemIdxArray, @Param("memberId") String memberId);
    String selectOrderItemId(String orderId);
    String selectOrderItemIdBymId(String orderId, String mId);
    CartItem findCartItem(Long cartItemId);
    Order selectOrder(String orderId);
    int hadCartItem(@Param("mId") String user);
    void deleteOrder(@Param("orderId") String orderId);
    void updateCartItem(Long cartItemId);
    List<OrderList> selectOrderListByMemberId(String memberId);

}
