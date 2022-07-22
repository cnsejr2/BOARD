package com.example.test1.controller;

import com.example.test1.domain.Board;
import com.example.test1.domain.Comment;
import com.example.test1.domain.Criteria;
import com.example.test1.domain.Paging;
import com.example.test1.service.AttachService;
import com.example.test1.service.BoardService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.io.File;
import java.net.URLDecoder;
import java.security.Principal;
import java.util.List;

@Controller
@Slf4j
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
    public ModelAndView boardFormPost(Board board, Principal principal) {
        String writer = principal.getName();
        board.setWriter(writer);
        boardService.insertBoard(board);
        ModelAndView mav = new ModelAndView("/board/myList");
        List<Board> bList = boardService.findByWriter(writer);
        mav.addObject("bList", bList);
        if(board.getImageList() == null || board.getImageList().size() <= 0) {
            return mav;
        }
        board.getImageList().forEach(attach ->{
            boardService.imageEnroll(attach);
        });
        return mav;
    }
    @GetMapping("/board/myList")
    public ModelAndView boardList(Principal principal, Criteria cri) {
        String writer = principal.getName();
        ModelAndView mav = new ModelAndView("/board/myList");
//        List<Board> bList = boardService.findByWriter(writer);
        List<Board> bList = boardService.getListPagingByWriter(writer, cri);
        mav.addObject("bList", bList);

        int total = boardService.getTotalByWriter(writer);
        logger.info("total : " + total);
        Paging pageMake = new Paging(cri, total);

        mav.addObject("pageMaker", pageMake);
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

    @Transactional
    @RequestMapping(value="/board/update/{id}", method=RequestMethod.PUT)
    public ModelAndView updateSubmit(Board board, @PathVariable("id") Long id) {
        ModelAndView mav = new ModelAndView("redirect:/board/view/" + id);
        logger.info("updating");
        int result = boardService.updateBoard(board);
        if(result == 1 && board.getImageList() != null && board.getImageList().size() > 0) {

            attachService.deleteImageAll(board.getId());

            board.getImageList().forEach(attach -> {

                attach.setBId(board.getId());
                attachService.imageReEnroll(attach);

            });

        }
        return mav;
    }
    /* 게시글 삭제 페이지 */
    @RequestMapping(value="/board/delete/{id}", method = RequestMethod.DELETE)
    public ModelAndView boardDelete(@PathVariable("id") Long id,
                                    @RequestParam("filename") String fileName) throws Exception {
        ModelAndView mav = new ModelAndView("redirect:/security/main");
        logger.info("delete ID : " + id);
        boardService.deleteBoard(id);
        File file = null;

        attachService.deleteImage(id);
        /* 썸네일 파일 삭제 */
        file = new File("C:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
        file.delete();

        /* 원본 파일 삭제 */
        String originFileName = file.getAbsolutePath().replace("s_", "");
        logger.info("originFileName : " + originFileName);
        file = new File(originFileName);
        file.delete();
        return mav;
    }

    @ResponseBody
    @DeleteMapping("/board/multi/delete")
    public List<Long> deleteSubmit(@RequestBody List<Long> boardIdxArray){
        log.info("boardIdxArray={}", boardIdxArray);
        boardService.deleteMultiBoard(boardIdxArray);
        return boardIdxArray;
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
        return mav;
    }

    /* 게시글 추천 */
    @GetMapping("/board/updateRecommend")
    @ResponseBody
    private int getCommentList(Principal principal, @RequestParam("id") Long id) throws Exception {
        String user = principal.getName();
        int isRecommend = boardService.hadRecommend(id, user);
        if (isRecommend != 1) {
            boardService.updateRecommend(id);
            boardService.saveRecommendBoard(id, user);
        }
        return isRecommend;
    }

}

