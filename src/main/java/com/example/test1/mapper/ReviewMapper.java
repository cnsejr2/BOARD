package com.example.test1.mapper;

import com.example.test1.domain.Criteria;
import com.example.test1.domain.Review;
import com.example.test1.domain.ReviewFile;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface ReviewMapper {

    List<Review> getReviewList(Review review, Criteria cri);
    int selectReviewCount(Review review);

    //글 등록 전 등록 될 일련번호 획득
    Long getReviewId();

    //디비에 파일 리스트 등록
    void insertReviewFileList(List<ReviewFile> fileList);
    void insertReview(Review review);
}
