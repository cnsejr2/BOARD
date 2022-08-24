package com.example.test1.controller;

import com.example.test1.domain.CartItem;
import com.example.test1.domain.Order;
import com.example.test1.domain.OrderList;
import com.example.test1.service.*;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Controller
@Slf4j
@EnableScheduling
public class AdminOrderController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Resource
    AdminService adminService;
    @Resource
    OrderService orderService;

    @GetMapping("/admin/order/list")
    public ModelAndView adminOrderList() {
        ModelAndView mav = new ModelAndView("/admin/order/list");

        List<OrderList> oList = adminService.selectOrderList();
        mav.addObject("oList", oList);

        return mav;
    }

    @GetMapping("/admin/order/info")
    public ModelAndView adminOrderInfo(@RequestParam("orderId") String orderId,
                                       @RequestParam("memberId") String memberId) {
        ModelAndView mav = new ModelAndView("/admin/order/info");

        List<CartItem> cList = orderService.selectCartList(orderId);

        Order order = orderService.selectOrder(orderId);
        mav.addObject("order", order);
        mav.addObject("cList", cList);
        return mav;
    }

    @PutMapping("/admin/order/info/update")
    public ModelAndView adminUpdateOrderInfo(Order order, @RequestParam("orderId") String orderId) {
        ModelAndView mav = new ModelAndView("redirect:/admin/order/list");
        logger.info("order : " + order);
        adminService.updateOrderInfo(order);
        return mav;
    }

    @PutMapping("/admin/order/state/update")
    @ResponseBody
    public String adminUpdateOrderState(@RequestParam("state") int state,
                                        @RequestParam("id") String orderId) {
        logger.info("컨트롤러 진입");
        logger.info("state : " + state);
        logger.info("orderId : " + orderId);

        adminService.updateOrderState(state, orderId);
        return "success";
    }

    @GetMapping("/admin/order/info/delete")
    public String adminDeleteOrder(@RequestParam("orderId") String orderId) {
        orderService.deleteOrder(orderId);
        return "redirect:/admin/order/list";
    }
}
