package com.example.test1.controller;

import com.example.test1.domain.Board;
import com.example.test1.mapper.BoardMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;

@Controller
@Slf4j
public class AdminController {
    @Resource
    private BoardMapper boardMapper;

    @GetMapping("/admin/board/list")
    public ModelAndView boardForm() {
        ModelAndView mav = new ModelAndView("admin/list");
        List<Board> bList = boardMapper.findAll();
        mav.addObject("bList", bList);
        return mav;
    }
}
