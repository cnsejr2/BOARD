package com.example.test1.controller;

import com.example.test1.domain.*;
import com.example.test1.service.*;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.io.File;
import java.net.URLDecoder;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
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
    CommentService commentService;
    @Resource
    ItemService itemService;
    @Resource
    ItemImageService itemImageService;

    @GetMapping("/admin/board/list")
    public ModelAndView boardForm() {
        ModelAndView mav = new ModelAndView("/admin/myList");
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
        ModelAndView mav = new ModelAndView("security/profile");

        SecurityMember sMember = adminService.findMember(id);
        mav.addObject("member", sMember);
        Criteria boardCri = new Criteria(1, 5);
        Criteria commentCri = new Criteria(1, 5);
        Criteria wishCri = new Criteria(1, 5);
        int num = 0;
        if (type.equals("board")) {
            boardCri = cri;
        } else if (type.equals("comment")) {
            commentCri = cri;
            num = 1;
        } else if (type.equals("wish")) {
            wishCri = cri;
            num = 2;
        }

        List<Board> bList = boardService.getListPagingByWriter(id, boardCri);
        int bTotal = boardService.getTotalByWriter(id);
        mav.addObject("bList", bList);
        Paging pageMake = new Paging(boardCri, bTotal);
        mav.addObject("pageMake", pageMake);

        List<Comment> cList = commentService.findCommentPagingByWriter(id, commentCri);
        int cTotal = commentService.getTotalCommentByWriter(id);
        mav.addObject("cList", cList);
        Paging pageComMake = new Paging(commentCri, cTotal);
        mav.addObject("pageComMake", pageComMake);

        List<WishItem> wList = itemService.getListPagingWishItemById(id, wishCri);
        int wTotal = itemService.getTotalWishItemById(id);
        wList.forEach(item -> {

            Long itemId = item.getItemId();

            Item i = itemService.selectItemDetail(itemId);
            item.setItem(i);

            List<ItemImage> imageList = itemImageService.getItemImage(itemId);
            item.getItem().setImageList(imageList);


            logger.info("imageList : " + item.getItem().getImageList());

        });
        mav.addObject("wList", wList);
        Paging pageWishMake = new Paging(commentCri, wTotal);
        mav.addObject("pageWishMake", pageWishMake);

        mav.addObject("type", num);

        return mav;
    }

    @ResponseBody
    @DeleteMapping("/admin/member/delete")
    public String deleteWishSubmit(@RequestParam("id") String id) {
        adminService.deleteMember(id);
        return id;
    }

}
