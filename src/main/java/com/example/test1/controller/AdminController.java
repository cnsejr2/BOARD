package com.example.test1.controller;

import com.example.test1.domain.*;
import com.example.test1.service.*;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.*;

@Controller
@Slf4j
@EnableScheduling
public class AdminController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Resource
    AdminService adminService;
    @Resource
    BoardService boardService;
    @Resource
    MemberService memberService;

    @GetMapping("/admin/board/list")
    public ModelAndView boardForm() {
        ModelAndView mav = new ModelAndView("myBoard");
        List<Board> bList = boardService.findAll();
        mav.addObject("bList", bList);
        return mav;
    }
    @GetMapping("/admin/main")
    public ModelAndView adminMain() {
        ModelAndView mav = new ModelAndView("/admin/main");
        return mav;
    }
    @GetMapping("/admin/memberInfo")
    public ModelAndView adminMemberInfo() {
        ModelAndView mav = new ModelAndView("/admin/memberInfo");
        logger.info("service : " + adminService);
        List<SecurityMember> mList = adminService.findMemberList();
        mav.addObject("mList", mList);
        return mav;
    }

    @RequestMapping("/admin/profile/{id}")
    public ModelAndView viewMemberProfile(@PathVariable("id") String id,
                                          @RequestParam(value = "type", defaultValue = "") String type,
                                          Criteria cri) throws Exception {
        ModelAndView mav = new ModelAndView("member/profile");

        SecurityMember sMember = adminService.findMember(id);
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

    @ResponseBody
    @DeleteMapping("/admin/member/delete")
    public String deleteWishSubmit(@RequestParam("id") String id) {
        adminService.deleteMember(id);
        return id;
    }

}
