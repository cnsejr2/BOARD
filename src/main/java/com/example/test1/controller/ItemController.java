package com.example.test1.controller;

import com.example.test1.domain.Board;
import com.example.test1.domain.Criteria;
import com.example.test1.domain.Item;
import com.example.test1.domain.Paging;
import com.example.test1.service.AttachService;
import com.example.test1.service.BoardService;
import com.example.test1.service.ItemImageService;
import com.example.test1.service.ItemService;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.security.Principal;
import java.util.List;

@Controller
@Slf4j
public class ItemController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Resource
    ItemService itemService;
    @Resource
    ItemImageService itemImageService;
//    @RequestMapping(value="/item/view/{id}", method = RequestMethod.GET)
//    public ModelAndView selectItemDetail(@PathVariable("id") Long id) throws Exception {
//        ModelAndView mav = new ModelAndView("/item/view");
//        logger.info("item ID : " + id);
//        Item item = itemService.selectItemDetail(id);
//        mav.addObject("item", item);
//        return mav;
//
//    }
    @GetMapping("/item/view")
    public String getIndex() {
        return "/item/view";
    }

    @RequestMapping("/item/list")
    public ModelAndView getMain(Criteria cri) throws Exception {
        ModelAndView mav = new ModelAndView("/item/list");

        List<Item> itemList = itemService.getListPaging(cri);
        mav.addObject("itemList", itemList);

//        int total = itemService.getTotal();
//        logger.info("total : " + total);
//        Paging pageMake = new Paging(cri, total);
//
//        mav.addObject("pageMaker", pageMake);

        return mav;
    }
}
