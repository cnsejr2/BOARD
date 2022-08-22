package com.example.test1.controller;

import com.example.test1.domain.*;
import com.example.test1.service.ReviewFileService;
import com.example.test1.service.ReviewService;
import com.example.test1.util.FileUtils;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@Controller
@Slf4j
public class ReviewController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Resource
    ReviewService reviewService;
    @Resource
    ReviewFileService reviewFileService;
    @Resource
    FileUtils fileUtils;
    @GetMapping("/item/{id}/review/write.do")
    public ModelAndView reviewForm(@PathVariable("id") Long id) {
        ModelAndView mav = new ModelAndView("review/write");
        mav.addObject("itemId", id);
        return mav;
    }

    @RequestMapping(value = "/item/{itemId}/review/write.do", method = RequestMethod.POST)
    public String insertReview(Principal principal, Review review, MultipartFile[] file) throws IOException {
        for (int i = 0; i < file.length; i++) {
            logger.info("============== file start ================");
            logger.info("파일 이름 : " + file[i].getName());
            logger.info("파일 실제 이름 : " + file[i].getOriginalFilename());
            logger.info("파일 크기 : " + file[i].getSize());
            logger.info("contentType : " + file[i].getContentType());
            logger.info("============== file end  =================");
        }
        String user = principal.getName();
        review.setMemberId(user);
        reviewService.insertReview(review);
        Long reviewId = reviewService.getReviewId();

        List<ReviewFile> fileList = fileUtils.parseFileInfo(reviewId, file);
        for (int i = 0; i < fileList.size(); i++) {
            reviewService.fileEnroll(fileList.get(i));
        }
        review.setReviewFileList(fileList);
        return "redirect:/main";
    }

    @GetMapping("/getReviewList")
    @ResponseBody
    private List<Review> getReviewList(@RequestParam("itemId") Long itemId) throws Exception {
        List<Review> rList = reviewService.getReviewList(Long.valueOf(itemId));
        rList.forEach(review -> {
            Long reviewId = review.getReviewId();
            List<ReviewFile> reFileList = reviewFileService.getReviewFile(reviewId);
            review.setReviewFileList(reFileList);
            logger.info("이미지 : " + review.getReviewFileList());
        });
        return rList;
    }

}
