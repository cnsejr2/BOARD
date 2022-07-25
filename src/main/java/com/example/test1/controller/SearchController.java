package com.example.test1.controller;

import com.example.test1.domain.Board;
import com.example.test1.service.BoardService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;
@Controller
@Slf4j
public class SearchController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Resource
    BoardService boardService;
    /* 검색 목록 불러오기 */
    @GetMapping("/getSearch")
    private ModelAndView getSearchList(@RequestParam(value = "keyword") String keyword,
                                       @RequestParam(required = false, defaultValue="id") String sort) throws Exception {
        ModelAndView mav = new ModelAndView("/board/searchResult");
        log.info("sort : " + sort);
        log.info("keyword : " + keyword);
        List<Board> bList = boardService.selectBoardSearchList(keyword, sort);
        mav.addObject("bList", bList);
        mav.addObject("keyword", keyword);
        mav.addObject("sort", sort);
        return mav;
    }
}
