package com.example.test1.controller;

import com.example.test1.domain.*;
import com.example.test1.service.OrderService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.security.Principal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

@Controller
@Transactional
@Slf4j
public class OrderController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Resource
    OrderService orderService;

    @RequestMapping(value="/order/process/{orderId}", method = RequestMethod.GET)
    public ModelAndView processOrder2(Principal principal,
                                     @PathVariable("orderId") String orderId) throws Exception {
        String user = principal.getName();
        ModelAndView mav = new ModelAndView("/order/process");

        List<CartItem> cList = orderService.selectCartList(orderId);

        mav.addObject("orderId", orderId);
        mav.addObject("memberId", user);
        mav.addObject("cList", cList);
        return mav;
    }

    @PostMapping("/order/process")
    @ResponseBody
    public ModelAndView completeOrder(Order order, Principal principal) {
        ModelAndView mav = new ModelAndView("/order/complete");

        order.setPhone(phone_format(order.getPhone()));

        orderService.registerOrder(order);

        return mav;
    }

    public String phone_format(String number) {
        String regEx = "(\\d{3})(\\d{3,4})(\\d{4})";
        return number.replaceAll(regEx, "$1-$2-$3");
    }

    @PostMapping("/cart/order")
    @ResponseBody
    public String processOrder1(@RequestBody List<Long> itemIdxArray, Principal principal){

        String user = principal.getName();
        Calendar cal = Calendar.getInstance();
        int year = cal.get(Calendar.YEAR);
        String ym = year + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
        String ymd = ym +  new DecimalFormat("00").format(cal.get(Calendar.DATE));
        String subNum = "";

        for(int i = 1; i <= 6; i ++) {
            subNum += (int)(Math.random() * 10);
        }

        String orderId = ymd + subNum;

        String itemIds = "";
        for (Long i : itemIdxArray) {
//            orderService.updateCartItem(i);
            itemIds += (i + ",");
        }

        orderService.insertOrderItem(orderId, itemIds, user);

        return orderId;
    }


}
