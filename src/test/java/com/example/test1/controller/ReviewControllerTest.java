package com.example.test1.controller;

import com.example.test1.domain.Review;
import com.example.test1.domain.ReviewFile;
import com.example.test1.mapper.ReviewFileMapper;
import com.example.test1.mapper.ReviewMapper;
import com.example.test1.service.ReviewFileService;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.annotation.Resource;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;
@RunWith(SpringRunner.class)
@SpringBootTest
class ReviewControllerTest {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Resource
    ReviewMapper reviewMapper;
    @Resource
    ReviewFileMapper reviewFileMapper;
    @Test
    void insertReview() {
        Review review = new Review();
        review.setMemberId("user1");
        review.setItemId(Long.valueOf(1));
        review.setItemId(Long.valueOf("1"));
        review.setContent("111");

        reviewMapper.insertReview(review);
    }

    @Test
    void testInsertReview() {
        List<Review> rList = reviewMapper.getReviewList(Long.valueOf("85"));
        rList.forEach(review -> {
            Long reviewId = review.getReviewId();
            List<ReviewFile> reFileList = reviewFileMapper.getReviewFile(reviewId);
            review.setReviewFileList(reFileList);
            logger.info("이미지 : " + review.getReviewFileList());
        });
        logger.info("Long" + reviewMapper.getReviewId());
    }

}