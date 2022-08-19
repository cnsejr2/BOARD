package com.example.test1.controller;

import com.example.test1.domain.Comment;
import com.example.test1.domain.Criteria;
import com.example.test1.domain.Review;
import com.example.test1.domain.ReviewFile;
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

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
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
    FileUtils fileUtils;
    @GetMapping("/item/review/write.do")
    public String reviewForm() {
        return "review/write";
    }

    @RequestMapping(value = "/item/review/write.do", method = RequestMethod.POST)
    public String insertReview(Review review, MultipartFile[] file) throws IOException {
        for (int i = 0; i < file.length; i++) {
            logger.info("============== file start ================");
            logger.info("파일 이름 : " + file[i].getName());
            logger.info("파일 실제 이름 : " + file[i].getOriginalFilename());
            logger.info("파일 크기 : " + file[i].getSize());
            logger.info("contentType : " + file[i].getContentType());
            logger.info("============== file end  =================");
        }
        reviewService.insertReview(review);
        Long reviewId = reviewService.getReviewId();
        if (!(review.getReviewFileList() == null || review.getReviewFileList().size() <= 0)) {
            logger.info("review File List : " + review.getReviewFileList());
            review.getReviewFileList().forEach(attach ->{
                if (attach != null) {
                    reviewService.fileEnroll(attach);
                }
            });
        }
        List<ReviewFile> fileList = fileUtils.parseFileInfo(reviewId, file);
        for (int i = 0; i < fileList.size(); i++) {
            reviewService.fileEnroll(fileList.get(i));
        }
        return "redirect:/main";
    }

    @GetMapping("/getReviewList")
    @ResponseBody
    private List<Review> getReviewList(@RequestParam("itemId") Long itemId) throws Exception {
        List<Review> rList = reviewService.getReviewList(Long.valueOf(itemId));

        return reviewService.getReviewList(Long.valueOf(itemId));
    }

}
