package com.example.test1.controller;

import com.example.test1.domain.Criteria;
import com.example.test1.domain.Item;
import com.example.test1.domain.ItemImage;
import com.example.test1.service.ItemImageService;
import com.example.test1.service.ItemService;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@Slf4j
public class ItemController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Resource
    ItemService itemService;
    @Resource
    ItemImageService itemImageService;
    @GetMapping("/item/write.do")
    public String itemForm() {
        return "/item/write";
    }

    @PostMapping("/item/write.do")
    @ResponseBody
    public ModelAndView itemFormPost(Item item, Principal principal, Criteria cri) {
        item.setPrice("500,000");
        item.setColor("black");
        item.setItemCategory("Life");
        itemService.insertItem(item);
        logger.info("item: " + item);
        if (!(item.getImageList() == null || item.getImageList().size() <= 0)) {
            item.getImageList().forEach(attach ->{
                itemService.imageEnroll(attach);
            });
        }
        ModelAndView mav = new ModelAndView("redirect:/item/list");
        List<Item> itemList = itemService.findAll();
        mav.addObject("itemList", itemList);
        List<ItemImage> itemImageList = itemImageService.findAllImage();
        mav.addObject("itemImageList", itemImageList);
        logger.info("itemImageList.size() : " + itemImageList.size());
//        int total = itemService.getTotalByWriter(writer);
//        Paging pageMake = new Paging(cri, total);
//
//        mav.addObject("pageMaker", pageMake);
        return mav;
    }
    @RequestMapping(value="/item/view/{id}", method = RequestMethod.GET)
    public ModelAndView selectItemDetail(@PathVariable("id") Long id) throws Exception {
        ModelAndView mav = new ModelAndView("/item/view");
        Item item = itemService.selectItemDetail(id);

        Long itemId = item.getId();
        List<ItemImage> imageList = itemImageService.getItemImage(itemId);
        item.setImageList(imageList);
        mav.addObject("item", item);

        String iSize[] = item.getItemSize().split(", ");
        mav.addObject("iSize", iSize);

        String iColor[] = item.getColor().split(", ");
        mav.addObject("iColor", iColor);

        return mav;

    }

    @GetMapping("/item/list")
    public ModelAndView getMain(Criteria cri) throws Exception {
        ModelAndView mav = new ModelAndView("/item/list");

        List<Item> list = itemService.findAll();

//        int total = itemService.getTotal();
//        logger.info("total : " + total);
//        Paging pageMake = new Paging(cri, total);
//
//        mav.addObject("pageMaker", pageMake);
        list.forEach(item -> {

            Long itemId = item.getId();

            List<ItemImage> imageList = itemImageService.getItemImage(itemId);

            item.setImageList(imageList);

            logger.info("itemId : " + item.getImageList());

        });
        mav.addObject("itemList", list);
        return mav;
    }

    @GetMapping("/item/plusCartItem")
    @ResponseBody
    public int getCommentList(Principal principal,
                              @RequestParam("id") Long id,
                              @RequestParam("itemSize") String iSize,
                              @RequestParam("itemColor") String iColor) throws Exception {
        String user = principal.getName();
        int hadItem = itemService.hadItem(id, user);
        if (hadItem != 1) {
            Map<String, String> cartItem = new HashMap<String, String>();
            cartItem.put("memberId", user);
            cartItem.put("id", String.valueOf(id));
            cartItem.put("itemSize", iSize);
            cartItem.put("itemColor", iColor);
            itemService.saveCartItem(cartItem);
        }
        return hadItem;
    }

    @GetMapping("/item/hadWishItem")
    @ResponseBody
    public int hadWishItem(Principal principal, @RequestParam("id") Long id) throws Exception {
        String user = principal.getName();
        int hadWishItem = itemService.hadWishItem(id, user);
        if (hadWishItem != 1) {
            itemService.saveWishItem(id, user);
        }
        return hadWishItem;
    }
}
