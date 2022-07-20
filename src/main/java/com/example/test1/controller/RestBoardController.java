package com.example.test1.controller;

import com.example.test1.domain.Board;
import com.example.test1.service.BoardService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.security.Principal;
import java.util.List;

@Controller
public class RestBoardController {
    @Resource
    BoardService boardService;

    @RequestMapping(value="/rest/board/main", method= RequestMethod.GET)
    public ModelAndView viewBoardList() throws Exception {
        ModelAndView mav = new ModelAndView("/rest/board/main");

        List<Board> bList = boardService.findAll();
        mav.addObject("bList", bList);

        return mav;
    }

    @RequestMapping(value="/rest/board/write", method = RequestMethod.GET)
    public String openBoardWrite() throws Exception {
        return "/rest/board/write";
    }

    @RequestMapping(value = "/rest/board/write", method = RequestMethod.POST)
    public String insertBoard(Board board) throws Exception {
        boardService.insertBoard(board);
        return "redirect:/rest/board/main";
    }

    @RequestMapping(value="/rest/board/view/{id}", method = RequestMethod.GET)
    public ModelAndView viewBoard(Principal principal, @PathVariable("id") Long id) throws Exception {
        ModelAndView mav = new ModelAndView("/rest/board/view");
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


}
