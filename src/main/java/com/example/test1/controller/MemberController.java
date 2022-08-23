package com.example.test1.controller;

import com.example.test1.domain.*;
import com.example.test1.service.*;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.security.Principal;
import java.util.List;

@Controller
@Slf4j
public class MemberController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource
    MemberService memberService;
    @Resource
    BoardService boardService;
    @Resource
    CommentService commentService;
    @Resource
    AttachService attachService;
    @Resource
    ItemService itemService;
    @Resource
    ItemImageService itemImageService;
    @Resource
    OrderService orderService;


    @GetMapping("/myProfile")
    public ModelAndView goMyProfile(Principal principal,
                                    @RequestParam(value = "type", defaultValue = "") String type,
                                    Criteria cri) throws Exception {
        ModelAndView mav = new ModelAndView("member/profile");

        String id = principal.getName();

        SecurityMember sMember = memberService.findMember(id);
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

        List<OrderList> oList = memberService.selectOrderList(id);
        mav.addObject("oList", oList);
        return mav;
    }

}
