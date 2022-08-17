package com.example.test1.mapper;

import com.example.test1.domain.Order;
import com.example.test1.domain.OrderList;
import com.example.test1.domain.SecurityMember;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Repository
@Mapper
public interface AdminMapper {

    List<SecurityMember> findMemberList();
    SecurityMember findMember(String id);
    void deleteMember(String id);
    List<OrderList> selectOrderList();
    void updateOrderInfo(Order order);
    void updateOrderState(@Param("state") int state, @Param("orderId")String orderId);
}
