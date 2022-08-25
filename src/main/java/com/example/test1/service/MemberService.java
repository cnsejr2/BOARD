package com.example.test1.service;

import com.example.test1.domain.*;
import com.example.test1.mapper.MemberMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@Transactional
public class MemberService {
    @Resource
    MemberMapper memberMapper;
    @Resource
    BoardService boardService;
    @Resource
    CommentService commentService;
    @Resource
    ItemService itemService;
    @Resource
    ItemImageService itemImageService;

    public SecurityMember findMember(String id) { return memberMapper.findMember(id); }
    public List<OrderList> selectOrderList(String id) { return memberMapper.selectOrderList(id); }

    public HashMap<String, Object> makePaging(String id, String type, Criteria cri) {

        Criteria boardCri = new Criteria(1, 5);
        Criteria commentCri = new Criteria(1, 5);
        Criteria wishCri = new Criteria(1, 5);
        Criteria orderCri = new Criteria(1, 5);
        int num = 0;
        if (type.equals("board")) {
            boardCri = cri;
        } else if (type.equals("comment")) {
            commentCri = cri;
            num = 1;
        } else if (type.equals("wish")) {
            wishCri = cri;
            num = 2;
        } else if (type.equals("order")) {
            orderCri = cri;
            num = 3;
        }
        HashMap<String, Object> arr = new HashMap<>();

        List<Board> bList = boardService.getListPagingByWriter(id, boardCri);

        int bTotal = boardService.getTotalByWriter(id);
        Paging pageMake = new Paging(boardCri, bTotal);
        arr.put("bList", bList);
        arr.put("pageMake", pageMake);

        List<Comment> cList = commentService.findCommentPagingByWriter(id, commentCri);
        int cTotal = commentService.getTotalCommentByWriter(id);
        Paging pageComMake = new Paging(commentCri, cTotal);
        arr.put("cList", cList);
        arr.put("pageComMake", pageComMake);

        List<WishItem> wList = itemService.getListPagingWishItemById(id, wishCri);
        wList.forEach(item -> {

            Long itemId = item.getItemId();

            Item i = itemService.selectItemDetail(itemId);
            item.setItem(i);

            List<ItemImage> imageList = itemImageService.getItemImage(itemId);
            item.getItem().setImageList(imageList);

        });
        int wTotal = itemService.getTotalWishItemById(id);
        Paging pageWishMake = new Paging(commentCri, wTotal);
        arr.put("wList", wList);
        arr.put("pageWishMake", pageWishMake);

        List<OrderList> oList = selectOrderList(id);
        arr.put("oList", oList);

        arr.put("type", num);

        return arr;
    }
}
