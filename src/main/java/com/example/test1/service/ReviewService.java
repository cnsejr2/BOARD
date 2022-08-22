package com.example.test1.service;

import com.example.test1.domain.Review;
import com.example.test1.domain.ReviewFile;
import com.example.test1.mapper.ReviewMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Slf4j
@Service
@Transactional
public class ReviewService {

    @Resource
    ReviewMapper reviewMapper;

    //글 목록 조회
    public List<Review> getReviewList(Long itemId) { return reviewMapper.getReviewList(itemId); }

    public int selectReviewCount(Review review) { return reviewMapper.selectReviewCount(review); }

    //글 등록 전 등록 될 일련번호 획득
    public Long getReviewId() { return reviewMapper.getReviewId(); }

    //디비에 파일 리스트 등록
    public void fileEnroll(ReviewFile reviewFile) { reviewMapper.fileEnroll(reviewFile); }

    public void insertReview(Review review) { reviewMapper.insertReview(review); }

}
