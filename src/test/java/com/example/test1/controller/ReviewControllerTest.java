package com.example.test1.controller;

import com.example.test1.domain.Review;
import com.example.test1.domain.ReviewFile;
import com.example.test1.mapper.ReviewMapper;
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
    @Test
    void insertReview() {
        Review review = new Review();
        review.setMemberId("1");
        review.setItemId(Long.valueOf("1"));
        review.setContent("111");

        reviewMapper.insertReview(review);
    }

    @Test
    void testInsertReview() {
//        List<Map<String, Object>> fileList = new ArrayList<Map<String, Object>>();
//        ReviewFile reviewFile = new ReviewFile();
//        reviewFile.setReviewId(Long.valueOf(1));
//        reviewFile.setOriginalFileName("window.jpg");
//        reviewFile.setFilePath("C:\\upload\\item");
//        reviewFile.setFileSize(Long.valueOf(1));
//        Map<String, Object> fileInfo = new HashMap<String, Object>();
//        fileList.add(fileInfo);
//        reviewMapper.fileEnroll(fileList.get(0));
        logger.info("Long" + reviewMapper.getReviewId());
    }
}