package com.example.test1.controller;

import com.example.test1.domain.Board;
import com.example.test1.domain.Criteria;
import com.example.test1.domain.Paging;
import com.example.test1.mapper.BoardMapper;
import com.example.test1.service.AttachService;
import com.example.test1.service.BoardService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.security.Principal;
import java.util.List;

@Controller
@Slf4j
@Transactional
public class BoardController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Resource
    BoardService boardService;
    @Resource
    AttachService attachService;

    @GetMapping("/board/write.do")
    public String boardForm() {
        return "board/write";
    }

    @PostMapping("/board/write.do")
    @ResponseBody
    public ModelAndView boardFormPost(Board board, Principal principal, Criteria cri) {
        String writer = principal.getName();
        board.setWriter(writer);
        boardService.insertBoard(board);
        if (!(board.getImageList() == null || board.getImageList().size() <= 0)) {
            board.getImageList().forEach(attach -> {
                boardService.imageEnroll(attach);
            });
        }
        ModelAndView mav = new ModelAndView("redirect:/board/myList");
        List<Board> bList = boardService.findByWriter(writer);
        mav.addObject("bList", bList);
        int total = boardService.getTotalByWriter(writer);
        Paging pageMake = new Paging(cri, total);

        mav.addObject("pageMaker", pageMake);
        return mav;
    }
    @GetMapping("/board/myList")
    public ModelAndView boardList(Principal user, Criteria cri) {
        String writer = user.getName();
        ModelAndView mav = new ModelAndView("/board/myList");
        List<Board> bList = boardService.getListPagingByWriter(writer, cri);
        mav.addObject("bList", bList);

        int total = boardService.getTotalByWriter(writer);
        Paging pageMake = new Paging(cri, total);

        mav.addObject("pageMaker", pageMake);
        return mav;
    }

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
    @RequestMapping(value="/board/update/{id}", method=RequestMethod.PUT)
    public ModelAndView updateSubmit(Board board, @PathVariable("id") Long id) {
        ModelAndView mav = new ModelAndView("redirect:/board/view/" + id);
        logger.info("updating");
        int result = boardService.updateBoard(board);
        if(result == 1 && board.getImageList() != null && board.getImageList().size() > 0) {
            attachService.deleteImageAll(board.getId());

            board.getImageList().forEach(attach -> {
                attach.setBId(board.getId());
                if (attach.getUuid() != null) {
                    attachService.imageReEnroll(attach);
                }


            });

        }
        return mav;
    }
    /* 게시글 삭제 페이지 */
    @RequestMapping(value="/board/delete/{id}", method = RequestMethod.DELETE)
    public ModelAndView boardDelete(@PathVariable("id") Long id) throws Exception {
        ModelAndView mav = new ModelAndView("redirect:/main");
        logger.info("delete ID : " + id);
        boardService.deleteBoard(id);
        return mav;
    }

    @ResponseBody
    @DeleteMapping("/board/multi/delete")
    public List<Long> deleteSubmit(@RequestBody List<Long> boardIdxArray){
        boardService.deleteMultiBoard(boardIdxArray);
        return boardIdxArray;
    }
    @GetMapping("/board/updateRecommend")
    @ResponseBody
    public int getCommentList(Principal principal, @RequestParam("id") Long id) throws Exception {
        String user = principal.getName();
        int isRecommend = boardService.hadRecommend(id, user);
        if (isRecommend != 1) {
            boardService.updateRecommend(id);
            boardService.saveRecommendBoard(id, user);
        }
        return isRecommend;
    }

}

