package com.example.test1.controller;

import com.example.test1.domain.Board;
import com.example.test1.domain.Comment;
import com.example.test1.service.BoardService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.security.Principal;
import java.util.List;

@Controller
@Slf4j
public class BoardController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Resource
    BoardService boardService;

    @GetMapping("/board/write.do")
    public String boardForm() {
        return "board/write";
    }

    @PostMapping("/board/write.do")
    @ResponseBody
    public ModelAndView boardFormPost(Board board, Principal principal) {
        String writer = principal.getName();
        board.setWriter(writer);
        boardService.insertBoard(board);
        ModelAndView mav = new ModelAndView("/board/myList");
        List<Board> bList = boardService.findByWriter(writer);
        logger.info(String.valueOf(bList.get(0)));
        mav.addObject("bList", bList);
        return mav;
    }
    @GetMapping("/board/myList")
    public ModelAndView boardList(Principal principal) {
        String writer = principal.getName();
        ModelAndView mav = new ModelAndView("/board/myList");
        List<Board> bList = boardService.findByWriter(writer);
        mav.addObject("bList", bList);
        return mav;
    }
    /* 게시글 상세 페이지 */
    @RequestMapping(value="/board/view/{id}", method = RequestMethod.GET)
    public ModelAndView selectBoardDetail(Principal principal, @PathVariable("id") Long id) throws Exception {
        ModelAndView mav = new ModelAndView("/board/view");
        logger.info("VIEW ID : " + id);
        Board board = boardService.selectBoardDetail(id);
        boardService.viewCntBoard(board);
        mav.addObject("board", board);
        if (board.getWriter().equals(principal.getName())) {
            mav.addObject("isWriter", 1);
        } else {
            mav.addObject("isWriter", 0);
        }
        return mav;

    }
    @RequestMapping(value="/board/update/{id}", method=RequestMethod.GET)
    public ModelAndView updateForm(@PathVariable("id") Long id) {
        ModelAndView mav = new ModelAndView("/board/updateViewForm");
        Board board = boardService.selectBoardDetail(id);
        mav.addObject("board", board);
        return mav;
    }

    @RequestMapping(value="/board/update/{id}", method=RequestMethod.POST)
    public ModelAndView updateSubmit(Board board, @PathVariable("id") Long id) {
        ModelAndView mav = new ModelAndView("redirect:/board/view/" + id);
        boardService.updateBoard(board);
        return mav;
    }
    /* 게시글 삭제 페이지 */
    @RequestMapping(value="/board/delete/{id}", method = RequestMethod.GET)
    public ModelAndView boardDelete(@PathVariable("id") Long id) throws Exception {
        ModelAndView mav = new ModelAndView("security/main");
        logger.info("delete ID : " + id);
        boardService.deleteBoard(id);
        return mav;
    }

    /* 검색 목록 불러오기 */
    @GetMapping("/getSearchList")
    private ModelAndView getSearchList(@RequestParam("keyword") String keyword,
                                        @RequestParam(required = false, defaultValue="id") String sort) throws Exception {
        ModelAndView mav = new ModelAndView("/board/searchResult");
        logger.info("keyword : " + keyword);
        List<Board> bList = boardService.selectBoardSearchList(keyword, sort);
        mav.addObject("bList", bList);
        mav.addObject("keyword", keyword);
        mav.addObject("sort", sort);
        logger.info("bList : " + bList);
        return mav;
    }

    /* 게시글 추천 */
    @GetMapping("/board/updateRecommend")
    @ResponseBody
    private int getCommentList(Principal principal, @RequestParam("id") Long id) throws Exception {
        String user = principal.getName();
        int isRecommend = boardService.wasRecommend(id, user);
        if (isRecommend != 1) {
            boardService.updateRecommend(id);
            boardService.saveRecommendBoard(id, user);
        }
        return isRecommend;
    }

}

