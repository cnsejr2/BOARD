package com.example.test1.controller;

import com.example.test1.domain.*;
import com.example.test1.service.BoardService;
import com.example.test1.service.OrderService;
import com.example.test1.service.SecurityService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.security.Principal;
import java.util.List;

@Controller
@Slf4j
public class SecurityLoginController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Resource
    SecurityService securityService;
    @Resource
    BoardService boardService;

    @Resource
    OrderService orderService;

    @GetMapping("/security")
    public String getIndex() {
        return "security/index";
    }

    @RequestMapping("/main")
    public ModelAndView getMain(Principal principal, Criteria cri) throws Exception {
        ModelAndView mav = new ModelAndView("/main");
        String user = principal.getName();

        List<Board> bList = boardService.getListPaging(cri);
        mav.addObject("bList", bList);

        int total = boardService.getTotal();
        Paging pageMake = new Paging(cri, total);

        mav.addObject("pageMaker", pageMake);
        mav.addObject("user", user);

        return mav;
    }
    @GetMapping("/security/login")
    public String getLoginForm() {
        return "security/loginPage";
    }

    @GetMapping("/security/login/failure")
    public String getLoginFail() {
        return "security/loginFail";
    }

    @GetMapping("/security/login/insert")
    public String getJoin() {
        return "security/join";
    }

    @RequestMapping(value = "/security/login/insert", method = RequestMethod.POST)
    public String doJoin(SecurityMember member) {
        securityService.setInsertMember(member);
        return "security/loginPage";
    }

    @GetMapping("/error/error")
    public String goError() {
        return "/error/error";
    }

    @RequestMapping(value = "/security/login/insert/IdChk", method = RequestMethod.POST)
    @ResponseBody
    public String memberIdChkPOST(@RequestParam("id")String id) throws Exception{
        int result = securityService.idCheck(id);
        if(result != 0) {
            return "fail";	// 중복 아이디가 존재
        } else {
            return "success";	// 중복 아이디 x
        }

    }


}

