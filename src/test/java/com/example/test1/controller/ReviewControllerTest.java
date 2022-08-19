package com.example.test1.controller;

import com.example.test1.domain.Review;
import com.example.test1.mapper.ReviewMapper;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.annotation.Resource;

import static org.junit.jupiter.api.Assertions.*;
@RunWith(SpringRunner.class)
@SpringBootTest
class ReviewControllerTest {

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
}