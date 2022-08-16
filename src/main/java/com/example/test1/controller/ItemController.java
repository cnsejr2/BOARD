package com.example.test1.controller;

import com.example.test1.domain.*;
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
import javax.servlet.http.HttpServletRequest;
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
        logger.info("item: " + item);
        logger.info("itemSize: " + item.getItemSize());
        itemService.insertItem(item);
        if (!(item.getImageList() == null || item.getImageList().size() <= 0)) {
            item.getImageList().forEach(attach ->{
                itemService.imageEnroll(attach);
            });
        }
        ModelAndView mav = new ModelAndView("redirect:/main");
        List<Item> itemList = itemService.findAll();
        mav.addObject("itemList", itemList);
        List<ItemImage> itemImageList = itemImageService.findAllImage();
        mav.addObject("itemImageList", itemImageList);

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

        String iSize[] = item.getItemSize().split(",");
        mav.addObject("iSize", iSize);

        String iColor[] = item.getColor().split(", ");
        mav.addObject("iColor", iColor);

        return mav;

    }

    @GetMapping("/item/list")
    public ModelAndView getMain(Criteria cri) throws Exception {
        ModelAndView mav = new ModelAndView("/item/list");

        List<Item> list = itemService.getListPaging(cri);

        int total = itemService.getTotal();
        logger.info("total : " + total);
        Paging pageMake = new Paging(cri, total);

        mav.addObject("pageMake", pageMake);
        list.forEach(item -> {

            Long itemId = item.getId();

            List<ItemImage> imageList = itemImageService.getItemImage(itemId);

            item.setImageList(imageList);

            logger.info("itemId : " + item.getImageList());

        });
        mav.addObject("itemList", list);
        return mav;
    }

    @GetMapping("/item/cart")
    public ModelAndView getCart(Principal principal, Criteria cri) throws Exception {
        String user = principal.getName();

        ModelAndView mav = new ModelAndView("/item/cart");

        List<CartItem> list = itemService.findAllCartItem(user);

        list.forEach(item -> {

            Long itemId = item.getItemId();

            List<ItemImage> imageList = itemImageService.getItemImage(itemId);

            item.setImageList(imageList);


            logger.info("imageList : " + item.getImageList());

        });
        mav.addObject("itemList", list);
        return mav;
    }

    @GetMapping("/item/saveCartItem")
    @ResponseBody
    public int getCommentList(Principal principal,
                              @RequestParam("id") Long id,
                              @RequestParam("itemSize") String iSize,
                              @RequestParam("itemColor") String iColor,
                              @RequestParam("itemCnt") String iCnt,
                              @RequestParam("itemName") String iName,
                              @RequestParam("itemPrice") String iPrice) throws Exception {
        String user = principal.getName();
        Map<String, String> cartItem = new HashMap<String, String>();
        cartItem.put("memberId", user);
        cartItem.put("id", String.valueOf(id));
        cartItem.put("itemSize", iSize);
        cartItem.put("itemColor", iColor);
        int hadItem = itemService.hadItem(cartItem);
        if (hadItem != 1) {
            cartItem.put("itemCnt", iCnt);
            cartItem.put("itemName", iName);
            cartItem.put("itemPrice", iPrice);
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

    @ResponseBody
    @DeleteMapping("/item/cart/multi/delete")
    public List<Long> deleteSubmit(@RequestBody List<Long> itemIdxArray){
        itemService.deleteMultiCartItem(itemIdxArray);
        return itemIdxArray;
    }

    @PutMapping(value = "/item/cart/update/{itemId}")
    @ResponseBody
    public String updateCartItem(@PathVariable("itemId") Long id,
                                 @RequestParam("cnt") int cnt) throws Exception {
        itemService.updateCartItem(id, cnt);
        logger.info("수정");
        return "redirect:/item/cart";
    }

    @GetMapping("/item/myWish")
    public ModelAndView goMyWish(Principal principal) {

        String user = principal.getName();

        ModelAndView mav = new ModelAndView("/item/wish");

        List<WishItem> list = itemService.findAllWishItem(user);

        list.forEach(item -> {

            Long itemId = item.getItemId();

            Item i = itemService.selectItemDetail(itemId);
            item.setItem(i);

            List<ItemImage> imageList = itemImageService.getItemImage(itemId);
            item.getItem().setImageList(imageList);


            logger.info("imageList : " + item.getItem().getImageList());

        });
        mav.addObject("itemList", list);
        return mav;
    }

    @ResponseBody
    @DeleteMapping("/wish/delete")
    public Long deleteWishSubmit(@RequestParam("id") Long id){
        itemService.deleteWishItem(id);
        return id;
    }
}
