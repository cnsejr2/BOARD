package com.example.test1.controller;

import com.example.test1.domain.*;
import com.example.test1.service.*;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Controller
@Slf4j
public class MemberController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource
    MemberService memberService;
    @Resource
    OrderService orderService;


    @GetMapping("/myProfile")
    public ModelAndView goMyProfile(Principal principal,
                                    @RequestParam(value = "type", defaultValue = "") String type,
                                    Criteria cri) throws Exception {
        ModelAndView mav = new ModelAndView("member/profile");

        String id = principal.getName();

        SecurityMember sMember = memberService.findMember(id);
        mav.addObject("member", sMember);

        HashMap<String, Object> arr = memberService.makePaging(id, type, cri);
        mav.addObject("bList", arr.get("bList"));
        mav.addObject("pageMake", arr.get("pageMake"));

        mav.addObject("cList", arr.get("cList"));
        mav.addObject("pageComMake", arr.get("pageComMake"));

        mav.addObject("wList", arr.get("wList"));
        mav.addObject("pageWishMake", arr.get("pageWishMake"));

        mav.addObject("oList", arr.get("oList"));

        mav.addObject("type", arr.get("type"));

        return mav;
    }

    @GetMapping("/profile/order/info")
    public ModelAndView memberOrderInfo(@RequestParam("orderId") String orderId,
                                        @RequestParam("memberId") String memberId,
                                        @RequestParam(value = "review" , required = false) String review) {
        ModelAndView mav = new ModelAndView("/order/info");

        List<CartItem> cList = orderService.selectCartList(orderId);

        Order order = orderService.selectOrder(orderId);
        mav.addObject("state", review);
        mav.addObject("order", order);
        mav.addObject("cList", cList);
        mav.addObject("review", review);
        return mav;
    }

}
