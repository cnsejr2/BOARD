package com.example.test1.controller;

import com.example.test1.domain.Board;
import com.example.test1.domain.Criteria;
import com.example.test1.domain.Paging;
import com.example.test1.domain.SecurityMember;
import com.example.test1.service.BoardService;
import com.example.test1.service.SecurityService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

@Controller
@Slf4j
public class SecurityLoginController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Resource
    SecurityService securityService;
    @Resource
    BoardService boardService;

    @GetMapping("/security")
    public String getIndex() {
        return "security/index";
    }

    @RequestMapping("/security/main")
    public ModelAndView getMain(Criteria cri) throws Exception {
        ModelAndView mav = new ModelAndView("/index");

        List<Board> bList = boardService.getListPaging(cri);
        mav.addObject("bList", bList);

        int total = boardService.getTotal();
        logger.info("total : " + total);
        Paging pageMake = new Paging(cri, total);

        mav.addObject("pageMaker", pageMake);
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
