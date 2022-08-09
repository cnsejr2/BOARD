package com.example.test1.controller;

import com.example.test1.domain.Board;
import com.example.test1.domain.Criteria;
import com.example.test1.domain.Paging;
import com.example.test1.service.BoardService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.security.Principal;
import java.util.List;

@Controller
@Slf4j
public class MemberController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource
    BoardService boardService;

}
